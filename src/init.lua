--!strict
local CONST = require(script.Constants)

local function getUnitMetadata(contraction: string?): CONST.TimeSpanSchema?
	return if contraction then CONST.TIMESPAN_UNIT_MAP[contraction] else nil
end

local function pluralize(quantity: number, value: string): string
	return if quantity == 1 or value:sub(-1) == "s" then value else `{value}s`
end

local function parse(value: string): number
	assert(typeof(value) == "string", `expected string, got "{value}" ({typeof(value)})`)

	local valueAsNumber = tonumber(value)

	if
		valueAsNumber
		and assert(
			valueAsNumber ~= math.huge and valueAsNumber ~= -math.huge,
			`value must be finite`
		)
	then
		return valueAsNumber
	end

	local accumulator, matchedOnce = 0, false

	for matchedSign, matchedLength, matchedSpan in
		value:lower():gmatch(`(%-?)(%.?%d+%.?%d*)%s*(%a+)`)
	do
		if not matchedLength or not matchedSpan then
			error(`invalid string "{value}"`, 2)
		end

		local unit, length = getUnitMetadata(matchedSpan), tonumber(matchedLength)
		local multiplier = matchedSign == "-" and -1 or 1

		if not length or not unit then
			error(`invalid string "{value}"`, 2)
		end

		matchedOnce = true
		accumulator += length * multiplier * unit.value
	end

	if not matchedOnce then
		error(`invalid string "{value}"`, 2)
	end

	return accumulator
end

--[=[
	@within ms

	Converts a string to a number. The output number is in milliseconds unless
	a unit is specified.

	```lua
	ms.toNumber("1m 30s") -- 90000
	ms.toNumber("1m 30s", "s") -- 90
	```

	@param unit Unit?
]=]
local function toNumber(value: string, unit: CONST.Unit?): number
	local outputValue, unitMetadata = parse(value), getUnitMetadata(unit or "ms")

	return if unitMetadata and unitMetadata.shortName ~= "ms"
		then outputValue / unitMetadata.value
		else outputValue
end

--[=[
	@within ms

	Converts a number to a string. The number is assumed to be in milliseconds.
	unless an inputUnit is specified. Values are rounded to the nearest whole
	number. Weeks are not displayed. Milliseconds are not displayed unless the
	input value is less than 1 second.

	```lua
	ms.toString(9000) -- "9s"
	ms.toString(9001) -- "9s"
	ms.toString(90, "long") -- "90 milliseconds"

	ms.toString(9, nil, "s") -- "9s"
	ms.toString(9, "long", "s") -- "9 seconds"
	```

	@param inputUnit Unit?
]=]
local function toString(value: number, format: "long" | "short"?, inputUnit: CONST.Unit?): string
	assert(value ~= math.huge and value ~= -math.huge and value == value, `value must be finite`)

	local inputUnitMetadata = getUnitMetadata(inputUnit or "ms")
		or getUnitMetadata("ms") :: CONST.TimeSpanSchema

	print(inputUnitMetadata)

	local valueAbs = math.abs(value) * inputUnitMetadata.value
	local valueSign = value > 0 and "" or "-"
	local outputValue = {}

	for index = #CONST.TIMESPAN, 1, -1 do
		local unit = CONST.TIMESPAN[index]

		if valueAbs < unit.value or not unit.stringify then
			continue
		end

		local unitValue = math.round(valueAbs / unit.value)
		valueAbs -= unitValue * unit.value

		if format == "long" then
			table.insert(outputValue, `{unitValue} {pluralize(unitValue, unit.name)}`)
			continue
		end

		table.insert(outputValue, `{unitValue}{unit.shortName}`)
	end

	if #outputValue == 0 then
		return format == "long" and `{value} milliseconds` or `{value}ms`
	end

	return `{valueSign}{table.concat(outputValue, ", ")}`
end

--[=[
	@class ms

	Provides functions for converting between milliseconds and strings.

	```lua
	local ms = require(packages.ms)

	ms.toNumber("1m 30s") -- 90000
	ms.toString(90000) -- "1m 30s"
	```

	ms also employs some metatable magic to allow for calling the module
	as a function. ms will automatically determine whether to call
	`ms.toNumber` or `ms.toString` based on the type of the first argument.

	```lua
	ms("1m 30s") -- 90000
	ms(90000) -- "1m 30s"
	ms(ms("1m 30s")) -- "1m 30s"

	ms("1d", "s") -- 86400
	ms(90000, "long") -- "1 minute, 30 seconds"
	```
]=]
local module = setmetatable({
	toNumber = toNumber,
	toString = toString,
}, {
	__call = function(_, value, ...): string | number
		if typeof(value) == "number" then
			return toString(value, ...)
		elseif typeof(value) == "string" then
			return toNumber(value, ...)
		end

		error(`expected string or number, got "{value}" ({typeof(value)})`, 2)
	end,
})

return module
