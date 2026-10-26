// ============================================================
//  code_plan.dart - WHAT is tested in each coding challenge and
//  how many points each test is worth.
//  The matching test bodies are in code_checks.dart (same order).
// ============================================================

class TestSpec {
  final String label;
  final int points;
  const TestSpec(this.label, this.points);
}

const Map<int, List<TestSpec>> codePlan = {
  1: [
    TestSpec("introduce('Sara', 20)", 8),
    TestSpec("introduce('Omar', 31)", 7),
    TestSpec('safeName(null) gives Stranger', 5),
    TestSpec("safeName('Omar') keeps the name", 5),
    TestSpec("safeName('') keeps the empty text", 5),
    TestSpec('average(3, 4) is 3.5', 10),
    TestSpec('average(10, 20) is 15.0', 10),
  ],
  2: [
    TestSpec('isLeapYear(2024) is true', 8),
    TestSpec('isLeapYear(1900) is false', 8),
    TestSpec('isLeapYear(2000) is true', 8),
    TestSpec('isLeapYear(2023) is false', 6),
    TestSpec('fizzBuzz(15) is FizzBuzz', 8),
    TestSpec('fizzBuzz(9) is Fizz', 6),
    TestSpec('fizzBuzz(10) is Buzz', 6),
    TestSpec('fizzBuzz(7) is 7', 6),
    TestSpec('gradeFor(95) is A', 5),
    TestSpec('gradeFor(80) is B', 5),
    TestSpec('gradeFor(70) is C', 5),
    TestSpec('gradeFor(59) is F', 5),
  ],
  3: [
    TestSpec('evensOnly([1..6]) is [2, 4, 6]', 8),
    TestSpec('evensOnly([]) is []', 6),
    TestSpec('evensOnly([7, 9]) is []', 6),
    TestSpec("wordCount('a b a') is {a: 2, b: 1}", 10),
    TestSpec("wordCount('Hi hi HI') ignores case", 10),
    TestSpec('sumSquares([1, 2, 3]) is 14', 8),
    TestSpec('sumSquares([1, 2, 3, 4], onlyEven: true) is 20', 8),
  ],
  4: [
    TestSpec('takeDamage reduces health', 8),
    TestSpec('health never goes below 0', 8),
    TestSpec('heal adds health', 8),
    TestSpec('heal never goes above maxHealth', 8),
    TestSpec('isAlive is true for a healthy hero', 5),
    TestSpec('isAlive is false at 0 health', 5),
    TestSpec("toString looks like 'Aria (100/100 HP)'", 8),
    TestSpec('Hero.strongest picks the healthiest hero', 10),
  ],
  5: [
    TestSpec('Goblin attacks for 8', 10),
    TestSpec('Goblin inherits describe()', 5),
    TestSpec('Dragon is a Monster AND a Flyer', 10),
    TestSpec('Dragon attacks for 40 on the ground', 10),
    TestSpec('Dragon attacks for 55 after takeOff()', 10),
    TestSpec('totalDamage adds up a mixed list', 15),
  ],
  6: [
    TestSpec('push increases length', 10),
    TestSpec('pop returns the LAST pushed item (LIFO)', 10),
    TestSpec('peek shows the top without removing it', 10),
    TestSpec('isEmpty works before and after push', 10),
    TestSpec('Stack<String> works too (generics)', 10),
    TestSpec('pop on an empty stack throws an error', 10),
    TestSpec('peek on an empty stack returns null', 10),
  ],
};

int codeMax(int level) =>
    (codePlan[level] ?? const <TestSpec>[]).fold(0, (s, t) => s + t.points);
