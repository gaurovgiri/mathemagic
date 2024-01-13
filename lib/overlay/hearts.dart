import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:runner/main.dart';

OverlayWidgetBuilder heartsBuilder = (BuildContext context, Game game) {
  return ValueListenableBuilder(
      valueListenable: lives,
      builder: (context, value, child) {
        List<Icon> hearts = [];
        for (int i = 0; i < 5; i++) {
          if (i >= lives.value) {
            hearts.add(const Icon(Icons.favorite_border,
                color: Color.fromARGB(255, 255, 0, 0)));
          } else {
            hearts.add(const Icon(Icons.favorite,
                color: Color.fromARGB(255, 255, 0, 0)));
          }
        }
        return Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 200,
            height: 75,
            child: Center(child: Row(children: hearts)),
          ),
        );
      });
};
