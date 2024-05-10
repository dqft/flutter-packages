import 'package:flutter/foundation.dart';
import 'package:statham/json.dart';

void main() {
  final SomeParentClass parent = SomeParentClass(
    someChildClass: SomeClass(
      startedAt: DateTime.now().subtract(const Duration(days: 2)),
      duration: 2,
    ),
  );

  final json = parent.toJson();
  print(json);

  /// Adds the parser for [SomeClass]
  JsonModifiers.jsons.addAll({SomeClass: SomeClass.fromJson});

  final parentParsed = SomeParentClass.fromJson(json);
  print(parentParsed.toJson());
}

class SomeParentClass {
  final SomeClass someChildClass;

  SomeParentClass({required this.someChildClass});

  Json toJson([String? key]) => key != null
      ? {key: toJson()}
      : {
          "some_child_class": someChildClass.toJson(),
          ...someChildClass.toJson("same_child_class"),
        };

  static SomeParentClass fromJson(Json json) {
    // Either we added the correct parser
    final SomeClass some = json.fromKey("some_child_class");

    // Or we uncomment this line and keep it old school.
    // final SomeClass some = SomeClass.fromJson(json["some_child_class"]);

    return SomeParentClass(someChildClass: some);
  }
}

@immutable
final class SomeClass {
  final DateTime startedAt;
  final int duration;

  const SomeClass({required this.startedAt, required this.duration});

  const SomeClass.fromValues({required this.startedAt, required this.duration});

  static SomeClass fromJson(Json json) {
    final DateTime startedAt = json.fromKey("started_at");
    final int duration = json.fromKey("duration");

    return SomeClass.fromValues(startedAt: startedAt, duration: duration);
  }

  Json toJson([String? key]) => key != null
      ? {key: toJson()}
      : {
          ...startedAt.toJson("started_at"),
          "duration": duration.toJson(),
        };
}
