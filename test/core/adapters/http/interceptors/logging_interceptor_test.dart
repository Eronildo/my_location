import 'dart:io' hide HttpResponse;

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart' as http_mock;
import 'package:my_location/core/adapters/http/dio_adapter.dart';
import 'package:my_location/core/adapters/http/http_adapter.dart';
import 'package:my_location/core/adapters/http/interceptors/logging_interceptor.dart';

void main() {
  late DioAdapter dioAdapter;
  late http_mock.DioAdapter mockHttpDioAdapter;
  final loggingInterceptor = LoggingInterceptor();
  const baseUrl = 'https://google.com';

  final headers = <String, dynamic>{
    'accept': 'application/json',
    'content-type': 'application/json',
  };

  setUp(() {
    mockHttpDioAdapter = http_mock.DioAdapter(
      dio: Dio(
        BaseOptions(baseUrl: baseUrl, headers: headers),
      ),
    );

    dioAdapter = DioAdapter(dioOverride: mockHttpDioAdapter.dio);

    mockHttpDioAdapter.dio.interceptors.add(loggingInterceptor);
  });

  test('Retrieves data', () async {
    const path = 'path-test';
    final responseData = <String, dynamic>{'data': 'Success!'};

    mockHttpDioAdapter.onGet(
      path,
      (server) => server.reply(HttpStatus.ok, responseData),
    );

    final response = await dioAdapter.get<ResponseMapType>(path);
    expect(response.data, responseData);
  });

  test(
    'Retrieves data and an error occurs',
    () {
      const path = '404-get-request-test';

      mockHttpDioAdapter.onGet(
        path,
        (server) => server.reply(
          HttpStatus.notFound,
          {'error': 'no data returned!'},
        ),
      );

      expect(
        () => dioAdapter.get<ResponseMapType>(path),
        throwsA(isA<DioException>()),
      );
    },
  );
}
