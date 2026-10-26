// ==================================================================
//   DUNGEON QUEST  -  a Dart game that tests Sessions 1 to 4
//   Run it from THIS folder:    dart main.dart
// ==================================================================
import 'dart:convert';
import 'dart:io';

import 'lib/code_plan.dart';
import 'lib/levels.dart';
import 'lib/question.dart';
import 'lib/scoring.dart';
import 'lib/ui.dart';

/// What the hidden tests said about the student's code.
class GradeResult {
  final String? error; // compile error, crash or timeout text
  final Set<int> passed; // indexes of passed tests
  GradeResult(this.error, this.passed);
}

/// Starts tool/grade_level.dart in a separate Dart process, so the
/// student can edit and re-run without restarting the game.
Future<GradeResult> runGrader(int level) async {
  try {
    final p = await Process.start(
        'dart', ['tool/grade_level.dart', '$level'],
        runInShell: Platform.isWindows);
    final outFuture = p.stdout.transform(utf8.decoder).join();
    final errFuture = p.stderr.transform(utf8.decoder).join();
    var timedOut = false;
    await p.exitCode.timeout(const Duration(seconds: 60), onTimeout: () {
      timedOut = true;
      p.kill();
      return -1;
    });
    final out = await outFuture;
    final err = await errFuture;
    if (timedOut) {
      return GradeResult(
          'The tests took too long. Do you have an infinite loop?', {});
    }
    final passed = <int>{};
    var seen = 0;
    for (final line in const LineSplitter().convert(out)) {
      if (!line.startsWith('TEST|')) continue;
      final parts = line.split('|');
      seen++;
      if (parts[2] == '1') passed.add(int.parse(parts[1]));
    }
    if (seen == 0) {
      final text = (err.trim().isEmpty ? out : err).trim();
      final shown = text.split('\n').take(14).join('\n');
      return GradeResult(shown.isEmpty ? 'Unknown error.' : shown, {});
    }
    return GradeResult(null, passed);
  } on ProcessException {
    return GradeResult(
        'Could not start the "dart" command. Is Dart installed and in your PATH?',
        {});
  }
}

class ForgeResult {
  final int points;
  final int bonus;
  ForgeResult(this.points, this.bonus);
}

/// The coding part of a level: run the hidden tests as often as needed.
Future<ForgeResult> forge(Level level) async {
  final plan = codePlan[level.number]!;
  final max = codeMax(level.number);

  banner('THE FORGE (level ${level.number}): write code!');
  print(level.codeBrief);
  print('Worth up to $max points. Perfect on the first run: +10 bonus.');

  var best = 0;
  var runs = 0;
  var bonus = 0;

  while (true) {
    final prompt = runs == 0
        ? '\nSAVE the file, then press Enter to run the tests (or type s to skip): '
        : '\nFix, SAVE, then press Enter to re-run (or type c to continue with $best pts): ';
    final cmd = ask(prompt).toLowerCase();
    if (cmd == 's' || cmd == 'c') break;

    runs++;
    print('   Running the hidden tests... (a few seconds)');
    final g = await runGrader(level.number);

    if (g.error != null) {
      print('\n   Your code could not run:');
      for (final line in g.error!.split('\n')) {
        print('   ! $line');
      }
      print('   Fix the problem in student/challenges.dart and try again.');
      continue;
    }

    var earned = 0;
    for (var i = 0; i < plan.length; i++) {
      final ok = g.passed.contains(i);
      if (ok) earned += plan[i].points;
      print('   ${ok ? '[PASS]' : '[FAIL]'} ${plan[i].label}  '
          '(${ok ? '+${plan[i].points}' : '0'})');
    }
    print('   Forge score this run: $earned / $max');
    if (earned > best) best = earned;

    if (earned == max) {
      print('   ALL TESTS PASSED! The forge glows with power.');
      if (runs == 1) {
        bonus = 10;
        print('   CLEAN FORGE BONUS! +10 pts');
      }
      break;
    }
  }
  return ForgeResult(best, bonus);
}

/// Plays one whole level and returns its score (quiz + forge + bonuses).
Future<int> playLevel(Level level) async {
  banner('LEVEL ${level.number}: ${level.name}');
  print('Topic: ${level.topic}\n');
  print(level.story);

  var score = 0;
  var streak = 0;
  for (var i = 0; i < level.questions.length; i++) {
    final result = playQuestion(level.questions[i], i, level.questions.length);
    score += result.points;
    if (result.firstTry) {
      streak++;
      if (streak % 3 == 0) {
        score += 5;
        print('   STREAK BONUS! 3 first-try answers in a row: +5 pts');
      }
    } else {
      streak = 0;
    }
    print('   Level score so far: $score');
  }

  if (level.hasCode) {
    final f = await forge(level);
    score += f.points + f.bonus;
  }

  final max = quizMax(level) + codeMax(level.number);
  print('\n>> Level ${level.number} cleared!  Score: $score  (base max $max)');
  print('   ${bar(score, max)}');
  ask('Press Enter to continue...');
  return score;
}

void showTitle() {
  print(r'''

   ____  _   _ _   _  ____ _____ ___  _   _    ___  _   _ _____ ____ _____
  |  _ \| | | | \ | |/ ___| ____/ _ \| \ | |  / _ \| | | | ____/ ___|_   _|
  | | | | | | |  \| | |  _|  _|| | | |  \| | | | | | | | |  _| \___ \ | |
  | |_| | |_| | |\  | |_| | |__| |_| | |\  | | |_| | |_| | |___ ___) || |
  |____/ \___/|_| \_|\____|_____\___/|_| \_|  \__\_\\___/|_____|____/ |_|

            A Dart adventure through Sessions 1 - 4
''');
  print('RULES OF THE DUNGEON');
  print('  * 6 levels: 5 dungeon floors and a final boss.');
  print('  * Each level has quiz challenges: concepts, predict the output,');
  print('    and fix the bug. Answer with a letter, or type the output.');
  print('  * You have 2 tries per question. The 2nd try gives half points.');
  print('  * Type ? to get a hint (it costs 3 points).');
  print('  * 3 first-try answers in a row give a +5 STREAK BONUS.');
  print('  * Then you enter THE FORGE: write real code in');
  print('    student/challenges.dart. Hidden tests give you points.');
  print('  * At the end you see your total score and your rank.');
}

String askName() {
  while (true) {
    final name = ask('\nWhat is your name, brave adventurer? ');
    if (name.isNotEmpty) return name;
    print('The dungeon needs a name to remember you by.');
  }
}

Future<void> main() async {
  if (!File('student/challenges.dart').existsSync()) {
    print('Please run the game from the dart_dungeon_quest folder:');
    print('    cd dart_dungeon_quest');
    print('    dart main.dart');
    exit(1);
  }

  showTitle();
  final name = askName();
  print('\nWelcome, $name. Your adventure begins...');
  ask('Press Enter to descend into the dungeon...');

  final scores = <int>[];
  for (final level in levels) {
    scores.add(await playLevel(level));
  }

  // -------------------------------------------------------- final screen
  banner('THE DUNGEON IS CONQUERED!');
  var total = 0;
  var baseMax = 0;
  final lines = StringBuffer();
  for (var i = 0; i < levels.length; i++) {
    final l = levels[i];
    final max = quizMax(l) + codeMax(l.number);
    total += scores[i];
    baseMax += max;
    final row = 'Level ${l.number}  ${bar(scores[i], max, width: 16)}  '
        '${scores[i].toString().padLeft(4)} / $max';
    print(row);
    lines.writeln(row);
  }
  final percent = (total * 100 / baseMax).round();
  final rank = rankFor(percent);
  final code = makeCode(name, total, scores);

  print('\nTOTAL SCORE : $total  (base maximum $baseMax, $percent%)');
  print('YOUR RANK   : $rank');
  print('RESULT CODE : $code');

  final safe = name.replaceAll(RegExp(r'[^A-Za-z0-9_\-]'), '_');
  final fileName = 'result_$safe.txt';
  File(fileName).writeAsStringSync('name=$name\n'
      'scores=${scores.join(',')}\n'
      'total=$total\n'
      'code=$code\n\n'
      '$lines\n'
      'Rank: $rank ($percent%)\n');
  print('\nYour result was saved to $fileName.');
  print('Send this file to your teaching assistant.');
}
