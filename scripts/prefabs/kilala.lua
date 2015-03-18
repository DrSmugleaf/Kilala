
local MakePlayerCharacter = require "prefabs/player_common"

local assets = {}
local prefabs = {}
local start_inv = {}


local common_postinit = function(inst)
end

local master_postinit = function(inst)
end


return MakePlayerCharacter("kilala", prefabs, assets, common_postinit, master_postinit, start_inv)