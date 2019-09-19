--code by ZPC 2019/07/15

local CommonUIDialog = require("app.Core.Common.CommonUIDialog")

local BaseUI = class("BaseUI", cc.Layer)

function BaseUI:ctor(uidef, args)	
	self.name = self.__cname
	self:setName(self.name)
	print("BaseUI:ctor",self.name)

	if uidef == nil then
		print("配置有误",self.name)
		return;
	end
	self._isDialog = false	--是否是弹窗

	self._uidef = uidef

	self:_initBase()
	self:_loadCsb()
	self:_addEventDef()
	self:_bindModel()

	self:init(args)
	self:initFinish()
end

function BaseUI:onEnter()
	if not self._isDialog and self.willOpenCallback then	
		self:willOpenCallback()
		self.willOpenCallback = nil
	end
end

function BaseUI:onEnterTransitionFinish()
	if not self._isDialog and self.openedCallback then	
		self:openedCallback()
		self.openedCallback = nil
	end
end

--初始化
function BaseUI:initBase()
	self:_initBase()
	self:_addEventDef()
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
	self:destory()
	if not self._isDialog and self.willCloseCallback then
		self:willCloseCallback()
		self.willCloseCallback = nil
	end
end

function BaseUI:destory()
	
end

--清理界面之后
function BaseUI:onCleanup()	

	EventDispatcher:removeListener(self)

	self:disableNodeEvents()

	UICacheManager:free(self.widget)

	self:_destory()

	if not self._isDialog and self.closedCallback then
		self:closedCallback()
		self.closedCallback = nil
	end	
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
	end
end

--打开UI前回调
function BaseUI:setWillOpenCallback(cb)
	if self.dialogLayer then
		self.dialogLayer:setWillOpenCallback(cb)
	else
		self.willOpenCallback = cb
	end
	return self
end

--打开UI后回调
function BaseUI:setOpenedCallback(cb)
	if self.dialogLayer then
		self.dialogLayer:setOpenedCallback(cb)
	else
		self.openedCallback = cb
	end
	return self
end

--关闭UI前回调
function BaseUI:setWillCloseCallback(cb)
	if self.dialogLayer then
		self.dialogLayer:setWillCloseCallback(cb)
	else
		self.willCloseCallback = cb
	end
	return self
end

--关闭UI后回调
function BaseUI:setClosedCallback(cb)
	if self.dialogLayer then
		self.dialogLayer:setClosedCallback(cb)
	else
		self.closedCallback = cb
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

--加载csb文件
function BaseUI:loadCsb(csb)
	local widget = self:_loadCsb(csb)
	return widget
end

-----------------------------------internal function ---------------------------------------------
-----------------------------------internal function ---------------------------------------------
-----------------------------------internal function ---------------------------------------------
-----------------------------------internal function ---------------------------------------------
-----------------------------------internal function ---------------------------------------------
-----------------------------------internal function ---------------------------------------------
-----------------------------------internal function ---------------------------------------------
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
end

--加载实例
function BaseUI:_bindModel()
	local model = self._uidef.model
	if model == nil or model == "" then
		return
	end
	self.Model = require(self._uidef.model).new()
end

--加载csb文件
function BaseUI:_loadCsb(csb)
	local csb = csb or self._uidef.csb
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

	return widget
end

--销毁实例
function BaseUI:_destoryModel()
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
	self:_destoryModel()
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