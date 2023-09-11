import 'dart:async';

import 'package:flutter/foundation.dart';

import 'atom.dart';

/// This class is responsible for making a business decisions
/// to perform actions and modify Atoms;
/// ```dart
///
/// final counterState = Atom(0);
/// final incrementAction = Atom.action();
///
/// class CounterReducer extends Reducer {
///
///   CounterReducer() {
///     on(incrementAction, _increment);
///   }
///
///   void _increment(_) {
///     counterState.value++;
///   }
/// }
///
/// // in widget:
/// ...
/// onPressed: () => incrementAction();
/// ```
/// See more in https://github.com/Flutterando/rx_notifier.
abstract class Reducer {
  final _atomsListeners = <(Atom<dynamic> atom, VoidCallback listener)>[];

  /// Subscribe atoms:
  /// ```dart
  /// on(incrementAction, (_) => counterState.value++);
  /// ```
  void on<T>(
    Atom<T> atom,
    ReducerCallback<T> reducer,
  ) {
    FutureOr<void> listener() => reducer(atom.value);
    atom.addListener(listener);
    _atomsListeners.add((atom, listener));
  }

  /// Dispose all [Atom]'s listeners.
  void dispose() {
    for (final atomListener in _atomsListeners) {
      final (atom, listener) = atomListener;
      atom.removeListener(listener);
    }
    _atomsListeners.clear();
  }
}

/// [Reducer] callback.
typedef ReducerCallback<T> = FutureOr<void> Function(T value);
