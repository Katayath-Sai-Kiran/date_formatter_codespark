## 1.5.0 — 2026-06-05

* Updated screenshots layout in README to a more compact 2-row grid, improving visual presentation and readability.
* Bumped version to `1.5.0` for a minor update focused on SEO and discoverability improvements, without any breaking changes or new features.
* All existing APIs remain unchanged and fully compatible with previous versions.

## 1.4.0 — 2026-06-05

* Updated package description in `pubspec.yaml` to: "Date formatter with DateTime extensions for date formatting, datetime formatting, relative time, time ago, human-readable dates, timestamps, and custom date formats."
* Bumped version to `1.4.0` for a minor update focused on SEO and discoverability improvements, without any breaking changes or new features.
* All existing APIs remain unchanged and fully compatible with previous versions.

## 1.3.1 — 2026-06-05

### SEO & Discoverability
* Rewrote `pubspec.yaml` description with keyword-rich copy targeting pub.dev search:
  *"date formatting, datetime formatting, relative time, time ago, human-readable dates, timestamps, custom date formats"*.
* Replaced generic `topics` with targeted, search-optimised pub.dev topics:
  `date-formatting`, `datetime`, `date-formatter`, `time-ago`, `datetime-extension`.
* Added `npm-package-prompt.md` — a ready-to-use Copilot prompt for developers who
  want to port the package to npm (`date-spark`), improving cross-ecosystem discoverability.

### Code Quality
* Fixed deprecated `withOpacity` → `withValues(alpha:)` in `example/main.dart`.
* Removed unnecessary `library date_formatter_codespark;` name directive from barrel file.
* Renamed private local function `_label` → `label` in `date_extensions.dart` to comply with
  `no_leading_underscores_for_local_identifiers` lint rule.
* `dart analyze` reports **0 issues**

---

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
