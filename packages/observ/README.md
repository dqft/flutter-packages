# `observ`

Event-oriented package.

## Getting started

Import the package:

```dart
import 'package:observ/observ.dart';
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:observ/observ.dart';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyScaffold(),
    );
  }
}

class MyScaffold extends StatefulWidget {
  const MyScaffold({super.key});

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> with Observer {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My App"),
        leading: MyAppBarIcon(icon: _icon),
      ),
      body: MyBody(observer: this),
    );
  }

  Icon _icon = const Icon(Icons.home);

  @override
  void observe(Observation observation, {Observable? from}) {
    switch (observation) {
      case IconPicked _:
        setState(() => _icon = observation.icon);
    }
  }
}

class MyBody extends StatefulWidget with Observable {
  const MyBody({
    super.key,
    required this.observer,
  });

  @override
  State<MyBody> createState() => _MyBodyState();

  @override
  final Observer observer;
}

class _MyBodyState extends State<MyBody> with Observatory {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => notify(ButtonClicked()),
            child: const Text("Click!"),
          ),
          const SizedBox(height: 16),
          Text("This button got clicked $_clicksCount."),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: _icons
                .map((e) => IconButton(
                      onPressed: () => notify(IconPicked(e)),
                      icon: e,
                      isSelected: e == _lastIconClicked,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }

  int _clicksCount = 0;

  final List<Icon> _icons = [
    const Icon(Icons.abc),
    const Icon(Icons.favorite),
    const Icon(Icons.headphones),
  ];

  Icon? _lastIconClicked;

  @override
  void observe(Observation observation, {Observable? from}) {
    switch (observation) {
      case ButtonClicked _:
        setState(() => _clicksCount++);
      case IconPicked _:
        setState(() {
          _lastIconClicked = observation.icon;
          forward(observation, from: this, to: widget.observer);
        });
    }
  }
}

final class ButtonClicked extends Observation {
  ButtonClicked() : super("Button got clicked");
}

final class IconPicked extends Observation {
  final Icon icon;
  IconPicked(this.icon) : super("Icon $icon got picked");
}

class MyAppBarIcon extends StatelessWidget {
  final Icon _icon;
  const MyAppBarIcon({super.key, required Icon icon}) : _icon = icon;

  @override
  Widget build(BuildContext context) {
    return _icon;
  }
}
```

## Additional information

You can enable console logging at development time:

```dart
void main() {
  Observ.enableConsoleOutput = true;
  ...
  runApp(const MainApp());
}
```

## About this package

This package is heavily inspired from a great [article](https://itnext.io/mvvm-in-flutter-from-scratch-17757b6433eb) from [Martin Nowosad](https://github.com/MrIceman).