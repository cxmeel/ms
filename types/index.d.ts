type UnitMillisecond = "ms" | "msec" | "msecs" | "millisecond" | "milliseconds"
type UnitSecond = "s" | "sec" | "secs" | "second" | "seconds"
type UnitMinute = "m" | "min" | "mins" | "minute" | "minutes"
type UnitHour = "h" | "hr" | "hrs" | "hour" | "hours"
type UnitDay = "d" | "day" | "days"
type UnitWeek = "w" | "wk" | "wks" | "week" | "weeks"
type UnitMonth = "mo" | "mos" | "month" | "months"
type UnitYear = "y" | "yr" | "yrs" | "year" | "years"

export type Unit = UnitMillisecond | UnitSecond | UnitMinute | UnitHour | UnitDay | UnitWeek | UnitMonth | UnitYear
export type Format = "long" | "short"

export default function toNumber(value: string, unit?: Unit): number;
export default function toString(value: number, format?: Format, inputUnit?: Unit): string;
