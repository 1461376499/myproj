--code by zpc

ccp = cc.p;
vec2 = cc.p;
vec3 = cc.p;

ccSize = cc.size

rgb = cc.c3b

rgba = cc.c4b

ccAchorPointCenter = cc.p(0.5,0.5)

ccDirector = cc.Director:getInstance()

ccFileUtils = cc.FileUtils:getInstance()

ccUserDefault = cc.UserDefault:getInstance()

ccUtils = cc.utils

release_print = release_print

ccLuaCast = tolua.cast

FALSE = false

TRUE  = true


local Node = cc.Node
--获取节点坐标的节点中心位置
function Node:getCenter()
	local size = self:getContentSize()
	local sx, sy = self:getScaleX(), self:getScaleY()
	return cc.p(size.width * sx * 0.5, size.height * sy * 0.5)
end
