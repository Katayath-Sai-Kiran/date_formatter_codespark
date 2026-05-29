/// Internal localization constants used by [DateFormatterExtension].
///
/// Contains zero-dependency month and weekday lookup arrays so that this
/// package never needs to import `intl` or any third-party library.
library;

/// Short month name abbreviations indexed by `DateTime.month` (1-based).
///
/// Index 0 is intentionally left as an empty string so that
/// `kShortMonths[dateTime.month]` maps directly without offset arithmetic.
const List<String> kShortMonths = <String>[
  '', // 0 — unused; months are 1-indexed in Dart
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

/// Full weekday names indexed by `DateTime.weekday` (1 = Monday … 7 = Sunday).
///
/// Index 0 is intentionally left as an empty string so that
/// `kWeekdays[dateTime.weekday]` maps directly without offset arithmetic.
const List<String> kWeekdays = <String>[
  '', // 0 — unused; weekdays are 1-indexed in Dart
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];
