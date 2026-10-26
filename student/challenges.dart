// ==================================================================
//   DUNGEON QUEST  -  YOUR CODING FILE
// ==================================================================
//
//  How it works
//  ------------
//  1. Play the game:      dart main.dart
//  2. When a level asks you to "forge" code, come to THIS file,
//     find the section for that level and replace every
//        throw UnimplementedError();
//     with real code. Do NOT change names, parameters or return types.
//  3. SAVE the file, go back to the game and press Enter to run
//     the hidden tests. You may fix and re-run as often as you like;
//     the game keeps your BEST result for the level.
//
//  Rules
//  -----
//  * Keep the file compiling. A syntax error blocks ALL levels.
//  * Only edit the parts marked TODO.
//  * Run "dart format ." and "dart analyze" to polish your code.
//
// ==================================================================

// ------------------------------------------------------------------
//  LEVEL 1 - THE CAVE OF VARIABLES
// ------------------------------------------------------------------

/// Return a sentence like:  Hi, I am Sara and I am 20 years old.
/// TODO: use string interpolation ($name and $age).
String introduce(String name, int age) {
  throw UnimplementedError();
}

/// Return [name], or the text 'Stranger' when [name] is null.
/// An empty text ('') is NOT null, so it must be returned as it is.
/// TODO: use the ?? operator.
String safeName(String? name) {
  throw UnimplementedError();
}

/// Return the average of [a] and [b] as a double. average(3, 4) is 3.5.
/// TODO: remember that / always gives a double in Dart.
double average(int a, int b) {
  throw UnimplementedError();
}

// ------------------------------------------------------------------
//  LEVEL 2 - THE BRIDGE OF CHOICES
// ------------------------------------------------------------------

/// A year is a leap year if it is divisible by 4,
/// EXCEPT years divisible by 100, unless they are also divisible by 400.
/// 2024 -> true, 1900 -> false, 2000 -> true, 2023 -> false.
/// TODO: combine %, &&, || (and parentheses).
bool isLeapYear(int year) {
  throw UnimplementedError();
}

/// Return 'FizzBuzz' if n is divisible by 15, 'Fizz' if divisible by 3,
/// 'Buzz' if divisible by 5, otherwise the number itself as a String.
/// fizzBuzz(9) -> 'Fizz'   fizzBuzz(7) -> '7'
/// TODO: if / else if chain (check 15 first!).
String fizzBuzz(int n) {
  throw UnimplementedError();
}

/// Return the letter grade of a score:
/// 90 or more -> 'A', 80+ -> 'B', 70+ -> 'C', 60+ -> 'D', otherwise 'F'.
/// TODO: if / else if or a switch expression.
String gradeFor(int score) {
  throw UnimplementedError();
}

// ------------------------------------------------------------------
//  LEVEL 3 - THE LIBRARY OF LISTS
// ------------------------------------------------------------------

/// Return a NEW list with only the even numbers, in the same order.
/// evensOnly([1, 2, 3, 4, 5, 6]) -> [2, 4, 6]
/// TODO: try where(...).toList().
List<int> evensOnly(List<int> nums) {
  throw UnimplementedError();
}

/// Count how many times each word appears. Ignore upper/lower case.
/// Words are separated by single spaces.
/// wordCount('a b a')    -> {a: 2, b: 1}
/// wordCount('Hi hi HI') -> {hi: 3}
/// TODO: split(' '), toLowerCase() and a Map.
Map<String, int> wordCount(String sentence) {
  throw UnimplementedError();
}

/// Return the sum of the squares of [nums].
/// When [onlyEven] is true, only the even numbers are squared and added.
/// sumSquares([1, 2, 3])                      -> 14
/// sumSquares([1, 2, 3, 4], onlyEven: true)   -> 20
/// TODO: a loop (or where/map/fold) and the named parameter.
int sumSquares(List<int> nums, {bool onlyEven = false}) {
  throw UnimplementedError();
}

// ------------------------------------------------------------------
//  LEVEL 4 - THE HALL OF HEROES
// ------------------------------------------------------------------

class Hero {
  final String name;
  final int maxHealth;
  int _health; // private: only this file can touch it directly

  // Given to you: the health starts full.
  Hero(this.name, this.maxHealth) : _health = maxHealth;

  // Given to you: a getter so the outside world can READ the health.
  int get health => _health;

  /// Subtract [amount] from the health. Health never goes below 0.
  /// TODO: an if statement (or max(...), which needs  import 'dart:math';
  /// as the very first line of this file).
  void takeDamage(int amount) {
    throw UnimplementedError();
  }

  /// Add [amount] to the health. Health never goes above maxHealth.
  /// TODO: an if statement (or min(...), same import as above).
  void heal(int amount) {
    throw UnimplementedError();
  }

  /// true while the health is above 0.
  /// TODO: a getter that returns a bool.
  bool get isAlive {
    throw UnimplementedError();
  }

  /// Text like:  Aria (80/100 HP)
  /// TODO: override toString.
  @override
  String toString() {
    throw UnimplementedError();
  }

  /// Return the hero with the highest health from [heroes]
  /// (the list is never empty).
  /// TODO: a static method with a loop.
  static Hero strongest(List<Hero> heroes) {
    throw UnimplementedError();
  }
}

// ------------------------------------------------------------------
//  LEVEL 5 - THE MONSTER KEEP
// ------------------------------------------------------------------

/// Given to you: the abstract blueprint of every monster.
abstract class Monster {
  final String name;
  final int hp;
  Monster(this.name, this.hp);

  int attack(); // every monster attacks differently

  String describe() => '$name (HP $hp)';
}

/// An ability that flying monsters share.
mixin Flyer {
  bool flying = false;

  /// Make the creature fly.
  /// TODO: set flying to true.
  void takeOff() {
    throw UnimplementedError();
  }
}

class Goblin extends Monster {
  Goblin(String name) : super(name, 30);

  /// A goblin always attacks for 8.
  /// TODO: replace the throw.
  @override
  int attack() {
    throw UnimplementedError();
  }
}

// TODO 1: make Dragon use the Flyer mixin (hint: the keyword with).
class Dragon extends Monster {
  Dragon(String name) : super(name, 200);

  /// 40 damage on the ground, 55 damage while flying.
  /// TODO 2: use the 'flying' field that Flyer gives you.
  @override
  int attack() {
    throw UnimplementedError();
  }
}

/// Return the total damage if every monster in [monsters] attacks once.
/// totalDamage([Goblin('a'), Goblin('b'), Dragon('c')]) -> 56
/// TODO: polymorphism! Just call attack() on each one.
int totalDamage(List<Monster> monsters) {
  throw UnimplementedError();
}

// ------------------------------------------------------------------
//  BOSS - THE DART DRAGON LORD
// ------------------------------------------------------------------

/// A generic LIFO stack (last in, first out), like a pile of plates.
///  push(x)  puts x on top
///  pop()    removes and returns the top item (error if the stack is empty)
///  peek()   returns the top item WITHOUT removing it, or null if empty
///  isEmpty  true when there are no items
///  length   how many items are inside
/// TODO: implement every member using the private list _items.
class Stack<T> {
  final List<T> _items = [];

  void push(T item) {
    throw UnimplementedError();
  }

  T pop() {
    throw UnimplementedError();
  }

  T? peek() {
    throw UnimplementedError();
  }

  bool get isEmpty {
    throw UnimplementedError();
  }

  int get length {
    throw UnimplementedError();
  }
}
