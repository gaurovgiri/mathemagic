import 'package:flame/game.dart';
import 'package:flutter/material.dart';

OverlayWidgetBuilder heartsBuilder = (BuildContext context, Game game) {
  return Positioned(
    top: 0,
    right: 0,
    child: Container(
      width: 200,
      height: 75,
      child: const Center(
          child: Row(
        children: [
          Icon(Icons.favorite, color: Color.fromARGB(255, 255, 0, 0)),
          Icon(Icons.favorite, color: Color.fromARGB(255, 255, 0, 0)),
          Icon(Icons.favorite, color: Color.fromARGB(255, 255, 0, 0)),
          Icon(Icons.favorite, color: Color.fromARGB(255, 255, 0, 0)),
          Icon(Icons.favorite, color: Color.fromARGB(255, 255, 0, 0)),
        ],
      )),
    ),
  );
};
