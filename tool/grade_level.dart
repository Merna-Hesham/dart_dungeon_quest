// ============================================================
//  grade_level.dart - runs the hidden tests of ONE level against
//  student/challenges.dart and prints one line per test:
//        TEST|<index>|<1 = passed, 0 = failed>
//  It is started by main.dart; you can also run it by hand:
//        dart tool/grade_level.dart 4
// ============================================================
import '../lib/code_checks.dart';
import '../lib/code_plan.dart';

void main(List<String> args) {
  final level = int.parse(args.first);
  final checks = codeChecks[level]!;
  final plan = codePlan[level]!;
  if (checks.length != plan.length) {
    print('SETUP ERROR: checks and plan differ for level $level');
    return;
  }
  for (var i = 0; i < checks.length; i++) {
    var ok = false;
    try {
      ok = checks[i]();
    } catch (_) {
      ok = false;
    }
    print('TEST|$i|${ok ? 1 : 0}');
  }
}
