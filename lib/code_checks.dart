// ============================================================
//  code_checks.dart - the test bodies for the coding challenges.
//  The order MUST match code_plan.dart (same level, same order).
//  Each check returns true when the student's code behaves correctly.
//  An exception (including UnimplementedError) counts as a failure.
// ============================================================
import '../student/challenges.dart';

typedef Check = bool Function();

bool _listEq(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

bool _mapEq(Map<String, int> a, Map<String, int> b) {
  if (a.length != b.length) return false;
  for (final e in a.entries) {
    if (b[e.key] != e.value) return false;
  }
  return true;
}

final Map<int, List<Check>> codeChecks = {
  // ---------------------------------------------------------------- 1
  1: [
    () => introduce('Sara', 20) == 'Hi, I am Sara and I am 20 years old.',
    () => introduce('Omar', 31) == 'Hi, I am Omar and I am 31 years old.',
    () => safeName(null) == 'Stranger',
    () => safeName('Omar') == 'Omar',
    () => safeName('') == '',
    () => average(3, 4) == 3.5,
    () => average(10, 20) == 15.0,
  ],
  // ---------------------------------------------------------------- 2
  2: [
    () => isLeapYear(2024) == true,
    () => isLeapYear(1900) == false,
    () => isLeapYear(2000) == true,
    () => isLeapYear(2023) == false,
    () => fizzBuzz(15) == 'FizzBuzz',
    () => fizzBuzz(9) == 'Fizz',
    () => fizzBuzz(10) == 'Buzz',
    () => fizzBuzz(7) == '7',
    () => gradeFor(95) == 'A',
    () => gradeFor(80) == 'B',
    () => gradeFor(70) == 'C',
    () => gradeFor(59) == 'F',
  ],
  // ---------------------------------------------------------------- 3
  3: [
    () => _listEq(evensOnly([1, 2, 3, 4, 5, 6]), [2, 4, 6]),
    () => _listEq(evensOnly([]), []),
    () => _listEq(evensOnly([7, 9]), []),
    () => _mapEq(wordCount('a b a'), {'a': 2, 'b': 1}),
    () => _mapEq(wordCount('Hi hi HI'), {'hi': 3}),
    () => sumSquares([1, 2, 3]) == 14,
    () => sumSquares([1, 2, 3, 4], onlyEven: true) == 20,
  ],
  // ---------------------------------------------------------------- 4
  4: [
    () {
      final h = Hero('Aria', 100);
      h.takeDamage(30);
      return h.health == 70;
    },
    () {
      final h = Hero('Aria', 100);
      h.takeDamage(500);
      return h.health == 0;
    },
    () {
      final h = Hero('Aria', 100);
      h.takeDamage(50);
      h.heal(20);
      return h.health == 70;
    },
    () {
      final h = Hero('Aria', 100);
      h.takeDamage(10);
      h.heal(500);
      return h.health == 100;
    },
    () => Hero('Aria', 100).isAlive == true,
    () {
      final h = Hero('Aria', 100);
      h.takeDamage(150);
      return h.isAlive == false;
    },
    () => Hero('Aria', 100).toString() == 'Aria (100/100 HP)',
    () {
      final a = Hero('A', 100);
      final b = Hero('B', 100);
      final c = Hero('C', 100);
      a.takeDamage(50);
      c.takeDamage(20);
      return Hero.strongest([a, b, c]).name == 'B';
    },
  ],
  // ---------------------------------------------------------------- 5
  5: [
    () => Goblin('Grek').attack() == 8,
    () => Goblin('Grek').describe() == 'Grek (HP 30)',
    () {
      final Object d = Dragon('Smaug');
      return d is Monster && d is Flyer;
    },
    () => Dragon('Smaug').attack() == 40,
    () {
      final dynamic d = Dragon('Smaug');
      d.takeOff();
      return d.attack() == 55;
    },
    () => totalDamage([Goblin('a'), Goblin('b'), Dragon('c')]) == 56,
  ],
  // ---------------------------------------------------------------- 6 (boss)
  6: [
    () {
      final s = Stack<int>();
      s.push(1);
      s.push(2);
      s.push(3);
      return s.length == 3;
    },
    () {
      final s = Stack<int>();
      s.push(1);
      s.push(2);
      s.push(3);
      final first = s.pop();
      final second = s.pop();
      return first == 3 && second == 2;
    },
    () {
      final s = Stack<int>();
      s.push(5);
      return s.peek() == 5 && s.length == 1;
    },
    () {
      final s = Stack<int>();
      final emptyAtStart = s.isEmpty;
      s.push(1);
      return emptyAtStart == true && s.isEmpty == false;
    },
    () {
      final s = Stack<String>();
      s.push('a');
      s.push('b');
      return s.pop() == 'b';
    },
    () {
      try {
        Stack<int>().pop();
        return false;
      } on UnimplementedError {
        return false;
      } catch (_) {
        return true;
      }
    },
    () => Stack<int>().peek() == null,
  ],
};
