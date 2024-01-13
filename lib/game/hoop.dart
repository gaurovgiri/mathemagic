import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:runner/game/game.dart';
import 'package:runner/game/wizard.dart';
import 'package:runner/main.dart';

enum HoopState { idle, correct, wrong }

enum HoopPosition { top, middle, bottom }
/// [Hoop] maintains the position of the hoops in the game
class Hoop extends SpriteAnimationComponent
    with HasGameRef<RunnerGame>, CollisionCallbacks {
  final HoopPosition _position;
  late final Map<HoopPosition, Vector2> positionMap;
  bool hasCollided = false;
  bool isCorrect = true;
  String value;

  Hoop(this._position, this.value) {
    size = Vector2(96, 96);
  }

  @override
  /// [onLoad] defines the position of the hoops on the screen
  FutureOr<void> onLoad() async {
    positionMap = {
      HoopPosition.bottom: Vector2(
          gameRef.size.x + size.x, (gameRef.size.y - size.y) - size.y / 2),
      HoopPosition.middle:
          Vector2(gameRef.size.x + size.x, (gameRef.size.y - size.y) / 2),
      HoopPosition.top: Vector2(gameRef.size.x + size.x, size.y / 2),
    };
    /// each hoop is animated on the screen
    animation = await SpriteAnimation.load(
      'hoops/hoop.png',
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2(32, 32),
        stepTime: 0.1,
      ),
    );
    position = positionMap[_position]!;

    add(RectangleHitbox());

    return super.onLoad();
  }

  Future<void> correct() async {
    animation = await SpriteAnimation.load(
      'hoops/hoop_green.png',
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2(32, 32),
        stepTime: 0.1,
      ),
    );
  }

  Future<void> wrong() async {
    animation = await SpriteAnimation.load(
      'hoops/hoop_red.png',
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2(32, 32),
        stepTime: 0.1,
      ),
    );
  }

  @override
  void update(double dt) {
    position.x -= dt * 250;
    if (position.x < 0) {
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  /// [onCollision] handles the collison event in the game. If answer is correct
  /// the game score is increased else lives are decreased.
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Wizard && !hasCollided) {
      hasCollided = true;
      if (value ==
          gameRef.questionManager.questionToDisplay.correctAnswer.toString()) {
        correct();
        game.score += 1;
      } else {
        wrong();
        other.takeHit();
        lives.value -= 1;
      }

      gameRef.questionManager.questionToDisplay.removeFromParent();

      for (final hoop in game.questionManager.hoops) {
        if (hoop != this) {
          hoop.hasCollided = true;
        }
      }
      for (final answer in game.questionManager.answers) {
        answer.removeFromParent();
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}
