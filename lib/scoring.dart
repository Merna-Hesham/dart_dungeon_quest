// ============================================================
//  scoring.dart - result code used to detect edited result files.
//  (This is a light check against casual cheating, not security.)
// ============================================================

String makeCode(String name, int total, List<int> levelScores) {
  var h = 7;
  final text = '$name|$total|${levelScores.join(',')}|dungeon-quest-salt';
  for (final unit in text.codeUnits) {
    h = (h * 31 + unit) & 0x7fffffff;
  }
  return h.toRadixString(36).toUpperCase();
}

String rankFor(int percent) {
  if (percent >= 90) return 'DRAGON SLAYER';
  if (percent >= 75) return 'DUNGEON KNIGHT';
  if (percent >= 50) return 'BRAVE SQUIRE';
  return 'APPRENTICE ADVENTURER';
}
