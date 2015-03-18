local LogHelper = {}

--------------------------------------------------------------
-- Printing to console functions with mod name and prefixes --
--------------------------------------------------------------
local MOD_NAME = "Kilala"

function LogHelper.printDebug(message)

	if message then
	print("[".. (MOD_NAME).. "] ".. "[DEBUG] ".. (message))
	end
	
end

function LogHelper.printError(message)
	
	if message then
	print("[".. (MOD_NAME).. "] ".. "[ERROR] ".. (message))
	end
	
end

function LogHelper.printFatal(message)
	
	if message then
	print("[".. (MOD_NAME).. "] ".. "[FATAL] ".. (message))
	end
	
end

function LogHelper.printInfo(message)
	
	if message then
	print("[".. (MOD_NAME).. "] ".. "[INFO] ".. (message))
	end
	
end

function LogHelper.printWarn(message)

	if message then
	print("[".. (MOD_NAME).. "] ".. "[WARN] ".. (message))
	end
	
end

return LogHelper
