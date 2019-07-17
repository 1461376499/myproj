--code by ZPC 2019/07/15

local CommonUIDialog = require("app.CommonUtils.CommonUIDialog")

local BaseUI = class("BaseUI", cc.Layer)

BaseUI.CSB_BINDING = ""				--CSB文件路径		[[请重写]]
BaseUI.IMPLENT_BINDING = 0			--数据层实例		[[请重写]]

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

	self.scene = SceneHelper:getRunningScene()
end

function BaseUI:onEnterTransitionFinish()
	if self.openCb then	--由于UI是弹窗的子节点,比弹窗后创建，所以这里在UI打开后才调用openCb,不调用父节点弹窗的openCb
		self.openCb()
	end
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
end

--注册自定义事件
--@param1:子事件名
--@param2:监听函数
function BaseUI:addCustomEvent(sub, callFunc)
	if self.Implent == nil then
		return;
	end
	local key = self.Implent.VIEW_EVENT_BINDING[sub]
	self.EventArray[key] = callFunc
end

--关闭界面(如果是弹窗类型的界面,关闭对应的弹窗)
function BaseUI:close()
	if self.dialogLayer then
		self.dialogLayer:close()
	else
		self:runAction(cc.RemoveSelf:create())
		if self.closeCb then
			self.closeCb()
			self.closeCb = nil
		end
	end
end

--打开UI回调
function BaseUI:setOpenCallback(cb)
	if self.dialogLayer then
		self.dialogLayer:setOpenCallback(cb)
	else
		self.openCb = cb
	end
	return self
end

--关闭UI回调
function BaseUI:setClosedCallback(cb)
	if self.dialogLayer then
		self.dialogLayer:setClosedCallback(cb)
	else
		self.closeCb = cb
	end
	return self
end

--添加到节点
function BaseUI:addToNode(toNode, zOrder, tag)
	local dialog = CommonUIDialog.new(self)
	dialog:addToNode(toNode, zOrder)
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
	if self.IMPLENT_BINDING == 0 then
		return
	end
	self.Implent = require("app.GameMainUI.UIImplentLogic.".. self.IMPLENT_BINDING).new()
end


--加载csb文件
function BaseUI:_loadCsb()
	if self.CSB_BINDING == "" then
		return;
	end
	local fullPath = ccFileUtils:fullPathForFilename("main.lua")
	print("加载CSB",fullPath)
	local widget = CommonHelper:loadWidget(self.CSB_BINDING)
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
		local callFunc = self.EventArray[sub]
		if callFunc then
			callFunc(data)
		end
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.customEventListener, self)
end


return BaseUI