import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:runner/game/game.dart';
import 'package:runner/game/hoop.dart';
import 'package:runner/main.dart';

/// [WizardState] defines the states that the wizard can have
enum WizardState { move, takeHit }

/// [Wizard] displays the wizard sprite on screen, animates its state (move and
/// takeHit) and checks collision of the sprite with the obstacles i.e. hoops
class Wizard extends SpriteAnimationComponent
    with HasGameRef<RunnerGame>, CollisionCallbacks {
  Map<WizardState, SpriteAnimation> animationMap = {};

  /// sets the default wizard state to be moving
  WizardState state = WizardState.move;
  double speedY = -20;
  double gravity = 1000.0;
  double ymax = 0;

  Vector2 playerPosition = Vector2.zero();

  Timer timer = Timer(1);

  bool hasCollided = false;

  Wizard() {
    size = Vector2(150, 150);
  }

  @override
  void onMount() {
    playerPosition = Vector2(50, gameRef.size.y - 500);
    position = playerPosition;
    super.onMount();
  }

  /// [onLoad] handles the animation of the sprite wizard on the screen for both
  /// the states of move and takeHit
  @override
  Future<void> onLoad() async {
    animationMap = {
      WizardState.move: await SpriteAnimation.load(
        'Player/Move.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          textureSize: Vector2(150, 150),
          stepTime: 0.1,
        ),
      ),
      WizardState.takeHit: await SpriteAnimation.load(
          'Player/Take Hit.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(150, 150),
          )),
    };

    animation = animationMap[WizardState.move];
    // position = Vector2(50, gameRef.size.y);
    ymax = gameRef.size.y - 150;

    timer = Timer(0.5, onTick: () {
      move();
      hasCollided = false;
    });

    await add(
      RectangleHitbox(
          position: Vector2(size.x / 2, size.y / 2),
          size: size * 0.2,
          anchor: Anchor.center),
    );

    gameRef.pauseEngine();
    super.onLoad();
  }

  void move() {
    state = WizardState.move;
    animation = animationMap[state];
  }

  void takeHit() {
    state = WizardState.takeHit;
    animation = animationMap[state];
  }

  void jump() {
    speedY = -300;
    move();
    timer.start();
  }

  bool onGround() {
    return position.y >= ymax;
  }

  bool onSky() {
    return position.y < -25;
  }

  @override
  void update(double dt) {
    super.update(dt);

    speedY += gravity * dt;
    position.y += speedY * dt;

    // Rotate up when going up, down when going down

    timer.update(dt);

    if (onSky()) {
      position.y = -25;
      speedY = 0.0;
    }

    if (onGround()) {
      position.y = ymax;
      speedY = 0.0;
    }
  }

  void resetWizard() {
    // position = Vector2(50, 20);
    speedY = -300;
    move();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if ((other is Hoop) && !hasCollided) {
      hasCollided = true;
      timer.start();
    }
  }
}
