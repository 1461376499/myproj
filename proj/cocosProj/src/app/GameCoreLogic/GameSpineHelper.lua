local GameSpineHelper = class("GameSpineHelper")

function GameSpineHelper:createSpine(path,scale)
	local skel  = path .. ".skel"
	local atlas = path .. ".atlas"
	return sp.SkeletonAnimation:createWithBinaryFile(skel, atlas, scale)
end

--todo
function GameSpineHelper:BonePosConvertToNodePos(spine, scale)
	
end


return GameSpineHelper