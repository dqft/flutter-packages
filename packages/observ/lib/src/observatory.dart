import 'package:flutter/foundation.dart';
import 'package:observ/observ.dart';

/// [Observatory] is the combination of both the [Observer] and the
/// [Observable].
@immutable
mixin Observatory implements Observer, Observable {
  @override
  late final Observer observer = this;

  @override
  @nonVirtual
  void notify(Observation observation, {Observer? to}) {
    Future.microtask(() => Observ.debug(observation, this, to));
    Future.microtask(() => (to ?? observer).notified(observation, from: this));
  }

  @override
  @nonVirtual
  @protected
  void notified(Observation observation, {required Observable from}) {
    Future.microtask(() => Observ.debug(observation, from, this));
    Future.microtask(() => observe(observation, from: from));
  }

  @override
  @nonVirtual
  void forward(
    Observation observation, {
    required Observable from,
    required Observer to,
  }) {
    Future.microtask(() => to.notified(observation, from: from));
  }
}
