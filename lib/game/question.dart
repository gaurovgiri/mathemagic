import 'package:flame/components.dart';
import 'package:runner/game/game.dart';

/// [Question] holds the questions that are available for the player to solve,
/// answers associated with the question and the correct answer of each question.
/// Displays the question on top of the screen.
class Question extends TextComponent with HasGameRef<RunnerGame> {
  String question;
  List<String> answers;
  int correctAnswer;

  Question(this.question, this.answers, this.correctAnswer);

  @override
  Future<void> onLoad() async {
    text = question;
    position = Vector2((gameRef.size.x / 2) - (width / 2), 0);
    return super.onLoad();
  }
}

List<Question> questions = [
  Question('2 + 3 = ?', ['4', '5', '7'], 5),
  Question('8 - 4 = ?', ['2', '4', '5'], 4),
  Question('3 * 6 = ?', ['15', '18', '24'], 18),
  Question('10 + 7 = ?', ['15', '17', '18'], 17),
  Question('5 * 4 = ?', ['15', '20', '30'], 20),
  Question('12 - 8 = ?', ['2', '4', '6'], 4),
  Question('9 * 3 = ?', ['24', '27', '33'], 27),
  Question('14 + 6 = ?', ['18', '20', '24'], 20),
  Question('7 * 5 = ?', ['30', '35', '45'], 35),
  Question('15 - 9 = ?', ['4', '6', '7'], 6),
  Question('6 * 8 = ?', ['36', '42', '48'], 48),
  Question('18 + 11 = ?', ['25', '29', '39'], 29),
  Question('4 * 9 = ?', ['36', '40', '44'], 36),
  Question('20 - 14 = ?', ['4', '6', '7'], 6),
  Question('11 * 2 = ?', ['18', '20', '22'], 22),
  Question('13 + 8 = ?', ['18', '24', '27'], 21),
  Question('9 * 7 = ?', ['56', '63', '77'], 63),
  Question('16 - 5 = ?', ['10', '12', '13'], 11),
  Question('8 * 4 = ?', ['28', '36', '40'], 32),
  Question('17 + 9 = ?', ['24', '28', '30'], 26),
];
