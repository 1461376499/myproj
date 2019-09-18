--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local GroupMain = class("GroupMain", BaseUI)


function GroupMain:ctor()
	print("GroupMain:ctor")
	local csb =  "layer/general/confirmpop_layer.csb"
	self:loadCsb(csb)
	local widget = self.widget:getChildByName("widget")
	self.btn_close = widget:getChildByName("btn_close")
	self.btn_close:addClickEventListener(handler(self, self.close))
end

return GroupMain

--endregion
