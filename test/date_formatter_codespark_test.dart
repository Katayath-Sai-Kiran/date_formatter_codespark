import 'package:flutter_test/flutter_test.dart';
import 'package:date_formatter_codespark/date_formatter_codespark.dart';

void main() {
  // ── toTimeAgo ────────────────────────────────────────────────────────────
  group('toTimeAgo', () {
    test('returns seconds ago (short)', () {
      final date = DateTime.now().subtract(const Duration(seconds: 30));
      expect(date.toTimeAgo(), '30s ago');
    });

    test('returns minutes ago (short)', () {
      final date = DateTime.now().subtract(const Duration(minutes: 12));
      expect(date.toTimeAgo(), '12m ago');
    });

    test('returns hours ago (short)', () {
      final date = DateTime.now().subtract(const Duration(hours: 3));
      expect(date.toTimeAgo(), '3h ago');
    });

    test('returns days ago (short)', () {
      final date = DateTime.now().subtract(const Duration(days: 2));
      expect(date.toTimeAgo(), '2d ago');
    });

    test('returns minutes ago (verbose)', () {
      final date = DateTime.now().subtract(const Duration(minutes: 1));
      expect(date.toTimeAgo(short: false), '1 minute ago');
    });

    test('returns future minutes (short)', () {
      final date = DateTime.now().add(const Duration(minutes: 5, seconds: 30));
      expect(date.toTimeAgo(), 'in 5m');
    });

    test('returns future hours verbose', () {
      final date = DateTime.now().add(const Duration(hours: 1, minutes: 30));
      expect(date.toTimeAgo(short: false), 'in 1 hour');
    });
  });

  // ── Calendar boundary flags ───────────────────────────────────────────────
  group('isToday / isYesterday / isTomorrow / isThisWeek', () {
    test('isToday is true for DateTime.now()', () {
      expect(DateTime.now().isToday, isTrue);
    });

    test('isYesterday is true for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(yesterday.isYesterday, isTrue);
    });

    test('isTomorrow is true for tomorrow', () {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      expect(tomorrow.isTomorrow, isTrue);
    });

    test('isThisWeek is true for DateTime.now()', () {
      expect(DateTime.now().isThisWeek, isTrue);
    });

    test('isThisWeek is false for a date 10 days ago', () {
      final old = DateTime.now().subtract(const Duration(days: 10));
      expect(old.isThisWeek, isFalse);
    });
  });

  // ── Layout presets ────────────────────────────────────────────────────────
  group('toDayAndMonth', () {
    test('formats correctly', () {
      expect(DateTime(2026, 5, 29).toDayAndMonth(), '29 May');
    });
  });

  group('toTime12Hour', () {
    test('formats PM correctly', () {
      expect(DateTime(2026, 5, 29, 23, 30).toTime12Hour(), '11:30 PM');
    });

    test('formats midnight as 12:xx AM', () {
      expect(DateTime(2026, 5, 29, 0, 5).toTime12Hour(), '12:05 AM');
    });

    test('formats noon as 12:xx PM', () {
      expect(DateTime(2026, 5, 29, 12, 0).toTime12Hour(), '12:00 PM');
    });

    test('pads single-digit minutes', () {
      expect(DateTime(2026, 5, 29, 9, 5).toTime12Hour(), '09:05 AM');
    });
  });

  group('toFullHumanDate', () {
    test('formats Friday 29 May 2026 correctly', () {
      expect(DateTime(2026, 5, 29).toFullHumanDate(), 'Friday, 29 May, 2026');
    });
  });

  // ── Countdown utilities ───────────────────────────────────────────────────
  group('daysRemaining', () {
    test('returns Today for current date', () {
      expect(DateTime.now().daysRemaining(), 'Today');
    });

    test('returns 1 day left for tomorrow', () {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      expect(tomorrow.daysRemaining(), '1 day left');
    });

    test('returns N days left', () {
      final future = DateTime.now().add(const Duration(days: 5));
      expect(future.daysRemaining(), '5 days left');
    });

    test('returns Expired for past date', () {
      final past = DateTime.now().subtract(const Duration(days: 3));
      expect(past.daysRemaining(), 'Expired');
    });
  });

  group('hoursRemaining', () {
    test('returns Expired for past datetime', () {
      final past = DateTime.now().subtract(const Duration(hours: 2));
      expect(past.hoursRemaining(), 'Expired');
    });

    test('returns 1 hour left', () {
      final oneHour = DateTime.now().add(const Duration(hours: 1, seconds: 30));
      expect(oneHour.hoursRemaining(), '1 hour left');
    });

    test('returns N hours left', () {
      final fiveHours =
          DateTime.now().add(const Duration(hours: 5, seconds: 30));
      expect(fiveHours.hoursRemaining(), '5 hours left');
    });
  });
}
