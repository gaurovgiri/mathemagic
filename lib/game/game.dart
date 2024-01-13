// Class where the world is defined.
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';

import 'package:runner/game/question_manager.dart';
import 'package:runner/game/wizard.dart';
import 'package:runner/main.dart';

class RunnerGame extends FlameGame with TapDetector, HasCollisionDetection {
  RunnerGame({super.camera});

  Wizard wizard = Wizard();
  QuestionManager questionManager = QuestionManager();
  int score = 0;
  int level = 1;
  int thresholdLevel = 15;

  final scoreText = TextComponent();
  late final ParallaxComponent parallax;
  final questionText = TextComponent();

  @override
  FutureOr<void> onLoad() async {
    // debugMode = true;
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    camera.viewfinder.position = Vector2(size.x / 2, size.y / 2);

    parallax = await loadParallaxComponent(
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

    scoreText.text = 'Score: $score | Level: $level';
    scoreText.position =
        Vector2((size.x / 2) - (scoreText.width / 2), size.y - 30);

    world.add(wizard);
    world.add(questionManager);
    world.add(scoreText);

    overlays.add("Hearts");
    overlays.add("PauseButton");

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    wizard.jump();
  }

  @override
  void update(double dt) {
    scoreText.text = 'Score: $score | Level: $level';
    level = (score ~/ 5) + 1;

    if (lives.value <= 0) {
      pauseEngine();
      overlays.remove("PauseButton");
      overlays.add("GameOver");
      score = 0;
      level = 1;
    }
    super.update(dt);
  }

  void resetGame() {
    lives.value = 5;

    wizard.resetWizard();
    questionManager.resetQuestionManager();
    resumeEngine();
  }
}
