--!strict
local function reduceArray<T, R>(
	array: { T },
	reducer: (accumulator: R, value: T, index: number, array: { T }) -> R,
	initReduction: R?
): R
	local result: R, start = initReduction :: never, 1

	if not result then
		result, start = array[1] :: never, 2
	end

	for index = start, #array do
		result = reducer(result, array[index], index, array)
	end

	return result
end

local function concatArrays<T>(...: any): { T }
	local result = {}

	for arrayIndex = 1, select("#", ...) do
		local array = select(arrayIndex, ...)

		if type(array) ~= "table" then
			continue
		end

		for _, item in ipairs(array) do
			table.insert(result, item)
		end
	end

	return result
end

return {
	reduceArray = reduceArray,
	concatArrays = concatArrays,
}
