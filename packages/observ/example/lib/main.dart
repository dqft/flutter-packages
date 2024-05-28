import 'package:flutter/material.dart';
import 'package:observ/observ.dart';

void main() {
  Observ.debugMode = true;
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
  void handle(Observation observation,
      {required Observable from, required Observer to}) {
    switch (observation) {
      case IconPicked _:
        setState(() => _icon = observation.icon);
    }
  }
}

class MyBody extends StatelessWidget with Observable {
  @override
  final Observer observer;

  const MyBody({
    super.key,
    required this.observer,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
