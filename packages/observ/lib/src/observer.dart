import 'package:flutter/foundation.dart';
import 'package:observ/observ.dart';

/// [Observer] is a mixin for classes that need to observe some [Observation]
/// events.
@immutable
mixin Observer {
  void observe(Observation observation, {required Observable from});

  @nonVirtual
  @protected
  void notified(Observation observation, {required Observable from}) {
    Observ.debug(observation, from, this);
    observe(observation, from: from);
  }

  @nonVirtual
  void forward(
    Observation observation, {
    required Observable from,
    required Observer to,
  }) {
    Future.microtask(() => to.notified(observation, from: from));
  }
}
