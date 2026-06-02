## 1.3.0 — 2026-06-02

### Documentation & Presentation
* Added pub points, pub likes, platform (Flutter), and custom "DateTime Extensions" badges to README.
* Added author credit line to README.
* Added a 6-image screenshots gallery section to README (captured from iPhone 15 Plus simulator).
* Registered screenshots in `pubspec.yaml` so pub.dev displays them on the package page.
* Renamed `aassets/` folder to `assets/` and gave screenshots clean filenames.
* Bumped installation reference in README to `^1.3.0`.

---

## 1.2.0 — 2026-05-31

* Added `isMorning`, `isAfternoon`, `isEvening`, `isNight` for time-of-day checks.
* Added `isFirstBusinessDayOfMonth` for business calendar logic.
* Added `nthWeekdayOfMonth(int weekday, int n)` for finding the nth weekday in a month.
* Added `isLastOccurrenceOfWeekdayInMonth` for last weekday occurrence in month.
* Added `daysSince(DateTime other)` for day difference.
* Added `isPublicHoliday(List<DateTime> holidays)` for holiday checks.
* Added `toFiscalYear({int fiscalYearStartMonth = 4})` for fiscal year calculation.
* Added `nextBusinessDay` and `previousBusinessDay` for business day navigation.
* Added `businessDaysUntil(DateTime other)` to count business days between two dates.

## 1.1.0 

* Added `isLastBusinessDayOfMonth` for business day calculations.

## 1.0.0 

* Initial stable release.
* Added `toTimeAgo()` for semantic relative human-readable time strings.
* Added boundary evaluation flags (`isToday`, `isYesterday`, `isTomorrow`, `isThisWeek`).
* Added high-frequency design layout presets (`toDayAndMonth`, `toTime12Hour`, `toFullHumanDate`).
* Added precise countdown trackers (`daysRemaining`, `hoursRemaining`).
	* Business day math: `isBusinessDay`, `addBusinessDays`, `subtractBusinessDays`, `isLastBusinessDayOfMonth`
* Week/year/quarter logic: `weekOfYear`, `quarter`, `isQuarterStart`, `isQuarterEnd`, `startOfWeek`, `endOfWeek`, `startOfMonth`, `endOfMonth`, `startOfYear`, `endOfYear`, `isSameWeek`, `isSameMonth`, `isSameYear`, `daysInMonth`, `isFirstDayOfMonth`, `isLastDayOfMonth`
* Julian day support: `toJulianDay`, `fromJulianDay`
* Advanced formatting: `toIsoDateString`, `toIsoTimeString`, `toShortTimeString`, `toShortDateString`, `toRfc2822String`
* Utility flags: `isLeapYear`, `isWeekend`, `isFuture`, `isPast`, `isUtc`, `toLocalOrUtc`, `withTimeZoneOffset`, `isWithin`
* Date math: `copyWith`, `nextDay`, `previousDay`, `daysUntil`, `monthsBetween`, `yearsBetween`, `atTime`
* No breaking changes; all previous APIs remain.
* All methods are documented with concise, AI-friendly doc comments and examples.
