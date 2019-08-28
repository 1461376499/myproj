local GameSpineHelper = class("GameSpineHelper")

function GameSpineHelper:createSpine(path, callfunc, scale)
	local skel  = path .. ".skel"
	local atlas = path .. ".atlas"
	scale = scale or 1
	local spine = sp.SkeletonAnimation:createWithBinaryFile(skel, atlas, scale)
	local function func(...)
		callfunc(spine, ...)
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