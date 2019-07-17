local CommonHelper = class("CommonHelper")
	
function CommonHelper:ctor()
	

end

--添加一个UI
--@param1:UIDefine里定义的名字
--@param2:是否是弹窗,默认都是弹窗
--@param3:父节点
--@param4:层级
--@param5:标识
function CommonHelper:addUI(uiDef, isDialog, parent, zorder, tag)
	local script = uiDef.script	
	if isDialog == nil then
		isDialog = true
	end
	parent   = parent   or SceneHelper:getRunningScene()
	zorder   = zorder   or 0
	tag      = tag	    or ""
	local ui = require(script).new()
	if isDialog then
		ui:addToNode(parent, zorder, tag)
		ui:show()
	end
	return ui
end

function CommonHelper:loadWidget(csb)
	local widget = cc.CSLoader:createNode(csb)
	widget:setPosition(display.center)
	widget:setAnchorPoint(ccAchorPointCenter)

	self:onAdaptCoord(widget)
	return widget
end

--[[
	靠边布局
]]--
function CommonHelper:onAdaptCoord(_widget)
    local panel_left = _widget:getChildByName("panel_left")
    if panel_left ~= nil then
        panel_left:setPositionX(panel_left:getPositionX()-display.cx)
    end  

    local panel_right = _widget:getChildByName("panel_right")
    if panel_right ~= nil then
        panel_right:setPositionX(panel_right:getPositionX() + display.cx)
    end  
end

--[[
	将一个数字格式的颜色转换为rgba颜色
]]--
function CommonHelper:colorConvert( color )
	local c = string.format("%d",color)

	local r = math.floor(c/256/256/256)
	local g = math.floor(c/256/256%256)
	local b = math.floor(c/256%256)
	local a = math.floor(c%256)
	
	return cc.c4b(r, g, b, a)
end

--[[
	
]]--

return CommonHelper