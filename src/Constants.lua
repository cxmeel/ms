--!strict
local Utils = require(script.Parent.Utils)

--- @within ms
--- @private
--- @type UnitMillisecond "ms" | "msec" | "msec" | "millisecond" | "milliseconds"
export type UnitMillisecond = "ms" | "msec" | "msec" | "millisecond" | "milliseconds"

--- @within ms
--- @private
--- @type UnitSecond "s" | "sec" | "secs" | "second" | "seconds"
export type UnitSecond = "s" | "sec" | "secs" | "second" | "seconds"

--- @within ms
--- @private
--- @type UnitMinute "m" | "min" | "mins" | "minute" | "minutes"
export type UnitMinute = "m" | "min" | "mins" | "minute" | "minutes"

--- @within ms
--- @private
--- @type UnitHour "h" | "hr" | "hrs" | "hour" | "hours"
export type UnitHour = "h" | "hr" | "hrs" | "hour" | "hours"

--- @within ms
--- @private
--- @type UnitDay "d" | "day" | "days"
export type UnitDay = "d" | "day" | "days"

--- @within ms
--- @private
--- @type UnitWeek "w" | "wk" | "wks" | "week" | "weeks"
export type UnitWeek = "w" | "wk" | "wks" | "week" | "weeks"

--- @within ms
--- @private
--- @type UnitMonth "mo" | "mos" | "month" | "months"
export type UnitMonth = "mo" | "mos" | "month" | "months"

--- @within ms
--- @private
--- @type UnitYear "y" | "yr" | "yrs" | "year" | "years"
export type UnitYear = "y" | "yr" | "yrs" | "year" | "years"

--[=[
	@within ms
	@type Unit UnitMillisecond | UnitSecond | UnitMinute | UnitHour | UnitDay | UnitWeek | UnitMonth | UnitYear
]=]
export type Unit =
	UnitMillisecond
	| UnitSecond
	| UnitMinute
	| UnitHour
	| UnitDay
	| UnitWeek
	| UnitMonth
	| UnitYear

export type TimeSpanSchema = {
	value: number,
	units: { Unit },
	name: string,
	shortName: string,
	stringify: boolean,
}

local MILLISECOND = 1
local SECOND = 1000
local MINUTE = SECOND * 60
local HOUR = MINUTE * 60
local DAY = HOUR * 24
local WEEK = DAY * 7
local YEAR = DAY * 365.243
local MONTH = DAY * 30

local TIMESPAN: { TimeSpanSchema } = {
	{
		value = MILLISECOND,
		units = { "ms", "msec", "msec", "millisecond", "milliseconds" },
		name = "millisecond",
		shortName = "ms",
		stringify = false,
	},
	{
		value = SECOND,
		units = { "s", "sec", "secs", "second", "seconds" },
		name = "second",
		shortName = "s",
		stringify = true,
	},
	{
		value = MINUTE,
		units = { "m", "min", "mins", "minute", "minutes" },
		name = "minute",
		shortName = "m",
		stringify = true,
	},
	{
		value = HOUR,
		units = { "h", "hr", "hrs", "hour", "hours" },
		name = "hour",
		shortName = "h",
		stringify = true,
	},
	{
		value = DAY,
		units = { "d", "day", "days" },
		name = "day",
		shortName = "d",
		stringify = true,
	},
	{
		value = WEEK,
		units = { "w", "wk", "wks", "week", "weeks" },
		name = "week",
		shortName = "w",
		stringify = false,
	},
	{
		value = MONTH,
		units = { "mo", "mos", "month", "months" },
		name = "month",
		shortName = "mo",
		stringify = true,
	},
	{
		value = YEAR,
		units = { "y", "yr", "yrs", "year", "years" },
		name = "year",
		shortName = "y",
		stringify = true,
	},
}

return {
	TIMESPAN = TIMESPAN,
	TIMESPAN_UNIT_MAP = Utils.reduceArray(TIMESPAN, function(accumulator, value)
		for _, unit in value.units do
			accumulator[unit] = value
		end

		return accumulator
	end, {}),

	MILLISECOND = MILLISECOND,
	SECOND = SECOND,
	MINUTE = MINUTE,
	HOUR = HOUR,
	DAY = DAY,
	WEEK = WEEK,
	YEAR = YEAR,
	MONTH = MONTH,
}
