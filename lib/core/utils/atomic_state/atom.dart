// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/foundation.dart';

/// [Atom] is a [ChangeNotifier]
///
/// Atom can be used as a state or an action
/// It is part of the atomic state pattern
///
/// See more in https://github.com/Flutterando/rx_notifier.
class Atom<T> extends ChangeNotifier implements ValueListenable<T> {
  /// [Atom] constructor
  ///
  /// Requires a [value].
  Atom(this._value);

  T _value;

  /// Create a [Atom] without value
  ///
  /// Like a method, used [call] to notify your listeners.
  static Atom<NoValue> action() => Atom(const NoValue());

  /// Update the value
  /// Same as atom.value = newValue.
  void setValue(T newValue) {
    value = newValue;
  }

  /// To be used like a method, is the same as update the [value].
  ///
  /// This will notify your listeners.
  void call([T? newValue]) => value = newValue ?? value;

  @override
  T get value => _value;

  set value(T newValue) {
    _value = newValue;
    notifyListeners();
  }
}

/// [NoValue] class
///
/// Used in Atom.action() to create a valueless [Atom].
class NoValue {
  /// [NoValue] constructor.
  const NoValue();
}
