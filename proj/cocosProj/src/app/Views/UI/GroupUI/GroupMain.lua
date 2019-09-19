--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local GroupMain = class("GroupMain", BaseUI)


function GroupMain:ctor()
	self:initBase()
	self:loadCsb("layer/general/confirmpop_layer.csb")
	local widget = self.widget:getChildByName("widget")
	self.btn_close = widget:getChildByName("btn_close")
	self.btn_close:addClickEventListener(handler(self, self.close))
	UICacheManager:put("layer/bangzhu.csb", 5)
end

return GroupMain

--endregion
