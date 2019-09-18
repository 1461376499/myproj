--code by ZPC 2019/07/15

local CommonUIDialog = require("app.Core.Common.CommonUIDialog")

local BaseUI = class("BaseUI", cc.Layer)

function BaseUI:ctor(uidef, args)	
	self.name = self.__cname
	print("BaseUI:ctor",self.name)
	self:setName(self.name)
	
	self:initialization(uidef, args)
end


function BaseUI:onEnter()
	print("BaseUI:onEnter", self.name)
	if not self._isDialog and self.openCallback then	
		self.willOpenCallback()
	end
end

function BaseUI:onEnterTransitionFinish()
	--UI打开后的调用
	print("BaseUI:onEnterTransitionFinish", self.name)
	if not self._isDialog and self.openCallback then	
		self.openedCallback()
	end
end

--初始化
--@prama1 uidef
--@prama2 其他参数
function BaseUI:initialization(uidef, args)
	if uidef == nil then
		return;
	end
	self.uidef = uidef

	self:_initBase()
	self:_bindModel()
	self:_addEventDef()
	self:_loadCsb()

	--调用派生类的init
	self:init(args)
	self:initFinish()
end

--请重写
function BaseUI:init()
	
end

--请重写/初始化UI
function BaseUI:initUI()

end

--请重写/初始化事件
function BaseUI:addEvents()
	
end

--多态函数/初始化数据完成
function BaseUI:initFinish()
	
end

--即将退出
function BaseUI:onExit()
	print("BaseUI:onExit", self.name)	
	self:destory()
end

--多态函数
function BaseUI:destory()
	
end

--清理界面之后
function BaseUI:onCleanup()	
	print("BaseUI:onCleanup", self.name)
	EventDispatcher:removeListener(self)
	self:disableNodeEvents()
	UICacheManager:free(self.widget)
	self:_destory()	
end

--注册自定义事件
--@param1:子事件名
--@param2:监听函数
function BaseUI:addCustomEvent(sub, callFunc)
	if self.Model == nil then
		return;
	end
	local key = self.Model.VIEW_EVENT_BINDING[sub]
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
function BaseUI:setWillOpenCallback(cb)
	if self.dialogLayer then
		self.dialogLayer:setWillOpenCallback(cb)
	else
		self.willOpenCallback = cb
	end
	return self
end

--打开UI回调
function BaseUI:setOpenedCallback(cb)
	if self.dialogLayer then
		self.dialogLayer:setOpenedCallback(cb)
	else
		self.openedCallback = cb
	end
	return self
end

--关闭UI回调
function BaseUI:setWillCloseCallback(cb)
	if self.dialogLayer then
		self.dialogLayer:setWillCloseCallback(cb)
	else
		self.willCloseCallback = cb
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
--初始化通用属性
function BaseUI:_initBase()
	
	--自定义事件列表
	self.customEventArray = {}

	--节点事件
	self:enableNodeEvents()
	
	--设置变色
	self:setCascadeOpacityEnabled(true)

	--当前场景变量
	self.scene = SceneManager:getRunningScene()

	--注册全局监听
	EventDispatcher:registerListener(self)

	--设置名字
	self:setName(self.uidef.name)
end

--加载实例
function BaseUI:_bindModel()
	local model = self.uidef.model
	if model == nil or model == "" then
		return
	end
	self.Model = require(self.uidef.model).new()
end


--加载csb文件
function BaseUI:_loadCsb()
	local csb = self.uidef.csb
	if csb == "" then
		return;
	end
	--不直接加载csb文件了,用下面加载并缓存csb
	--local widget = CommonHelper:loadWidget(csb)
	local widget = UICacheManager:get(csb,self)
		--:addTo(self)
		:setAnchorPoint(ccAchorPointCenter)
		:setPosition(self:getCenter())
	self.widget = widget

	
end

--销毁实例
function BaseUI:_destoryImp()
	if self.Model then
		self.Model:destory()
		self.Model = nil
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
	if self.Model == nil then
		return;
	end
	self.customEventListener = cc.EventListenerCustom:create(self.Model.VIEW_EVENT_BINDING["KEY"], function(eventData)
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