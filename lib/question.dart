// ============================================================
//  question.dart - the three kinds of quiz challenges and the
//  code that plays one of them in the console.
// ============================================================
import 'ui.dart';

enum QType { mcq, predict, fix }

const String letters = 'ABCD';

class Question {
  final QType type;
  final String prompt;
  final String? code;
  final List<String> options;
  final int answerIndex;
  final List<String> accepted;
  final int points;
  final String? hint;
  final String explanation;

  Question._(this.type, this.prompt, this.code, this.options, this.answerIndex,
      this.accepted, this.points, this.hint, this.explanation);

  /// Multiple-choice concept question.
  factory Question.mcq(String prompt, List<String> options, int answer,
          String explanation, {String? hint, int points = 10}) =>
      Question._(QType.mcq, prompt, null, options, answer, const [], points,
          hint, explanation);

  /// "What does this code print?" - the player types the output.
  factory Question.predict(String code, List<String> accepted,
          String explanation, {String? hint, int points = 15}) =>
      Question._(QType.predict, 'What does this code print?', code, const [],
          -1, accepted, points, hint, explanation);

  /// Broken code - the player picks the correct fix.
  factory Question.fix(String code, String prompt, List<String> options,
          int answer, String explanation, {String? hint, int points = 15}) =>
      Question._(QType.fix, prompt, code, options, answer, const [], points,
          hint, explanation);

  String get label => switch (type) {
        QType.mcq => 'CONCEPT',
        QType.predict => 'PREDICT THE OUTPUT',
        QType.fix => 'FIX THE BUG',
      };
}

/// What happened when the player answered one question.
class Attempt {
  final int points;
  final bool firstTry;
  Attempt(this.points, this.firstTry);
}

String _norm(String s) => s.trim().replaceAll(RegExp(r'\s+'), ' ');

bool _isCorrect(Question q, String input) {
  if (q.options.isNotEmpty) {
    if (input.length != 1) return false;
    return letters.indexOf(input.toUpperCase()) == q.answerIndex;
  }
  final typed = _norm(input);
  return q.accepted.any((a) => _norm(a) == typed);
}

String _answerText(Question q) {
  if (q.options.isNotEmpty) {
    return '${letters[q.answerIndex]}) ${q.options[q.answerIndex]}';
  }
  return q.accepted.first;
}

/// Plays one question: two attempts, optional hint.
///  - right on the 1st try  -> full points
///  - right on the 2nd try  -> half points
///  - using the hint        -> minus 3 points (never below 1)
Attempt playQuestion(Question q, int index, int total) {
  print('');
  print('--- ${q.label}  (${index + 1}/$total)  worth ${q.points} pts ---');
  if (q.code != null) printCode(q.code!);
  print(q.prompt);
  for (var i = 0; i < q.options.length; i++) {
    print('   ${letters[i]}) ${q.options[i]}');
  }

  var hintUsed = false;
  var attempt = 1;
  while (attempt <= 2) {
    final tip = (q.hint != null && !hintUsed) ? '  [type ? for a hint, -3 pts]' : '';
    final input = ask('Your answer$tip: ');

    if (input == '?' && q.hint != null && !hintUsed) {
      hintUsed = true;
      print('   HINT: ${q.hint}');
      continue; // asking for a hint does not use up an attempt
    }

    if (_isCorrect(q, input)) {
      var pts = attempt == 1 ? q.points : q.points ~/ 2;
      if (hintUsed) {
        pts = pts - 3 < 1 ? 1 : pts - 3;
      }
      print('   CORRECT!  +$pts pts');
      print('   ${q.explanation}');
      return Attempt(pts, attempt == 1);
    }

    if (attempt == 1) {
      print('   Not quite. You get one more try (half points).');
    }
    attempt++;
  }

  print('   Out of tries. The answer was: ${_answerText(q)}');
  print('   ${q.explanation}');
  return Attempt(0, false);
}
