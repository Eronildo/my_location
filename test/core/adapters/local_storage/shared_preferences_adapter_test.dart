import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_location/core/adapters/local_storage/shared_preferences_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late final SharedPreferencesAdapter sharedPreferencesAdapter;
  late final MockSharedPreferences mockSharedPreferences;
  const localStorageKey = 'storage_key';

  setUpAll(() {
    mockSharedPreferences = MockSharedPreferences();
    sharedPreferencesAdapter = SharedPreferencesAdapter(mockSharedPreferences);
  });

  group('Get Method', () {
    test(
        'given a local storage key when get be called then should '
        'get a map object', () {
      // Arrange:
      when(() => mockSharedPreferences.getString(localStorageKey))
          .thenReturn('{}');
      // Act:
      final result = sharedPreferencesAdapter.get(localStorageKey);

      // Assert:
      expect(result, <dynamic, dynamic>{});
    });
  });

  group('Save Method', () {
    test('given a key and a value when save be called then should return true',
        () async {
      // Arrange:
      when(() => mockSharedPreferences.setString(localStorageKey, '{}'))
          .thenAnswer((_) async => true);

      // Act:
      final result = await sharedPreferencesAdapter.save(localStorageKey, {});

      // Assert:
      expect(result, isTrue);
    });

    test('given a key and a value when save be called then should return false',
        () async {
      // Arrange:
      when(() => mockSharedPreferences.setString(localStorageKey, '{}'))
          .thenAnswer((_) async => false);

      // Act:
      final result = await sharedPreferencesAdapter.save(localStorageKey, {});

      // Assert:
      expect(result, isFalse);
    });
  });

  group('Remove Method', () {
    test('given a key when remove be called then should return true', () async {
      // Arrange:
      when(() => mockSharedPreferences.remove(localStorageKey))
          .thenAnswer((_) async => true);

      // Act:
      final result = await sharedPreferencesAdapter.remove(localStorageKey);

      // Assert:
      expect(result, isTrue);
    });

    test('given a key when remove be called then should return false',
        () async {
      // Arrange:
      when(() => mockSharedPreferences.remove(localStorageKey))
          .thenAnswer((_) async => false);

      // Act:
      final result = await sharedPreferencesAdapter.remove(localStorageKey);

      // Assert:
      expect(result, isFalse);
    });
  });
}
