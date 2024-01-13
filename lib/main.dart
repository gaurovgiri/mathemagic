import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:runner/game/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Runner());
}

class Runner extends StatelessWidget {
  const Runner({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RunnerHome());
  }
}

// Just for running the our game widget instance
class RunnerHome extends StatefulWidget {
  const RunnerHome({super.key});

  @override
  State<RunnerHome> createState() => _RunnerHomeState();
}

class _RunnerHomeState extends State<RunnerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GameWidget(game: RunnerGame()));
  }
}
