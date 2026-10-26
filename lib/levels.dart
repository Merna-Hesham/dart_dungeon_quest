// ============================================================
//  levels.dart - every level of the game: story + quiz questions.
//  Coding challenges are described in code_plan.dart / code_checks.dart.
//
//  TEACHER: to add or change a question, edit the lists below.
//  Code snippets use raw strings (r'''...''') so that $ is safe.
// ============================================================
import 'question.dart';

class Level {
  final int number;
  final String name;
  final String topic;
  final String story;
  final List<Question> questions;
  final bool hasCode;
  final String codeBrief;

  Level(this.number, this.name, this.topic, this.story, this.questions,
      {this.hasCode = false, this.codeBrief = ''});
}

int quizMax(Level l) => l.questions.fold(0, (s, q) => s + q.points);

final List<Level> levels = [
  // ------------------------------------------------------------------ 1
  Level(
    1,
    'THE CAVE OF VARIABLES',
    'Session 1: variables, types, null safety, string interpolation',
    'You step into a damp cave. Glowing runes cover the walls: the old\n'
        'magic of VARIABLES. Answer the runes to light the way forward.',
    [
      Question.mcq(
        'Which line causes a compile-time error?',
        [
          'var age = 20;  age = 21;',
          "final city = 'Cairo';  city = 'Giza';",
          'int? score;  score = null;',
          'const pi = 3.14;',
        ],
        1,
        'A final variable can be assigned only once, so the second '
            'assignment to city is an error.',
        hint: 'One keyword on these lines means "assign only once".',
      ),
      Question.mcq(
        'What is the type of  var x = 7 / 2;  ?',
        ['int', 'double', 'String', 'num only'],
        1,
        'In Dart the / operator always gives a double (3.5). '
            'Use ~/ for integer division.',
      ),
      Question.mcq(
        'What does  String? nickname;  mean?',
        [
          'nickname must always be an empty String',
          'nickname can hold a String or null',
          'nickname is a constant',
          'nickname is initialized later with late',
        ],
        1,
        'The ? after a type makes it nullable: it may be a String or null.',
      ),
      Question.predict(
        r'''
String name = 'Sara';
int age = 20;
print('$name is ${age + 1} next year');''',
        ['Sara is 21 next year'],
        r'$name inserts a variable and ${...} evaluates an expression.',
        hint: r'${age + 1} is calculated first, then inserted into the text.',
      ),
      Question.predict(
        r'''
String? nick;
print(nick?.length ?? -1);''',
        ['-1'],
        'nick is null, so nick?.length is null, and ?? replaces null with -1.',
        hint: '?. stops when the value is null. ?? gives a default value.',
      ),
      Question.fix(
        r'''
String? title;
print(title.length);''',
        'The code does not compile. Which change fixes it safely?',
        [
          'print(title.length!);',
          'print(title?.length);',
          'String title;',
          'print(title.length ?? 0);',
        ],
        1,
        'title can be null, so use the null-aware operator ?. to access '
            'length safely.',
      ),
    ],
    hasCode: true,
    codeBrief: 'Open student/challenges.dart and complete LEVEL 1:\n'
        '  introduce(), safeName() and average().',
  ),

  // ------------------------------------------------------------------ 2
  Level(
    2,
    'THE BRIDGE OF CHOICES',
    'Session 1: operators, if/else, switch, loops',
    'A rope bridge crosses a dark canyon. Each plank only holds if you\n'
        'know your operators and loops. Do not look down!',
    [
      Question.mcq(
        'What is  -7 % 3  in Dart?',
        ['-1', '2', '1', '-2'],
        1,
        'The Dart remainder is never negative, so -7 % 3 is 2 '
            '(C++ would give -1).',
      ),
      Question.mcq(
        'Which operator performs INTEGER division in Dart?',
        ['/', '//', '~/', '%'],
        2,
        '~/ divides and drops the fraction: 17 ~/ 5 is 3.',
      ),
      Question.mcq(
        'What does  break  do inside a loop?',
        [
          'Skips to the next iteration',
          'Ends the loop immediately',
          'Ends the whole program',
          'Restarts the loop',
        ],
        1,
        'break leaves the loop. continue is the one that skips to the next '
            'iteration.',
      ),
      Question.predict(
        r'''
int total = 0;
for (int i = 1; i <= 4; i++) {
  total += i;
}
print(total);''',
        ['10'],
        '1 + 2 + 3 + 4 = 10.',
        hint: 'The loop runs for i = 1, 2, 3 and 4.',
      ),
      Question.predict(
        r'''
int x = 5;
String r = x > 3 ? (x > 4 ? 'big' : 'mid') : 'small';
print(r);''',
        ['big'],
        'x > 3 is true, then x > 4 is true, so the result is big.',
        hint: 'Evaluate the outer condition first, then the inner one.',
      ),
      Question.fix(
        r'''
int n = 3;
while (n > 0) {
  print(n);
}''',
        'The loop never stops. Which fix makes it print 3, 2, 1 and stop?',
        [
          'Add  n--;  as the last line inside the loop',
          'Change the condition to  n < 0',
          'Add  n = 3;  inside the loop',
          'Change  print(n)  to  print(n + 1)',
        ],
        0,
        'n never changes, so n > 0 stays true forever. n-- moves it '
            'towards 0.',
      ),
    ],
    hasCode: true,
    codeBrief: 'Open student/challenges.dart and complete LEVEL 2:\n'
        '  isLeapYear(), fizzBuzz() and gradeFor().',
  ),

  // ------------------------------------------------------------------ 3
  Level(
    3,
    'THE LIBRARY OF LISTS',
    'Session 2: functions, parameters, List / Set / Map, higher-order methods',
    'Towering shelves stretch into the dark. The librarian ghost only\n'
        'lets you pass if you can handle FUNCTIONS and COLLECTIONS.',
    [
      Question.mcq(
        'How do you call  void greet({required String name})  ?',
        [
          "greet('Sara')",
          "greet(name: 'Sara')",
          "greet({'Sara'})",
          "greet(name = 'Sara')",
        ],
        1,
        'Named parameters are passed with their name followed by a colon.',
      ),
      Question.mcq(
        'What is special about a Set compared with a List?',
        [
          'Its elements are always sorted',
          'Each element can appear at most once',
          'It cannot hold Strings',
          'Its elements are found by a key',
        ],
        1,
        'A Set stores unique elements. Adding a duplicate does nothing.',
      ),
      Question.mcq(
        'What does  [1, 2, 3].map((n) => n * 2)  return?',
        [
          'A List [2, 4, 6] immediately',
          'A lazy Iterable (call toList() to get a List)',
          'A Map',
          'Nothing (void)',
        ],
        1,
        'map() returns a lazy Iterable. Add .toList() when you need a List.',
      ),
      Question.predict(
        r'''
var nums = [1, 2, 3, 4, 5, 6];
print(nums.where((n) => n % 2 == 0).length);''',
        ['3'],
        'where keeps 2, 4 and 6, so the length is 3.',
        hint: 'where() keeps only the elements that pass the test.',
      ),
      Question.predict(
        r'''
var scores = {'Ali': 3, 'Mona': 5};
scores['Ali'] = scores['Ali']! + 10;
print(scores['Ali']);''',
        ['13'],
        'The value stored under Ali becomes 3 + 10 = 13.',
        hint: 'The ! says "I am sure this is not null".',
      ),
      Question.fix(
        r'''
var names = ['Ali', 'Mona'];
names.add(3);''',
        'This fails. Which line works with the list as it is?',
        [
          "names.add('Sam');",
          'names.addAll(3);',
          'names.insert(3);',
          'names = 3;',
        ],
        0,
        "names is inferred as List<String>, so only Strings can be added.",
      ),
    ],
    hasCode: true,
    codeBrief: 'Open student/challenges.dart and complete LEVEL 3:\n'
        '  evensOnly(), wordCount() and sumSquares().',
  ),

  // ------------------------------------------------------------------ 4
  Level(
    4,
    'THE HALL OF HEROES',
    'Session 3: classes, constructors, encapsulation, toString, static',
    'Statues of fallen heroes line the great hall. To wake them you\n'
        'must understand CLASSES and OBJECTS, and even build one yourself.',
    [
      Question.mcq(
        'In Dart, what does a leading underscore (_balance) do?',
        [
          'Makes it private to its class only',
          'Makes it private to its file (library)',
          'Makes it a constant',
          'Makes it protected',
        ],
        1,
        'Dart privacy works per library (file), not per class. '
            'There is no protected keyword.',
        hint: 'Dart has no private keyword; the underscore does it.',
      ),
      Question.mcq(
        'What does the constructor  Point(this.x, this.y);  do?',
        [
          'Creates two new classes',
          'Copies the parameters straight into the fields x and y',
          'Makes x and y static',
          'Nothing, the body is empty',
        ],
        1,
        'this.x in the parameter list is the shortcut for assigning the '
            'parameter to the field.',
      ),
      Question.mcq(
        'What does the keyword  this  refer to inside a method?',
        [
          'The parent class',
          'The current object',
          'The class itself',
          'The last created object',
        ],
        1,
        'this is the object on which the method was called.',
      ),
      Question.predict(
        r'''
class Counter {
  int value = 0;
  void increment() => value++;
}
var c = Counter();
c.increment();
c.increment();
print(c.value);''',
        ['2'],
        'increment ran twice on the same object, so value is 2.',
        hint: 'c is ONE object; both calls change the same value.',
      ),
      Question.predict(
        r'''
class Box {
  final int size;
  Box(this.size);
  @override
  String toString() => 'Box($size)';
}
print(Box(4));''',
        ['Box(4)'],
        'print() calls toString() on the object, which we overrode.',
      ),
      Question.fix(
        r'''
class Account {
  final double balance;
  Account(this.balance);
  void deposit(double amount) {
    balance += amount;
  }
}''',
        'deposit() gives an error. What is the best fix?',
        [
          'Remove final from the balance field',
          'Make deposit() static',
          'Write balance =+ amount;',
          'Add final before amount',
        ],
        0,
        'A final field cannot change after construction. The balance must '
            'be a normal (non-final) field to be updated.',
      ),
    ],
    hasCode: true,
    codeBrief: 'Open student/challenges.dart and complete LEVEL 4:\n'
        '  the Hero class (takeDamage, heal, isAlive, toString, strongest).',
  ),

  // ------------------------------------------------------------------ 5
  Level(
    5,
    'THE MONSTER KEEP',
    'Session 4: inheritance, abstract classes, interfaces, polymorphism, mixins',
    'The keep is full of monsters of every kind. Master INHERITANCE and\n'
        'POLYMORPHISM and you can command them all with one spell.',
    [
      Question.mcq(
        'What happens if you write  var m = Monster("x");  and Monster is '
            'abstract?',
        [
          'It works and creates a monster',
          'Compile-time error: abstract classes cannot be instantiated',
          'It works but prints a warning',
          'It creates a null object',
        ],
        1,
        'An abstract class is only a blueprint. Create objects of its '
            'concrete subclasses instead.',
      ),
      Question.mcq(
        'A class that  implements  an interface...',
        [
          'inherits all its code',
          'must write every member of the interface itself',
          'can only implement one interface',
          'becomes abstract automatically',
        ],
        1,
        'implements inherits NO code. Every member must be implemented '
            '(extends is the one that reuses code).',
      ),
      Question.mcq(
        'What does  class Duck with Swimmer, Flyer  mean?',
        [
          'Duck has two parents, which Dart forbids',
          'Duck reuses the code of two mixins',
          'Duck only implements two interfaces',
          'It is a syntax error',
        ],
        1,
        'with adds mixins. A class can use many mixins but still has only '
            'one parent class.',
      ),
      Question.predict(
        r'''
class Animal { String sound() => '...'; }
class Dog extends Animal {
  @override
  String sound() => 'Woof';
}
Animal a = Dog();
print(a.sound());''',
        ['Woof'],
        'Polymorphism: the real object is a Dog, so the Dog version runs.',
        hint: 'Look at the object created on the right, not the type on the left.',
      ),
      Question.predict(
        r'''
class A { String hi() => 'A'; }
class B extends A {
  @override
  String hi() => super.hi() + 'B';
}
print(B().hi());''',
        ['AB'],
        'super.hi() runs the parent version (A), then B is added.',
      ),
      Question.fix(
        r'''
abstract class Shape {
  double area();
}
class Square extends Shape {
  double side = 2;
}''',
        'Square does not compile. Which addition fixes it?',
        [
          '@override double area() => side * side;',
          'static double area() => 4;',
          'Remove abstract from Shape',
          'Change extends to implements',
        ],
        0,
        'A concrete subclass must implement every abstract method.',
      ),
    ],
    hasCode: true,
    codeBrief: 'Open student/challenges.dart and complete LEVEL 5:\n'
        '  Goblin, Dragon (with the Flyer mixin) and totalDamage().',
  ),

  // ------------------------------------------------------------------ 6
  Level(
    6,
    'THE DART DRAGON LORD (FINAL BOSS)',
    'Sessions 1-4: everything, plus generics and async',
    'The Dragon Lord rises from a mountain of gold. Only a true Dart\n'
        'master can defeat it. All you have learned is needed now!',
    [
      Question.mcq(
        'What does the  late  keyword promise?',
        [
          'The variable is initialized later, but before it is first read',
          'The variable is a compile-time constant',
          'The variable can never be null',
          'The variable is read-only forever',
        ],
        0,
        'late delays the initialization. Reading it before it is set '
            'throws a runtime error.',
      ),
      Question.mcq(
        'Why write  class Stack<T>  ?',
        [
          'To make the class abstract',
          'One class that works, type-checked, for many element types',
          'To make all fields private',
          'To allow multiple inheritance',
        ],
        1,
        'T is a placeholder replaced by a real type: Stack<int>, Stack<String>.',
      ),
      Question.mcq(
        'Which statement is TRUE?',
        [
          'final needs a compile-time value, const does not',
          'const values are fixed at compile time; final is assigned once at run time',
          'final and const are identical',
          'const variables can be reassigned',
        ],
        1,
        'const must be known when compiling. final can be calculated at '
            'run time, but only once.',
      ),
      Question.predict(
        r'''
class Hero {
  final String name;
  Hero(this.name);
}
var a = Hero('Ali');
var b = Hero('Ali');
print(a == b);''',
        ['false'],
        'Without overriding == (and hashCode) objects are equal only if '
            'they are the SAME object.',
        hint: 'Two separate Hero objects were created with the constructor.',
      ),
      Question.predict(
        r'''
var items = ['sword', 'shield', 'potion'];
for (var item in items.reversed) {
  if (item.startsWith('s')) continue;
  print(item);
}''',
        ['potion'],
        'reversed gives potion, shield, sword. The two starting with s are '
            'skipped by continue.',
        hint: 'Write the reversed order down first.',
      ),
      Question.fix(
        r'''
Future<String> loadHero() async => 'Aria';

void main() {
  String name = await loadHero();
  print(name);
}''',
        'await is not allowed here. Which change fixes it?',
        [
          'Future<void> main() async {',
          'String name = loadHero();',
          'Remove async from loadHero',
          'Write late before String',
        ],
        0,
        'await can only be used inside an async function, so main must be '
            'async (returning Future<void>).',
      ),
    ],
    hasCode: true,
    codeBrief: 'Open student/challenges.dart and complete the BOSS section:\n'
        '  the generic Stack<T> class.',
  ),
];
