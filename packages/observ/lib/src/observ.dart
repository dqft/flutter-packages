import 'package:flutter/foundation.dart';
import 'package:observ/observ.dart';

abstract final class Observ {
  static bool enableConsoleOutput = false;
  static void debug(Observation observation, Observable from, dynamic to) {
    if (Observ.enableConsoleOutput && kDebugMode) {
      debugPrint("""
${observation.runtimeType}
- observer/handler: $to
- observable: $from
- observation: $observation
      """);
    }
  }
}
