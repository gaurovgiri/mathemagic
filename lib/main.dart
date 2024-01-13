import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:runner/game/game.dart';
import 'package:runner/overlay/gameover.dart';
import 'package:runner/overlay/hearts.dart';
import 'package:runner/overlay/pause.dart';
import 'package:runner/overlay/pause_button.dart';

ValueNotifier<int> lives = ValueNotifier(5);
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
class RunnerHome extends StatelessWidget {
  const RunnerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GameWidget(game: RunnerGame(), overlayBuilderMap: {
      "Pause": pauseBuilder,
      "Hearts": heartsBuilder,
      "PauseButton": pauseButton,
      "GameOver": gameOver
    }));
  }
}
