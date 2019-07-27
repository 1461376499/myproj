--code by ZPC 2019/07/15

local CommonUIDialog = require("app.CommonUtils.CommonUIDialog")

local BaseUI = class("BaseUI", cc.Layer)

--全局事件标识
BaseUI.EventTag = ""

--不要在子类和基本的构造函数里执行太多的代码，否则会使init函数的UI初始化变得缓慢
function BaseUI:ctor()
	--自定义事件列表
	self.customEventArray = {}

	--节点事件
	self:enableNodeEvents()
	
	--设置变色
	self:setCascadeOpacityEnabled(true)

	--当前场景变量
	self.scene = SceneHelper:getRunningScene()

	--注册全局监听
	GlobalHelper:registerListener(self, self.EventTag)
end

function BaseUI:onEnterTransitionFinish()
	--UI打开后的调用
	if self.openCallback then	
		self.openCallback()
	end
end

--初始化
--@prama1 uidef
--@prama2 其他参数
function BaseUI:init(uidef, args)
	self.csbBinding = uidef.csb
	self.implentBinding = uidef.implent
	self.args = args

	self:_bindImplent()
	self:_addEventDef()
	self:_loadCsb()

	self:initUI()
	self:initData(args)
	self:addEvents()
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

--即将退出
function BaseUI:onExit()
	
	self:destory()
end

----多态函数/销毁UI
function BaseUI:destory()
	
end

--清理界面
function BaseUI:onCleanup()
	self:_destory()
	self:disableNodeEvents()
	GlobalHelper:removeListener(self.EventTag)
end

--注册自定义事件
--@param1:子事件名
--@param2:监听函数
function BaseUI:addCustomEvent(sub, callFunc)
	if self.Implent == nil then
		return;
	end
	local key = self.Implent.VIEW_EVENT_BINDING[sub]
	self.customEventArray[key] = callFunc
end

--关闭界面(如果是弹窗类型的界面,关闭对应的弹窗)
function BaseUI:close()
	if self.dialogLayer then
		self.dialogLayer:close()
	else
		self:runAction(cc.RemoveSelf:create())
		if self.closeCallback then
			self.closeCallback()
			self.closeCallback = nil
		end
	end
end

--打开UI回调
function BaseUI:setOpenCallback(cb)
	if self.dialogLayer then
		self.dialogLayer:setOpenCallback(cb)
	else
		self.openCallback = cb
	end
	return self
end

--关闭UI回调
function BaseUI:setClosedCallback(cb)
	if self.dialogLayer then
		self.dialogLayer:setClosedCallback(cb)
	else
		self.closeCallback = cb
	end
	return self
end

--添加到节点 弹窗类型的layer
function BaseUI:addToNode(toNode)
	local dialog = CommonUIDialog.new(self)
	dialog:addToNode(toNode)
	self.dialogLayer = dialog
	return self
end

--显示当前UI
function BaseUI:show(showType)
	if self.dialogLayer then
		self.dialogLayer:show(showType)
	else
		self:setVisible(true)
	end
	return self
end










-----------------------------------internal function ---------------------------------------------
--加载实例
function BaseUI:_bindImplent()
	if self.implentBinding == nil or self.implentBinding == "" then
		return
	end
	self.Implent = require(self.implentBinding).new()
end


--加载csb文件
function BaseUI:_loadCsb()
	if self.csbFile == "" then
		return;
	end
	local widget = CommonHelper:loadWidget(self.csbBinding)
		:addTo(self)
		:setAnchorPoint(ccAchorPointCenter)
		:setPosition(self:getCenter())
	self.widget = widget
end

--销毁实例
function BaseUI:_destoryImp()
	if self.Implent then
		self.Implent:destory()
		self.Implent = nil
	end
end

--销毁界面
function BaseUI:_destory()
	
	--移除监听
	if self.customEventListener then
		self:getEventDispatcher():removeEventListener(self.customEventListener)
		self.customEventListener = nil
	end

	--销毁数据实例
	self:_destoryImp()
end

--注册自定义事件
function BaseUI:_addEventDef()
	if self.Implent == nil then
		return;
	end
	self.customEventListener = cc.EventListenerCustom:create(self.Implent.VIEW_EVENT_BINDING["KEY"], function(eventData)
		local userData = eventData["_userData"]
		local sub	   = userData["sub"]
		local data	   = userData["data"]
		local callFunc = self.customEventArray[sub]
		if callFunc then
			callFunc(data)
		end
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.customEventListener, self)
end


return BaseUI