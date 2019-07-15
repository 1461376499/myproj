--code by ZPC 2019/07/15

local BaseUI = class("baseUI", cc.Layer)

BaseUI.UI_File_CSB = ""
BaseUI.Event_Tag = ""

function BaseUI:ctor(...)
	
	self:enableNodeEvents()
	self:loadCsb()
	self:initUI()
	self:initData(...)
	self:addEventDef()
	self:setCascadeOpacityEnabled(true)
end

function BaseUI:onEnter()
	
end

function BaseUI:onEnterTransitionFinish()

end

function BaseUI:onExit()
	self:destory()
end

function BaseUI:destory()

end

function BaseUI:onCleanup()

end

function BaseUI:close()
	if self.dialogLayer then
		self.dialogLayer:close()
	else
		self:runAction(cc.RemoveSelf:create())
	end
end

function BaseUI:initUI()

end


--加载csb文件
function BaseUI:loadCsb()
	local widget = CommonHelper:loadWidget(self.UI_File_CSB)
		:addTo(self)
		:setAnchorPoint(ccAchorPointCenter)
		:setPosition(self:getCenter())
	self.widget = widget
end

--初始化数据
function BaseUI:initData()

end

--初始化事件
function BaseUI:initEvents()
	
end

--注册自定义事件
function BaseUI:addEventDef(event, cb, tag)
	local customEvent = cc.EventListenerCustom:create("", function(event)
		local data = event["_userData"]
		
	end)
end

--注册自定义事件
function BaseUI:addCustomEvent(event, cb, tag)
	local customEvent = cc.EventListenerCustom:create("", function(event)
		local data = event["_userData"]
		
	end)
end


return BaseUI