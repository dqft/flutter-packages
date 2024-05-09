import 'package:flutter/foundation.dart';
import 'package:observ/observ.dart';

/// [Observable] is a mixin for classes that just need to trigger some
/// [Observation] to an [Observer].
@immutable
mixin Observable {
  Observer get observer;

  @nonVirtual
  void notify(Observation observation, {Observer? to}) {
    Future.microtask(() => Observ.debug(observation, this, to));
    Future.microtask(() => (to ?? observer).observe(observation, from: this));
  }
}
