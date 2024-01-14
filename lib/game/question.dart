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

List <List<Question>> questions = [
  [
    Question('2 + 3 = ?', ['5', '7', '10'], 5),
    Question('5 + 1 + 8 = ?', ['13', '14', '12'], 14),
    Question('3 + 6 + 2 = ?', ['10', '9', '11'], 11),
    Question('7 - 4 + 1 = ?', ['4', '2', '3'], 3),
    Question('9 + 2 + 5 = ?', ['16', '15', '14'], 16),
    Question('8 + 3 - 2 = ?', ['10', '9', '7'], 9),
    Question('6 + 2 - 1 = ?', ['9', '6', '7'], 7),
    Question('4 - 3 = ?', ['1', '3', '4'], 1),
    Question('10 + 3 - 5 = ?', ['9', '8', '7'], 8),
    Question('5 - 2 + 3 = ?', ['6', '9', '8'], 6),
  ],
  [
    Question('4 * 6 = ?', ['24', '30', '18'], 24),
    Question('7 * 2 = ?', ['14', '9', '5'], 14),
    Question('5 * 3 = ?', ['15', '12', '8'], 15),
    Question('9 * 4 = ?', ['36', '27', '18'], 36),
    Question('6 * 7 = ?', ['42', '35', '48'], 42),
    Question('2 * 9 = ?', ['18', '15', '12'], 18),
    Question('8 * 3 = ?', ['24', '30', '16'], 24),
    Question('10 * 5 = ?', ['50', '40', '30'], 50),
    Question('12 * 2 * 2 = ?', ['48', '36', '24'], 48),
    Question('3 * 8 * 2 = ?', ['48', '36', '24'], 48),
  ],
  [
    Question('10 / 2 = ?', ['5', '3', '2'], 5),
    Question('15 / 3 = ?', ['4', '5', '6'], 5),
    Question('21 / 7 = ?', ['4', '2', '3'], 3),
    Question('36 / 6 = ?', ['6', '4', '5'], 6),
    Question('45 / 9 = ?', ['6', '5', '4'], 5),
    Question('30 / 5 = ?', ['5', '7', '6'], 6),
    Question('42 / 7 = ?', ['6', '5', '8'], 6),
    Question('63 / 9 = ?', ['8', '7', '6'], 7),
    Question('18 / 3 = ?', ['7', '5', '6'], 6),
    Question('(27 / 3) / 3 = ?', ['4', '3', '2'], 3),
  ],
  [
    Question('(4 + 3) * 2 = ?', ['14', '18', '10'], 14),
    Question('6 / (2 + 1) = ?', ['3', '2', '4'], 2),
    Question('5 * (7 - 3) = ?', ['20', '15', '10'], 20),
    Question('(6 + 2) / 4 = ?', ['2', '3', '4'], 2),
    Question('(9 - 4) * 3 = ?', ['15', '18', '12'], 15),
    Question('12 / (4 * 3) = ?', ['1', '2', '3'], 1),
    Question('15 + (6 / 3) = ?', ['17', '19', '15'], 17),
    Question('(10 / 2) - 5 = ?', ['0', '3', '2'], 0),
    Question('8 / (3 - 1) = ?', ['4', '3', '2'], 4),
    Question('(7 + 3) * (6 / 2) = ?', ['30', '20', '15'], 30),
    Question('(4 * 2) - (3 + 1) = ?', ['3', '4', '7'], 4),
  ]
];
