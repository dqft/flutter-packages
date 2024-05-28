import 'package:flutter/foundation.dart';
import 'package:statham/statham.dart';

typedef Handler = Function(
  Observation, {
  required Observable from,
  required Observer to,
});

/// [Observ] is just an abstract class for holding the package settings and
/// debug method.
abstract final class Observ {
  /// Set this to true to flood your debugging console logs
  ///
  /// ```dart
  /// void main() {
  ///   Observ.debugMode = true;
  ///   ...
  ///   runApp(const MainApp());
  /// }
  /// ```
  static bool debugMode = false;

  static Handler? debugFunc;

  static void _handle(
    Observation observation, {
    required Observable from,
    required Observer to,
  }) {
    if (!debugMode) return;
    if (debugFunc != null) {
      debugFunc!(observation, from: from, to: to);
      return;
    }
    print({
      "from": from,
      "to": to,
      "observation": observation,
    }.toString());
  }
}

/// [Observer] is a mixin for classes that need to handle some [Observation]
/// events from their children.
mixin Observer {
  @nonVirtual
  void _handle(
    Observation observation, {
    required Observable from,
    required Observer to,
  }) {
    Observ._handle(observation, from: from, to: to);

    // Handover to user-defined handler method
    Future.microtask(() => handle(observation, from: from, to: to));
  }

  void handle(
    Observation observation, {
    required Observable from,
    required Observer to,
  });
}

/// [Observable] is a mixin for classes that need to notify their parent class
/// with some [Observation] events.
mixin Observable {
  Observer get observer;

  @nonVirtual
  void notify(Observation observation) {
    Future.microtask(() => observer._handle(
          observation,
          from: this,
          to: observer,
        ));
  }
}

/// [Observation] describes an event and the information associated to it.
/// It can be extended to support any business event.
@immutable
base class Observation {
  final DateTime _timestamp = DateTime.timestamp();
  final String _qualifier;

  Observation(this._qualifier);

  @override
  String toString() => toJson().toString();

  @mustCallSuper
  Json toJson() => {
        "timestamp": _timestamp.toIso8601String(),
        "qualifier": _qualifier,
      };
}
