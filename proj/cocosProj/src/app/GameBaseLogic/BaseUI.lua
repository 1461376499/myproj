--code by ZPC 2019/07/15

local BaseUI = class("baseUI", cc.Layer)

BaseUI.CSB_BINDING = ""				--CSB文件路径
BaseUI.IMPLENT_BINDING = 0					--数据层实例

function BaseUI:ctor(...)
	self.EventArray = {}
	self:enableNodeEvents()

	self:_bindImplent()
	self:_addEventDef()
	self:_loadCsb()

	self:initUI()
	self:initData(...)
	self:addEvents()

	self:setCascadeOpacityEnabled(true)
end

function BaseUI:onEnterTransitionFinish()
	
end

function BaseUI:onExit()
	self:destory()
end

--多态函数/初始化UI
function BaseUI:initUI()

end

----多态函数/初始化数据
function BaseUI:initData()

end

--多态函数/初始化事件
function BaseUI:addEvents()
	
end

----onExit里调用
function BaseUI:destory()
	
end

--销毁实例
function BaseUI:destoryImp()
	if self.Implent then
		self.Implent:destory()
		self.Implent = nil
	end
end

--清理界面
function BaseUI:onCleanup()
	self:_destory()
end

--注册自定义事件
--@param1:子事件名
--@param2:监听函数
function BaseUI:addCustomEvent(sub, callFunc)
	local key = self.Implent.VIEW_EVENT_BINDING[sub]
	self.EventArray[key] = callFunc
end

--关闭界面(如果是弹窗类型的界面,关闭对应的弹窗)
function BaseUI:close()
	if self.dialogLayer then
		self.dialogLayer:close()
	else
		self:runAction(cc.RemoveSelf:create())
	end
end


-----------------------------------internal function ---------------------------------------------
--加载实例
function BaseUI:_bindImplent()
	print("加载实例")
	self.Implent = require("app.GameMainUI.UIImplentLogic.".. self.IMPLENT_BINDING).new()
end


--加载csb文件
function BaseUI:_loadCsb()
	
	local fullPath = ccFileUtils:fullPathForFilename("main.lua")
	print("加载CSB",fullPath)
	local widget = CommonHelper:loadWidget(self.CSB_BINDING)
		:addTo(self)
		:setAnchorPoint(ccAchorPointCenter)
		:setPosition(self:getCenter())
	self.widget = widget
end



--销毁界面
function BaseUI:_destory()
	self:getEventDispatcher():removeEventListener(self.customEventListener, self)
	self:destoryImp()
end

--注册自定义事件
function BaseUI:_addEventDef()
	self.customEventListener = cc.EventListenerCustom:create(self.Implent.VIEW_EVENT_BINDING["KEY"], function(eventData)
		local userData = eventData["_userData"]
		local sub	   = userData["sub"]
		local data	   = userData["data"]
		local callFunc = self.EventArray[sub]
		if callFunc then
			callFunc(data)
		end
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.customEventListener, self)
end


return BaseUI