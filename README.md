# Dart Dungeon Quest

A console game that revises **Sessions 1-4** (Dart basics, functions and
collections, OOP part 1 and part 2). Students descend through 5 dungeon
floors and a final boss, collect points on every level, and see their total
score and rank at the end.

## Levels

| Level | Name | Topic | Quiz max | Forge (code) max |
|---|---|---|---|---|
| 1 | The Cave of Variables | variables, types, null safety, interpolation | 75 | 50 |
| 2 | The Bridge of Choices | operators, if/switch, loops | 75 | 76 |
| 3 | The Library of Lists | functions, List/Set/Map, higher-order methods | 75 | 56 |
| 4 | The Hall of Heroes | classes, constructors, encapsulation, static | 75 | 60 |
| 5 | The Monster Keep | inheritance, abstract, polymorphism, mixins | 75 | 60 |
| 6 | The Dart Dragon Lord (boss) | everything + generics + async | 75 | 70 |

Base maximum: **822 points**. Bonuses (streaks and clean forges) can push a
score above 100%.

Each level has 3 concept questions (10 pts), 2 predict-the-output questions
(15 pts), 1 fix-the-bug question (15 pts) and a coding challenge ("the Forge").

## For students

1. Open a terminal in this folder.
2. Start the game: `dart main.dart`
3. Answer the quiz challenges. You get 2 tries (second try = half points).
   Type `?` for a hint (costs 3 points). Three first-try answers in a row give
   +5 bonus points.
4. When a level reaches the Forge, open `student/challenges.dart`, replace
   each `throw UnimplementedError();` of that level with your code, **save**,
   and press Enter in the game to run the hidden tests. You can fix and re-run
   as often as you like; the best result counts. A perfect first run gives
   +10 bonus points.
5. At the end the game saves `result_<your name>.txt`. Send it to your TA.

Tips: keep `student/challenges.dart` compiling (a syntax error blocks every
level), and do not change function names, parameters or return types.

Requires Dart 3 (`dart --version`). No packages are needed.
