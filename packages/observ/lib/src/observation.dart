import 'package:flutter/foundation.dart';

/// A class extending an [Observation] describes an event and the information
/// associated to it.
base class Observation {
  final DateTime _timestamp = DateTime.timestamp();

  final String _qualifier;
  String get qualifier => _qualifier;

  Observation(this._qualifier);

  @override
  String toString() => toJson().toString();

  @mustCallSuper
  Map<String, dynamic> toJson() => {
        "timestamp": _timestamp.toIso8601String(),
        "qualifier": _qualifier,
      };
}
