import 'package:flutter/foundation.dart';
import 'package:observ/observ.dart';

/// [Observ] is just an abstract class for holding the package settings and
/// debug method.
@immutable
abstract final class Observ {
  /// Set this to true to flood your debugging console logs
  ///
  /// ```dart
  /// void main() {
  ///   Observ.enableConsoleOutput = true;
  ///   ...
  ///   runApp(const MainApp());
  /// }
  /// ```
  static bool enableConsoleOutput = false;

  /// The debug method for printing to the debugging console, internal use only.
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
