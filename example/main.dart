import 'package:flutter/material.dart';
import 'package:date_formatter_codespark/date_formatter_codespark.dart';

void main() {
  runApp(const DateFormatterExampleApp());
}

class DateFormatterExampleApp extends StatelessWidget {
  const DateFormatterExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'date_formatter_codespark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final past = now.subtract(const Duration(minutes: 45));
    final future = now.add(const Duration(days: 2));
    final deadline = now.add(const Duration(days: 1));
    final expired = now.subtract(const Duration(days: 1));
    final friday = DateTime(2026, 5, 29);
    final other = now.add(const Duration(days: 5));
    final holidays = [DateTime(2026, 12, 25), DateTime(2026, 1, 1)];
    final secondFriday =
        DateTime(2026, 5, 1).nthWeekdayOfMonth(DateTime.friday, 2);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text('date_formatter_codespark'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section('📅 Variables Used in This Demo', [
            _row('now', now.toFullHumanDate()),
            _row('past (now − 45 min)', past.toFullHumanDate()),
            _row('future (now + 2 days)', future.toFullHumanDate()),
            _row('deadline (now + 1 day)', deadline.toFullHumanDate()),
            _row('expired (now − 1 day)', expired.toFullHumanDate()),
            _row('friday', friday.toFullHumanDate()),
            _row('other (now + 5 days)', other.toFullHumanDate()),
            _row('holidays[0]', DateTime(2026, 12, 25).toFullHumanDate()),
            _row('holidays[1]', DateTime(2026, 1, 1).toFullHumanDate()),
            _row('secondFriday', secondFriday.toFullHumanDate()),
          ]),
          _section('Relative Time', [
            _row('past.toTimeAgo()', past.toTimeAgo()),
            _row('past.toTimeAgo(short: false)', past.toTimeAgo(short: false)),
            _row('future.toTimeAgo()', future.toTimeAgo()),
          ]),
          _section('Countdown', [
            _row('deadline.daysRemaining()', deadline.daysRemaining()),
            _row('deadline.hoursRemaining()', deadline.hoursRemaining()),
            _row('expired.daysRemaining()', expired.daysRemaining()),
          ]),
          _section('Calendar Flags', [
            _bool('isToday', now.isToday),
            _bool('isYesterday', now.isYesterday),
            _bool('isTomorrow', now.isTomorrow),
            _bool('isThisWeek', now.isThisWeek),
            _bool('isWeekend', now.isWeekend),
            _bool('isBusinessDay', now.isBusinessDay),
            _bool('isFuture', now.isFuture),
            _bool('isPast', now.isPast),
          ]),
          _section('Leap Year & Month Flags', [
            _bool('DateTime(2024,2,1).isLeapYear',
                DateTime(2024, 2, 1).isLeapYear),
            _bool('DateTime(2026,5,1).isFirstDayOfMonth',
                DateTime(2026, 5, 1).isFirstDayOfMonth),
            _bool('DateTime(2026,5,31).isLastDayOfMonth',
                DateTime(2026, 5, 31).isLastDayOfMonth),
            _row('DateTime(2026,5,1).daysInMonth',
                '${DateTime(2026, 5, 1).daysInMonth}'),
            _bool('DateTime(2026,4,1).isQuarterStart',
                DateTime(2026, 4, 1).isQuarterStart),
            _bool('DateTime(2026,3,31).isQuarterEnd',
                DateTime(2026, 3, 31).isQuarterEnd),
          ]),
          _section('Time of Day', [
            _bool('isMorning', now.isMorning),
            _bool('isAfternoon', now.isAfternoon),
            _bool('isEvening', now.isEvening),
            _bool('isNight', now.isNight),
          ]),
          _section('Business Day Logic', [
            _row('friday.nextBusinessDay',
                friday.nextBusinessDay.toIsoDateString()),
            _row('friday.previousBusinessDay',
                friday.previousBusinessDay.toIsoDateString()),
            _row('friday.addBusinessDays(3)',
                friday.addBusinessDays(3).toIsoDateString()),
            _row('friday.subtractBusinessDays(2)',
                friday.subtractBusinessDays(2).toIsoDateString()),
            _row('friday.businessDaysUntil(2026-06-05)',
                '${friday.businessDaysUntil(DateTime(2026, 6, 5))}'),
            _bool('DateTime(2026,5,29).isLastBusinessDayOfMonth',
                DateTime(2026, 5, 29).isLastBusinessDayOfMonth),
            _bool('DateTime(2026,6,1).isFirstBusinessDayOfMonth',
                DateTime(2026, 6, 1).isFirstBusinessDayOfMonth),
            _bool('isLastOccurrenceOfWeekdayInMonth',
                now.isLastOccurrenceOfWeekdayInMonth),
          ]),
          _section('Week / Month / Year Boundaries', [
            _row('endOfDay', '${now.endOfDay.toIsoDateString()} 23:59:59'),
            _row('startOfWeek', now.startOfWeek.toIsoDateString()),
            _row('endOfWeek', now.endOfWeek.toIsoDateString()),
            _row('startOfMonth', now.startOfMonth.toIsoDateString()),
            _row('endOfMonth', now.endOfMonth.toIsoDateString()),
            _row('startOfYear', now.startOfYear.toIsoDateString()),
            _row('endOfYear', now.endOfYear.toIsoDateString()),
            _row('weekOfYear', '${now.weekOfYear}'),
            _row('quarter', '${now.quarter}'),
          ]),
          _section('Date Math', [
            _row('nextDay', now.nextDay.toIsoDateString()),
            _row('previousDay', now.previousDay.toIsoDateString()),
            _row('daysUntil(2026-12-31)',
                '${now.daysUntil(DateTime(2026, 12, 31))}'),
            _row('daysSince(2026-01-01)',
                '${now.daysSince(DateTime(2026, 1, 1))}'),
            _row('monthsBetween(2026-12-01)',
                '${now.monthsBetween(DateTime(2026, 12, 1))}'),
            _row('yearsBetween(2030-05-31)',
                '${now.yearsBetween(DateTime(2030, 5, 31))}'),
            _row('copyWith(year: 2027)',
                now.copyWith(year: 2027).toIsoDateString()),
            _row('atTime(9, 30)', now.atTime(9, 30).toIsoTimeString()),
          ]),
          _section('Comparison Helpers', [
            _bool('isSameDay(now+5d)', now.isSameDay(other)),
            _bool('isSameWeek(now+5d)', now.isSameWeek(other)),
            _bool('isSameMonth(now+5d)', now.isSameMonth(other)),
            _bool('isSameYear(now+5d)', now.isSameYear(other)),
            _bool('isWithin(startOfMonth, endOfMonth)',
                now.isWithin(now.startOfMonth, now.endOfMonth)),
          ]),
          _section('Formatting', [
            _row('toDayAndMonth()', now.toDayAndMonth()),
            _row('toFullHumanDate()', now.toFullHumanDate()),
            _row('toTime12Hour()', now.toTime12Hour()),
            _row('toShortTimeString()', now.toShortTimeString()),
            _row('toShortDateString()', now.toShortDateString()),
            _row('toIsoDateString()', now.toIsoDateString()),
            _row('toIsoTimeString()', now.toIsoTimeString()),
            _row('toRfc2822String()', now.toRfc2822String()),
          ]),
          _section('nth Weekday in Month', [
            _row(
                'nthWeekdayOfMonth(friday, 2)', secondFriday.toIsoDateString()),
          ]),
          _section('Holiday Check', [
            _bool('DateTime(2026,12,25).isPublicHoliday(holidays)',
                DateTime(2026, 12, 25).isPublicHoliday(holidays)),
          ]),
          _section('Fiscal Year', [
            _row('DateTime(2026,2,1).toFiscalYear()',
                '${DateTime(2026, 2, 1).toFiscalYear()}'),
            _row('toFiscalYear(fiscalYearStartMonth: 1)',
                '${DateTime(2026, 5, 1).toFiscalYear(fiscalYearStartMonth: 1)}'),
          ]),
          _section('Julian Day', [
            _row('DateTime(2000,1,1).toJulianDay',
                '${DateTime(2000, 1, 1).toJulianDay}'),
            _row(
                'fromJulianDay(2451545)',
                DateFormatterExtension.fromJulianDay(2451545)
                    .toIsoDateString()),
          ]),
          _section('UTC & Timezone', [
            _row('toLocalOrUtc()', now.toLocalOrUtc().toIsoDateString()),
            _row(
                'withTimeZoneOffset(+5:30)',
                now
                    .withTimeZoneOffset(const Duration(hours: 5, minutes: 30))
                    .toIsoTimeString()),
          ]),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> rows) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.indigo,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(children: rows),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF444444),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 4,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.indigo,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bool(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF444444),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: value ? Colors.green.shade50 : Colors.red.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: value ? Colors.green.shade300 : Colors.red.shade300,
              ),
            ),
            child: Text(
              value ? 'true' : 'false',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: value ? Colors.green.shade700 : Colors.red.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
