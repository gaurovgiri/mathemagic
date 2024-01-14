import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// [pauseButton] pauses and resumes the game.
OverlayWidgetBuilder pauseButton = (context, game) {
  return Positioned(
      top: 15,
      left: 30,
      child: IconButton(
          onPressed: () {
            game.pauseEngine();
            game.overlays.add("Pause");
            ///removes the pause menu 
            game.overlays.remove("PauseButton");
          },
          icon: const Icon(
            Icons.pause,
          )));
};
