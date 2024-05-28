# `observ`

An event-oriented package.
Rely on events to ensure app reactivity while triggering long calls in the background.

## Getting started

Import the package:

```dart
import 'package:observ/observ.dart';
```

## Usage

See example (needs to be rewritten following version 0.1.0).

## Additional information

You can enable console logging at development time:

```dart
void main() {
  Observ.debugMode = true;
  ...
  runApp(const MainApp());
}
```

## About this package

This package is heavily inspired from a great [article](https://itnext.io/mvvm-in-flutter-from-scratch-17757b6433eb) from [Martin Nowosad](https://github.com/MrIceman).