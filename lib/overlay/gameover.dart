import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:runner/game/game.dart';

OverlayWidgetBuilder gameOver = (BuildContext context, Game game) {
  return Center(
    child: Container(
      width: 200,
      height: 200,
      child: Card(
        child: Center(
          child: Column(
            children: [
              const Text(
                'Game Over',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              IconButton(
                  onPressed: () {
                    game.overlays.remove("GameOver");
                    game.overlays.add("PauseButton");
                    RunnerGame().resetGame();
                    game.resumeEngine();
                  },
                  icon: const Icon(Icons.replay,
                      size: 48, color: Color(0xFF000000)))
            ],
          ),
        ),
      ),
    ),
  );
};
