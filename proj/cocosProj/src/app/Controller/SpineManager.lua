--[[
	spine动画的缓存已经在spine.lib里做了缓存
]]

local GameSpineHelper = class("GameSpineHelper")

function GameSpineHelper:createSpine(path, callfunc, scale)
	local skel  = path .. ".skel"
	local atlas = path .. ".atlas"
	scale = scale or 1
	local spine = sp.SkeletonAnimation:createWithBinaryFile(skel, atlas, scale)
	local function func(...)
		if callfunc then
			callfunc(spine, ...)
		end
	end
	spine:registerSpineEventHandler(func, sp.EventType.ANIMATION_START) 
	spine:registerSpineEventHandler(func, sp.EventType.ANIMATION_END) 
	spine:registerSpineEventHandler(func, sp.EventType.ANIMATION_COMPLETE)
	spine:registerSpineEventHandler(func, sp.EventType.ANIMATION_EVENT)
	
	return spine
end

--todo
function GameSpineHelper:BonePosConvertToNodePos(spine, scale)
	
end


return GameSpineHelper