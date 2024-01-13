import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:runner/game/game.dart';
import 'package:runner/game/hoop.dart';
import 'package:runner/game/question.dart';

class QuestionManager extends Component
    with HasGameRef<RunnerGame>, CollisionCallbacks {
  final Timer _timer = Timer(5, repeat: true);
  final Random _random = Random();
  List<Hoop> hoops = [];
  Question questionToDisplay = Question('', [], 0);
  List<TextComponent> answers = [];

  QuestionManager() {
    _timer.onTick = _spawnHoop;
  }

  void _spawnHoop() {
    questionToDisplay = questions[_random.nextInt(questions.length)];
    gameRef.world.add(questionToDisplay);
    hoops = [
      Hoop(HoopPosition.top, questionToDisplay.answers[0]),
      Hoop(HoopPosition.middle, questionToDisplay.answers[1]),
      Hoop(HoopPosition.bottom, questionToDisplay.answers[2]),
    ];
    answers = [
      TextComponent()..text = questionToDisplay.answers[0],
      TextComponent()..text = questionToDisplay.answers[1],
      TextComponent()..text = questionToDisplay.answers[2],
    ];
    for (final hoop in hoops) {
      gameRef.world.add(hoop);
      answers[hoops.indexOf(hoop)].position = hoop.position;
      gameRef.world.add(answers[hoops.indexOf(hoop)]);
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

    for (final answer in answers) {
      answer.position = hoops[answers.indexOf(answer)].position;
    }
  }

  void resetQuestionManager() {
    _timer.stop();
    for (final hoop in hoops) {
      hoop.removeFromParent();
    }
    for (final answer in answers) {
      answer.removeFromParent();
    }
    questionToDisplay.removeFromParent();
    _timer.start();
  }
}
