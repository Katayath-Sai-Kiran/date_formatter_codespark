
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
