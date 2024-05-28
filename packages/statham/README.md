<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# `statham`

Json support with a KISS (Keep It Simple & Stupid) approach.
Gives some ability to parse and export into json, without the need of a package that
requires annotations in order to do the "magic" in part files.

## Features

- `Json` alias for representing `Map<String, dynamic> json`
- `T toJson<T>([String? key])` added to `bool`, `DateTime`, `int` and `String`

## Getting started

Import the package:

```dart
import 'package:statham/statham.dart';
```

## Usage

See `/example` for a longer example.

```dart
final startedAt = DateTime.timestamp();
final int duration = 2;
final fakeNews = false;

final Json json = {
...startedAt.toJson("started_at"),
...duration.toJson("duration"),
...fakeNews.toJson("is_fakes_news"),
};

print(json);
```

## Additional information

Reach out to me on Github if anything.
