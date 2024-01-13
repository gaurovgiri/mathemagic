import 'package:flame/game.dart';
import 'package:flutter/material.dart';

OverlayWidgetBuilder pause_button = (context, game) {
  return Positioned(
      top: 15,
      left: 30,
      child: IconButton(
          onPressed: () {
            game.pauseEngine();
            game.overlays.add("Pause");
            game.overlays.remove("PauseButton");
          },
          icon: const Icon(
            Icons.pause,
          )));
};
