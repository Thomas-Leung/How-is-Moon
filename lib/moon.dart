class Moon {
  // This simply mods the difference between the date and a known new moon date (1970-01-07) by the length of the lunar period.
  // For this reason, it is only valid from 1970 onwards.
  int moonPhase(year, month, day) {
    // long-term avg duration 29.530587981 days (coverted to seconds)
    double lp = 2551442.8015584;
    DateTime date = new DateTime(year, month, day, 20, 35, 0);
    // reference point new moon, the new moon at Jan 7th, 1970, 20:35.
    DateTime newMoon = new DateTime(1970, 1, 7, 20, 35, 0);
    double phase =
        ((date.millisecondsSinceEpoch - newMoon.millisecondsSinceEpoch) / 1000) % lp;
    return (phase / (24 * 3600)).floor() + 1;
  }
}
