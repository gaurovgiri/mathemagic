// Class where the world is defined.
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:runner/game/enemy_manager.dart';
import 'package:runner/game/wizard.dart';

class RunnerGame extends FlameGame with TapDetector, HasCollisionDetection {
  RunnerGame({super.camera});

  Wizard wizard = Wizard();
  EnemyManager enemyManager = EnemyManager();

  @override
  FutureOr<void> onLoad() async {
    // debugMode = true;
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    camera.viewfinder.position = camera.viewport.virtualSize * 0.5;

    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('parallax/1.png'),
        ParallaxImageData('parallax/4.png'),
        ParallaxImageData('parallax/3.png'),
        ParallaxImageData('parallax/2.png'),
        ParallaxImageData('parallax/5.png')
      ],
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.5, 1.0),
    );

    camera.backdrop.add(parallax);

    world.add(wizard);
    world.add(enemyManager);

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownInfo info) {
    // TODO: implement onTapDown
    super.onTapDown(info);
    wizard.jump();
  }
}
