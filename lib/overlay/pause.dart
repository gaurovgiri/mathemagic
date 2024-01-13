import 'package:flame/game.dart';
import 'package:flutter/material.dart';

OverlayWidgetBuilder pauseBuilder = (BuildContext context, Game game) {
  return Center(
    child: Container(
      width: 200,
      height: 200,
      child: Card(
        child: Center(
          child: Column(
            children: [
              const Text(
                'PAUSED',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 39,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              IconButton(
                  onPressed: () {
                    game.overlays.remove("Pause");
                    game.overlays.add("PauseButton");
                    game.resumeEngine();
                  },
                  icon: const Icon(Icons.play_arrow,
                      size: 48, color: Color(0xFF000000)))
            ],
          ),
        ),
      ),
    ),
  );
};
