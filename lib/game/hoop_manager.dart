import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:runner/game/game.dart';
import 'package:runner/game/hoop.dart';

class HoopManager extends Component
    with HasGameRef<RunnerGame>, CollisionCallbacks {
  final Timer _timer = Timer(5, repeat: true);
  List<Hoop> hoops = [];

  HoopManager() {
    _timer.onTick = _spawnHoop;
  }

  void _spawnHoop() {
    hoops = [
      Hoop(HoopPosition.top),
      Hoop(HoopPosition.middle),
      Hoop(HoopPosition.bottom),
    ];
    for (final hoop in hoops) {
      gameRef.world.add(hoop);
    }
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void update(dt) {
    super.update(dt);
    _timer.update(dt);
  }
}
