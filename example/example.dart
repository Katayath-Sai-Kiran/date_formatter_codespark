// Example usage for date_formatter_codespark
// Run with: dart example/example.dart

import 'package:date_formatter_codespark/date_formatter_codespark.dart';

void main() {
  final now = DateTime.now();
  final dt = now.subtract(Duration(minutes: 45));
  print('Relative time: ${dt.toTimeAgo()}'); // "45m ago"

  final future = now.add(Duration(days: 2));
  print('Future relative: ${future.toTimeAgo()}'); // "in 2d"

  final deadline = now.add(Duration(days: 1));
  print('Days remaining: ${deadline.daysRemaining()}'); // "1 day left"

  final expired = now.subtract(Duration(days: 1));
  print('Expired: ${expired.daysRemaining()}'); // "Expired"

  final friday = DateTime(2026, 5, 29); // Assume this is a Friday
  print('Add business day: ${friday.addBusinessDays(1)}'); // Skips to Monday

  final lastBiz = DateTime(2026, 5, 31); // Suppose this is a weekday and last of month
  print('Is last business day: ${lastBiz.isLastBusinessDayOfMonth}');

  print('Is today: ${now.isToday}');
  print('Is leap year: ${DateTime(2026, 2, 29).isLeapYear}');

  print('ISO date: ${now.toIsoDateString()}');
  print('12-hour time: ${now.toTime12Hour()}');

  print('Week of year: ${now.weekOfYear}');
  print('Quarter: ${now.quarter}');
  print('Start of month: ${now.startOfMonth}');
}
