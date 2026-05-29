/// date_formatter_codespark
///
/// A zero-dependency, ultra-lightweight suite of intuitive [DateTime]
/// extensions for Flutter. Provides relative time (`toTimeAgo`), calendar
/// boundary flags (`isToday`, `isYesterday`, `isTomorrow`, `isThisWeek`),
/// high-frequency layout presets (`toDayAndMonth`, `toTime12Hour`,
/// `toFullHumanDate`), and precise countdown utilities (`daysRemaining`,
/// `hoursRemaining`) — all without `intl` or any third-party package.
///
/// ### Quick start
/// ```dart
/// import 'package:date_formatter_codespark/date_formatter_codespark.dart';
///
/// final now = DateTime.now();
///
/// now.toTimeAgo();           // "0s ago"
/// now.isToday;               // true
/// now.toDayAndMonth();       // "29 May"
/// now.toFullHumanDate();     // "Friday, 29 May, 2026"
/// now.toTime12Hour();        // "11:30 PM"
/// now.daysRemaining();       // "Today"
/// now.hoursRemaining();      // "0 hours left"
/// ```
library date_formatter_codespark;

export 'src/date_extensions.dart';
