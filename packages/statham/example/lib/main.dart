import 'package:statham/statham.dart';

void main() {
  final SomeParentClass parent = SomeParentClass(
    someChildClass: SomeClass(
      startedAt: DateTime.now().subtract(const Duration(days: 2)),
      duration: 2,
    ),
  );

  final json = parent.toJson();
  print(json);
}

class SomeParentClass {
  final SomeClass someChildClass;

  SomeParentClass({required this.someChildClass});

  Json toJson([String? key]) => key != null
      ? {
          key: toJson(),
        }
      : {
          "some_child_class": someChildClass.toJson(),
          ...someChildClass.toJson("same_child_class"),
        };
}

final class SomeClass {
  final DateTime startedAt;
  final int duration;

  const SomeClass({required this.startedAt, required this.duration});

  const SomeClass.fromValues({required this.startedAt, required this.duration});

  Json toJson([String? key]) => key != null
      ? {
          key: toJson(),
        }
      : {
          ...startedAt.toJson("started_at"),
          "duration": duration.toJson(),
        };
}
