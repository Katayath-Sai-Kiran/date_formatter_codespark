import 'time_ago_constants.dart';

/// A comprehensive suite of zero-dependency [DateTime] extensions for Flutter.
///
/// Provides human-readable relative time, calendar boundary flags, layout
/// formatting presets, and countdown utilities — all without importing `intl`
/// or any third-party package.
///
/// Import via the package barrel:
/// ```dart
/// import 'package:date_formatter_codespark/date_formatter_codespark.dart';
/// ```
extension DateFormatterExtension on DateTime {
  /// Returns true if the time is between 5:00 AM and 12:00 PM.
  bool get isMorning => hour >= 5 && hour < 12;

  /// Returns true if the time is between 12:00 PM and 5:00 PM.
  bool get isAfternoon => hour >= 12 && hour < 17;

  /// Returns true if the time is between 5:00 PM and 9:00 PM.
  bool get isEvening => hour >= 17 && hour < 21;

  /// Returns true if the time is between 9:00 PM and 5:00 AM.
  bool get isNight => hour >= 21 || hour < 5;

  /// Returns true if the date is the first business (weekday) day of the month.
  bool get isFirstBusinessDayOfMonth {
    if (!isBusinessDay) return false;
    DateTime d = DateTime(year, month, 1);
    while (!d.isBusinessDay) {
      d = d.add(const Duration(days: 1));
    }
    return isSameDay(d);
  }

  /// Returns the date of the nth occurrence of a given weekday in the month (e.g., 2nd Friday).
  /// Example: DateTime(2026, 5, 1).nthWeekdayOfMonth(DateTime.friday, 2) => 2026-05-08
  DateTime nthWeekdayOfMonth(int weekday, int n) {
    assert(weekday >= DateTime.monday && weekday <= DateTime.sunday);
    assert(n > 0);
    DateTime d = DateTime(year, month, 1);
    int count = 0;
    while (d.month == month) {
      if (d.weekday == weekday) {
        count++;
        if (count == n) return d;
      }
      d = d.add(const Duration(days: 1));
    }
    throw ArgumentError('Not enough occurrences of weekday in month');
  }

  /// Returns true if this date is the last occurrence of its weekday in the month.
  bool get isLastOccurrenceOfWeekdayInMonth {
    DateTime d = add(const Duration(days: 7));
    return d.month != month;
  }

  /// Returns the number of days since another date.
  int daysSince(DateTime other) => difference(other).inDays;

  /// Returns true if the date matches any in a provided list of holidays (date-only match).
  bool isPublicHoliday(List<DateTime> holidays) =>
      holidays.any((h) => isSameDay(h));

  /// Returns the fiscal year for the date, given a custom fiscal year start month (default: April).
  int toFiscalYear({int fiscalYearStartMonth = 4}) {
    if (month < fiscalYearStartMonth) {
      return year - 1;
    } else {
      return year;
    }
  }

  /// Returns the next business day after this date.
  ///
  /// Skips weekends. Example:
  /// ```dart
  /// DateTime(2026, 5, 29).nextBusinessDay; // Skips to Monday if Friday
  /// ```
  DateTime get nextBusinessDay {
    DateTime next = add(const Duration(days: 1));
    while (next.isWeekend) {
      next = next.add(const Duration(days: 1));
    }
    return next;
  }

  /// Returns the previous business day before this date.
  ///
  /// Skips weekends. Example:
  /// ```dart
  /// DateTime(2026, 5, 30).previousBusinessDay; // Skips to Friday if Monday
  /// ```
  DateTime get previousBusinessDay {
    DateTime prev = subtract(const Duration(days: 1));
    while (prev.isWeekend) {
      prev = prev.subtract(const Duration(days: 1));
    }
    return prev;
  }

  /// Returns the number of business days until [other] (exclusive).
  ///
  /// Example:
  /// ```dart
  /// date.businessDaysUntil(otherDate); // e.g., 5
  /// ```
  int businessDaysUntil(DateTime other) {
    int days = 0;
    DateTime current = isBefore(other) ? this : other;
    DateTime end = isBefore(other) ? other : this;
    current = current.add(const Duration(days: 1));
    while (current.isBefore(end)) {
      if (current.isBusinessDay) days++;
      current = current.add(const Duration(days: 1));
    }
    return days;
  }

  /// Returns true if this date is the last business (weekday) day of the month.
  ///
  /// Handles all months, including leap years. A business day is Monday–Friday.
  /// Example:
  /// ```dart
  /// DateTime(2026, 5, 29).isLastBusinessDayOfMonth; // true if 29 May 2026 is last weekday of May
  /// ```
  bool get isLastBusinessDayOfMonth {
    if (weekday > DateTime.friday) return false; // Not a business day
    DateTime next = this;
    do {
      next = next.add(const Duration(days: 1));
    } while (next.weekday > DateTime.friday && next.month == month);
    return next.month != month;
  }
  // ─────────────────────────────────────────────────────────────────────────
  // SECTION 1 — Relative Time
  // ─────────────────────────────────────────────────────────────────────────

  /// Returns a human-readable relative time string describing how far this
  /// [DateTime] is from the current moment, supporting both **past** and
  /// **future** dates natively.
  ///
  /// When [short] is `true` (default), abbreviated unit tokens are used:
  /// `s`, `m`, `h`, `d`, `w`, `mo`, `y`.
  ///
  /// When [short] is `false`, full verbose phrasing is used.
  ///
  /// ### Examples
  /// ```dart
  /// final past = DateTime.now().subtract(Duration(minutes: 12));
  /// past.toTimeAgo();              // "12m ago"
  /// past.toTimeAgo(short: false);  // "12 minutes ago"
  ///
  /// final future = DateTime.now().add(Duration(hours: 3));
  /// future.toTimeAgo();              // "in 3h"
  /// future.toTimeAgo(short: false);  // "in 3 hours"
  /// ```
  String toTimeAgo({bool short = true}) {
    final now = DateTime.now();
    final diff = now.difference(this);
    final isPast = diff.isNegative == false;
    final abs = diff.abs();

    final int seconds = abs.inSeconds;
    final int minutes = abs.inMinutes;
    final int hours = abs.inHours;
    final int days = abs.inDays;

    String _label(int value, String shortUnit, String singular, String plural) {
      if (short) return '$value$shortUnit';
      return value == 1 ? '1 $singular' : '$value $plural';
    }

    late final String token;

    if (seconds < 60) {
      token = _label(seconds, 's', 'second', 'seconds');
    } else if (minutes < 60) {
      token = _label(minutes, 'm', 'minute', 'minutes');
    } else if (hours < 24) {
      token = _label(hours, 'h', 'hour', 'hours');
    } else if (days < 7) {
      token = _label(days, 'd', 'day', 'days');
    } else if (days < 30) {
      final weeks = (days / 7).floor();
      token = _label(weeks, 'w', 'week', 'weeks');
    } else if (days < 365) {
      final months = (days / 30).floor();
      token = _label(months, 'mo', 'month', 'months');
    } else {
      final years = (days / 365).floor();
      token = _label(years, 'y', 'year', 'years');
    }

    if (isPast) {
      return short ? '$token ago' : '$token ago';
    } else {
      return short ? 'in $token' : 'in $token';
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // SECTION 2 — Calendar Boundary Flags
  // ─────────────────────────────────────────────────────────────────────────

  /// Returns `true` if this [DateTime] falls on today's calendar date.
  ///
  /// Comparison is performed on year, month, and day only — the time
  /// component is ignored, making this safe for any time of day.
  ///
  /// ### Example
  /// ```dart
  /// DateTime.now().isToday; // true
  /// ```
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Returns `true` if this [DateTime] falls on yesterday's calendar date.
  ///
  /// ### Example
  /// ```dart
  /// DateTime.now().subtract(const Duration(days: 1)).isYesterday; // true
  /// ```
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Returns `true` if this [DateTime] falls on tomorrow's calendar date.
  ///
  /// ### Example
  /// ```dart
  /// DateTime.now().add(const Duration(days: 1)).isTomorrow; // true
  /// ```
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Returns `true` if this [DateTime] falls within the current ISO 8601 week
  /// (Monday–Sunday).
  ///
  /// The current week boundaries are computed from `DateTime.now()` by
  /// stepping back to Monday and forward to Sunday, then comparing calendar
  /// dates only (time-of-day is ignored).
  ///
  /// ### Example
  /// ```dart
  /// DateTime.now().isThisWeek; // true
  /// ```
  bool get isThisWeek {
    final now = DateTime.now();
    // Compute Monday of the current ISO week (weekday 1 = Monday).
    final monday = DateTime(now.year, now.month, now.day - (now.weekday - 1));
    final sunday = monday.add(const Duration(days: 6));
    final target = DateTime(year, month, day);
    return !target.isBefore(monday) && !target.isAfter(sunday);
  }

  /// Returns true if this date is Saturday or Sunday.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2026, 5, 30).isWeekend; // true
  /// ```
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Returns true if this year is a leap year.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 2, 29).isLeapYear; // true
  /// ```
  bool get isLeapYear =>
      (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

  // ─────────────────────────────────────────────────────────────────────────
  // SECTION 3 — Layout Presets
  // ─────────────────────────────────────────────────────────────────────────

  /// Returns this date formatted as `"day shortMonth"`, e.g. `"29 May"`.
  ///
  /// Uses the internal [kShortMonths] lookup table — no `intl` required.
  ///
  /// ### Example
  /// ```dart
  /// DateTime(2026, 5, 29).toDayAndMonth(); // "29 May"
  /// ```
  String toDayAndMonth() => '$day ${kShortMonths[month]}';

  /// Returns this time formatted as a 12-hour clock string with AM/PM suffix,
  /// zero-padding both hours and minutes, e.g. `"09:05 AM"`, `"11:30 PM"`.
  ///
  /// Midnight (00:xx) is rendered as `"12:xx AM"` and noon (12:xx) as
  /// `"12:xx PM"`, matching standard 12-hour clock conventions.
  ///
  /// ### Example
  /// ```dart
  /// DateTime(2026, 5, 29, 23, 30).toTime12Hour(); // "11:30 PM"
  /// DateTime(2026, 5, 29, 0, 5).toTime12Hour();   // "12:05 AM"
  /// ```
  String toTime12Hour() {
    final suffix = hour < 12 ? 'AM' : 'PM';
    final h = hour % 12 == 0 ? 12 : hour % 12;
    final m = minute.toString().padLeft(2, '0');
    final hStr = h.toString().padLeft(2, '0');
    return '$hStr:$m $suffix';
  }

  /// Returns a fully human-readable date string in the format
  /// `"Weekday, day shortMonth, year"`, e.g. `"Friday, 29 May, 2026"`.
  ///
  /// Uses the internal [kWeekdays] and [kShortMonths] lookup tables — no
  /// `intl` required.
  ///
  /// ### Example
  /// ```dart
  /// DateTime(2026, 5, 29).toFullHumanDate(); // "Friday, 29 May, 2026"
  /// ```
  String toFullHumanDate() =>
      '${kWeekdays[weekday]}, $day ${kShortMonths[month]}, $year';

  /// Returns date as yyyy-MM-dd.
  /// Example: DateTime(2023, 1, 2).toIsoDateString() => '2023-01-02'
  String toIsoDateString() =>
      '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  /// Returns time as HH:mm:ss.
  /// Example: DateTime(2023, 1, 2, 9, 5, 7).toIsoTimeString() => '09:05:07'
  String toIsoTimeString() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';

  /// Returns time as h:mm a (e.g., 9:05 AM).
  /// Example: DateTime(2026, 5, 30, 9, 5).toShortTimeString() => '9:05 AM'
  String toShortTimeString() {
    final h = hour % 12 == 0 ? 12 : hour % 12;
    final m = minute.toString().padLeft(2, '0');
    final suffix = hour < 12 ? 'AM' : 'PM';
    return '$h:$m $suffix';
  }

  /// Returns date as RFC 2822 string.
  /// Example: DateTime(2026, 5, 30, 9, 5).toRfc2822String() => 'Sat, 30 May 2026 09:05:00 +0000'
  String toRfc2822String() {
    final wday = kWeekdays[weekday].substring(0, 3);
    final mon = kShortMonths[month];
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    final s = second.toString().padLeft(2, '0');
    final offset = isUtc ? '+0000' : '';
    return '$wday, $day $mon $year $h:$m:$s $offset';
  }

  /// Returns true if this date is a business day (Mon-Fri).
  /// Example: DateTime(2026, 5, 30).isBusinessDay => false
  bool get isBusinessDay =>
      weekday >= DateTime.monday && weekday <= DateTime.friday;

  // ─────────────────────────────────────────────────────────────────────────
  // SECTION 4 — Countdown Utilities
  // ─────────────────────────────────────────────────────────────────────────

  /// Returns a human-readable string describing the number of **calendar days**
  /// remaining until this [DateTime].
  ///
  /// Differences are computed relative to **midnight boundaries**, not
  /// absolute 24-hour frames, so the result always reflects the calendar-day
  /// perception a user would expect.
  ///
  /// | Scenario            | Return value   |
  /// |---------------------|----------------|
  /// | Date is today       | `"Today"`      |
  /// | Date is tomorrow    | `"1 day left"` |
  /// | Date is N days away | `"N days left"`|
  /// | Date is in the past | `"Expired"`    |
  ///
  /// ### Example
  /// ```dart
  /// final due = DateTime(2026, 6, 1);
  /// due.daysRemaining(); // "3 days left"  (if today is 29 May 2026)
  /// ```
  String daysRemaining() {
    final nowMidnight = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final targetMidnight = DateTime(year, month, day);
    final diff = targetMidnight.difference(nowMidnight).inDays;

    if (diff < 0) return 'Expired';
    if (diff == 0) return 'Today';
    if (diff == 1) return '1 day left';
    return '$diff days left';
  }

  /// Returns a human-readable string describing the number of **hours**
  /// remaining until this [DateTime].
  ///
  /// The difference is computed as the absolute number of whole hours between
  /// `DateTime.now()` and this date. Sub-hour precision is truncated.
  ///
  /// | Scenario              | Return value      |
  /// |-----------------------|-------------------|
  /// | Exactly 1 hour left   | `"1 hour left"`   |
  /// | N hours left          | `"N hours left"`  |
  /// | DateTime is in past   | `"Expired"`       |
  /// ///
  /// ### Example
  /// ```dart
  /// final meeting = DateTime.now().add(Duration(hours: 5));
  /// meeting.hoursRemaining(); // "5 hours left"
  /// ```
  String hoursRemaining() {
    final diff = difference(DateTime.now()).inHours;
    if (diff < 0) return 'Expired';
    if (diff == 1) return '1 hour left';
    return '$diff hours left';
  }

  /// Returns a copy of this DateTime with specified fields replaced.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2026, 5, 30).copyWith(year: 2027);
  /// ```
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) =>
      DateTime(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        second ?? this.second,
        millisecond ?? this.millisecond,
        microsecond ?? this.microsecond,
      );

  /// Returns a copy at 23:59:59.999.
  /// Example: DateTime(2023, 1, 1).endOfDay => 2023-01-01 23:59:59.999
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Returns true if same year, month, and day.
  /// Example: dt1.isSameDay(dt2)
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Returns true if same year and month.
  /// Example: dt1.isSameMonth(dt2)
  bool isSameMonth(DateTime other) =>
      year == other.year && month == other.month;

  /// Returns true if first day of month.
  /// Example: DateTime(2023, 1, 1).isFirstDayOfMonth => true
  bool get isFirstDayOfMonth => day == 1;

  /// Returns true if last day of month.
  /// Example: DateTime(2023, 2, 28).isLastDayOfMonth => true
  bool get isLastDayOfMonth => day == DateTime(year, month + 1, 0).day;

  /// Returns number of days in month.
  /// Example: DateTime(2024, 2, 1).daysInMonth => 29
  int get daysInMonth => DateTime(year, month + 1, 0).day;

  /// Returns ISO 8601 week number.
  /// Example: DateTime(2023, 1, 4).weekOfYear => 1
  int get weekOfYear {
    final thursday =
        subtract(Duration(days: weekday <= 4 ? weekday - 1 : weekday - 1));
    final firstThursday = DateTime(thursday.year, 1, 4);
    final diff = thursday.difference(firstThursday).inDays;
    return 1 + (diff / 7).floor();
  }

  /// Returns true if this DateTime is in the future.
  /// Example: DateTime.now().add(Duration(days: 1)).isFuture => true
  bool get isFuture => isAfter(DateTime.now());

  /// Returns true if this DateTime is in the past.
  /// Example: DateTime.now().subtract(Duration(days: 1)).isPast => true
  bool get isPast => isBefore(DateTime.now());

  /// Returns a copy of this DateTime for the next day (same time).
  /// Example: DateTime(2026, 5, 30).nextDay => 2026-05-31
  DateTime get nextDay => add(const Duration(days: 1));

  /// Returns a copy of this DateTime for the previous day (same time).
  /// Example: DateTime(2026, 5, 30).previousDay => 2026-05-29
  DateTime get previousDay => subtract(const Duration(days: 1));

  /// Returns a copy with [days] business days added (skips weekends).
  /// Example: DateTime(2026, 5, 29).addBusinessDays(3) => 2026-06-03
  DateTime addBusinessDays(int days) {
    var date = this;
    var added = 0;
    while (added < days) {
      date = date.add(const Duration(days: 1));
      if (date.weekday != DateTime.saturday &&
          date.weekday != DateTime.sunday) {
        added++;
      }
    }
    return date;
  }

  /// Returns a copy with [days] business days subtracted (skips weekends).
  /// Example: DateTime(2026, 6, 3).subtractBusinessDays(3) => 2026-05-29
  DateTime subtractBusinessDays(int days) {
    var date = this;
    var subtracted = 0;
    while (subtracted < days) {
      date = date.subtract(const Duration(days: 1));
      if (date.weekday != DateTime.saturday &&
          date.weekday != DateTime.sunday) {
        subtracted++;
      }
    }
    return date;
  }

  /// Returns the quarter of the year (1-4).
  /// Example: DateTime(2026, 5, 30).quarter => 2
  int get quarter => ((month - 1) ~/ 3) + 1;

  /// Returns true if this date is the first day of its quarter.
  /// Example: DateTime(2026, 4, 1).isQuarterStart => true
  bool get isQuarterStart =>
      (month == 1 || month == 4 || month == 7 || month == 10) && day == 1;

  /// Returns true if this date is the last day of its quarter.
  /// Example: DateTime(2026, 3, 31).isQuarterEnd => true
  bool get isQuarterEnd {
    final lastDay = () {
      switch (month) {
        case 3:
        case 6:
        case 9:
        case 12:
          return DateTime(year, month + 1, 0).day;
        default:
          return -1;
      }
    }();
    return (month == 3 || month == 6 || month == 9 || month == 12) &&
        day == lastDay;
  }

  /// Returns a copy at the start of the week (Monday).
  /// Example: DateTime(2026, 5, 30).startOfWeek => 2026-05-25
  DateTime get startOfWeek => subtract(Duration(days: weekday - 1));

  /// Returns a copy at the end of the week (Sunday).
  /// Example: DateTime(2026, 5, 30).endOfWeek => 2026-05-31
  DateTime get endOfWeek => add(Duration(days: DateTime.sunday - weekday));

  /// Returns a copy at the start of the month (first day, same time).
  /// Example: DateTime(2026, 5, 30).startOfMonth => 2026-05-01
  DateTime get startOfMonth =>
      DateTime(year, month, 1, hour, minute, second, millisecond, microsecond);

  /// Returns a copy at the end of the month (last day, same time).
  /// Example: DateTime(2026, 5, 30).endOfMonth => 2026-05-31
  DateTime get endOfMonth => DateTime(
      year,
      month,
      DateTime(year, month + 1, 0).day,
      hour,
      minute,
      second,
      millisecond,
      microsecond);

  /// Returns a copy at the start of the year (Jan 1, same time).
  /// Example: DateTime(2026, 5, 30).startOfYear => 2026-01-01
  DateTime get startOfYear =>
      DateTime(year, 1, 1, hour, minute, second, millisecond, microsecond);

  /// Returns a copy at the end of the year (Dec 31, same time).
  /// Example: DateTime(2026, 5, 30).endOfYear => 2026-12-31
  DateTime get endOfYear =>
      DateTime(year, 12, 31, hour, minute, second, millisecond, microsecond);

  /// Returns the number of days until [other].
  /// Example: DateTime(2026, 5, 30).daysUntil(DateTime(2026, 6, 2)) => 3
  int daysUntil(DateTime other) => other.difference(this).inDays;

  /// Returns the number of full months between this and [other].
  /// Example: DateTime(2026, 5, 30).monthsBetween(DateTime(2026, 8, 30)) => 3
  int monthsBetween(DateTime other) =>
      (other.year - year) * 12 + (other.month - month);

  /// Returns the number of full years between this and [other].
  /// Example: DateTime(2026, 5, 30).yearsBetween(DateTime(2030, 5, 30)) => 4
  int yearsBetween(DateTime other) => other.year - year;

  /// Returns true if this is within [start] and [end] (inclusive).
  /// Example: dt.isWithin(start, end)
  bool isWithin(DateTime start, DateTime end) =>
      !isBefore(start) && !isAfter(end);

  /// Returns a copy with the given time (hour, minute, second, millisecond).
  /// Example: DateTime(2026, 5, 30).atTime(9, 30) => 2026-05-30 09:30:00
  DateTime atTime(int hour,
          [int minute = 0,
          int second = 0,
          int millisecond = 0,
          int microsecond = 0]) =>
      DateTime(
          year, month, day, hour, minute, second, millisecond, microsecond);

  /// Returns date as MM/dd/yyyy.
  /// Example: DateTime(2026, 5, 30).toShortDateString() => '05/30/2026'
  String toShortDateString() =>
      '${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}/$year';

  /// Returns true if this DateTime is in UTC.
  /// Example: DateTime.now().toUtc().isUtc => true
  bool get isUtc => this.isUtc;

  /// Returns this DateTime as local if not UTC, or as UTC if already UTC.
  /// Example: DateTime.now().toLocalOrUtc()
  DateTime toLocalOrUtc() => isUtc ? toLocal() : toUtc();

  /// Returns a copy with the given time zone offset applied.
  /// Example: DateTime(2026, 5, 30, 12).withTimeZoneOffset(Duration(hours: 2))
  DateTime withTimeZoneOffset(Duration offset) => toUtc().add(offset);

  /// Returns true if this and [other] are in the same ISO week.
  /// Example: dt1.isSameWeek(dt2)
  bool isSameWeek(DateTime other) {
    final monday1 = subtract(Duration(days: weekday - 1));
    final monday2 = other.subtract(Duration(days: other.weekday - 1));
    return monday1.year == monday2.year &&
        monday1.month == monday2.month &&
        monday1.day == monday2.day;
  }

  /// Returns true if this and [other] are in the same year.
  /// Example: dt1.isSameYear(dt2)
  bool isSameYear(DateTime other) => year == other.year;

  /// Returns the Julian Day number for this date.
  /// Example: DateTime(2000, 1, 1).toJulianDay => 2451545
  int get toJulianDay {
    final y = month > 2 ? year : year - 1;
    final m = month > 2 ? month : month + 12;
    final a = (y / 100).floor();
    final b = 2 - a + (a / 4).floor();
    final jd = (365.25 * (y + 4716)).floor() +
        (30.6001 * (m + 1)).floor() +
        day +
        b -
        1524;
    return jd;
  }

  /// Returns a DateTime from a Julian Day number.
  /// Example: DateFormatterExtension.fromJulianDay(2451545) => DateTime(2000, 1, 1)
  static DateTime fromJulianDay(int julianDay) {
    int j = julianDay + 32044;
    int g = j ~/ 146097;
    int dg = j % 146097;
    int c = ((dg ~/ 36524 + 1) * 3) ~/ 4;
    int dc = dg - c * 36524;
    int b = dc ~/ 1461;
    int db = dc % 1461;
    int a = ((db ~/ 365 + 1) * 3) ~/ 4;
    int da = db - a * 365;
    int y = g * 400 + c * 100 + b * 4 + a;
    int m = (da * 5 + 308) ~/ 153 - 2;
    int d = da - ((m + 4) * 153) ~/ 5 + 122;
    int year = y - 4800 + (m + 2) ~/ 12;
    int month = (m + 2) % 12 + 1;
    int day = d + 1;
    return DateTime(year, month, day);
  }
}
