import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:runner/game/enemy.dart';
import 'package:runner/game/game.dart';

enum WizardState { idle, move, attack, takeHit }

class Wizard extends SpriteAnimationComponent
    with HasGameRef<RunnerGame>, CollisionCallbacks {
  Map<WizardState, SpriteAnimation> animationMap = {};
  WizardState state = WizardState.idle;
  bool hasCollided = false;
  double speedY = 0.0;
  double gravity = 1000.0;

  Timer _timer = Timer(1);

  double ymax = 0;

  Wizard() {
    size = Vector2(250, 300);
  }

  @override
  Future<void> onLoad() async {
    animationMap = {
      WizardState.idle: await SpriteAnimation.load(
        'Player/Idle.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          textureSize: Vector2(150, 150),
          stepTime: 0.1,
        ),
      ),
      WizardState.move: await SpriteAnimation.load(
        'Player/Move.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          textureSize: Vector2(150, 150),
          stepTime: 0.1,
        ),
      ),
      WizardState.attack: await SpriteAnimation.load(
          'Player/Attack.png',
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(150, 150),
          )),
      WizardState.takeHit: await SpriteAnimation.load(
          'Player/Take Hit.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(150, 150),
          )),
    };

    animation = animationMap[WizardState.move];
    position = Vector2(size.x / 50, size.y - 150);
    ymax = size.y - 150;

    _timer = Timer(0.5, onTick: () {
      move();
      hasCollided = false;
    });

    await add(
      RectangleHitbox(
          position: Vector2(size.x / 2, size.y / 2),
          size: size * 0.2,
          anchor: Anchor.center),
    );
    super.onLoad();
  }

  void move() {
    state = WizardState.move;
    animation = animationMap[state];
  }

  void attack() {
    state = WizardState.attack;
    animation = animationMap[state];
  }

  void idle() {
    state = WizardState.idle;
    animation = animationMap[state];
  }

  void takeHit() {
    state = WizardState.takeHit;
    animation = animationMap[state];
  }

  void jump() {
    speedY = -300;
    idle();
    _timer.start();
  }

  bool onGround() {
    return position.y >= ymax;
  }

  bool onSky() {
    return position.y < -100;
  }

  @override
  void update(double dt) {
    super.update(dt);

    speedY += gravity * dt;
    position.y += speedY * dt;
    _timer.update(dt);

    if (onSky()) {
      position.y = -100;
      speedY = 0.0;
    }

    if (onGround()) {
      position.y = ymax;
      speedY = 0.0;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if ((other is Enemy) && !hasCollided) {
      hasCollided = true;
      takeHit();
      _timer.start();
    }
  }
}
