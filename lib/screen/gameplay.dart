// Just for running the our game widget instance
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:runner/game/game.dart';
import 'package:runner/overlay/gameover.dart';
import 'package:runner/overlay/hearts.dart';
import 'package:runner/overlay/pause.dart';
import 'package:runner/overlay/pause_button.dart';

class MathemagicaGame extends StatelessWidget {
  const MathemagicaGame({super.key});

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
