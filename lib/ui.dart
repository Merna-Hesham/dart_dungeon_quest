// ============================================================
//  ui.dart - small helpers for reading input and printing.
// ============================================================
import 'dart:io';

/// Prints [prompt], waits for a line and returns it trimmed.
/// If the input stream is closed (Ctrl+D / end of file) the game exits.
String ask(String prompt) {
  stdout.write(prompt);
  final line = stdin.readLineSync();
  if (line == null) {
    print('\nInput closed. Farewell, adventurer!');
    exit(0);
  }
  return line.trim();
}

/// Prints a code snippet inside a simple frame.
void printCode(String code) {
  print('   +----------------------------------------');
  for (final line in code.trim().split('\n')) {
    print('   | $line');
  }
  print('   +----------------------------------------');
}

/// Prints a big title line.
void banner(String text) {
  final line = '=' * (text.length + 8);
  print('\n$line');
  print('==  $text  ==');
  print(line);
}

/// A text progress bar, e.g. [#####.....]
String bar(int value, int max, {int width = 20}) {
  if (max <= 0) return '[${'.' * width}]';
  var filled = ((value / max) * width).round();
  if (filled > width) filled = width;
  if (filled < 0) filled = 0;
  return '[${'#' * filled}${'.' * (width - filled)}]';
}
