local M = {}

function M.concatPretty(str1, str2)
	local trunc1 = string.format("%-16s", string.sub(str1, 1, 15)) 
	local trunc2 = string.format("%s", str2) 
	return trunc1 .. "\t" .. trunc2
end

function M.write_to_file(file_name, content)
	local file = io.open(file_name, "a+")
	if file then
		file:write(content)
		file:write("\n")
		file:close()
	else
		print("Error: could open log file")
	end
end

function M.write_table(file_name, tab)
	for _, member in ipairs(tab) do
		M.write_to_file(file_name, member)
	end
end

return M
