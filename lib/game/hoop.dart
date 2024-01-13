import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:runner/game/game.dart';
import 'package:runner/game/wizard.dart';

enum HoopState { idle, correct, wrong }

enum HoopPosition { top, middle, bottom }

class Hoop extends SpriteAnimationComponent
    with HasGameRef<RunnerGame>, CollisionCallbacks {
  final HoopPosition _position;
  late final Map<HoopPosition, Vector2> positionMap;
  bool hasCollided = false;
  bool isCorrect = true;

  Hoop(this._position) {
    size = Vector2(96, 96);
  }

  @override
  FutureOr<void> onLoad() async {
    positionMap = {
      HoopPosition.bottom: Vector2(
          gameRef.size.x + size.x, (gameRef.size.y - size.y) - size.y / 2),
      HoopPosition.middle:
          Vector2(gameRef.size.x + size.x, (gameRef.size.y - size.y) / 2),
      HoopPosition.top: Vector2(gameRef.size.x + size.x, size.y / 2),
    };

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
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Wizard && !hasCollided) {
      hasCollided = true;
      game.score += 1;
      correct();

      for (final hoop in game.hoopManager.hoops) {
        if (hoop != this) {
          hoop.hasCollided = true;
        }
      }
      // if game.answer == answer -> correct()
      // else -> wrong()
    }
    super.onCollision(intersectionPoints, other);
  }
}
