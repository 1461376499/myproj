
--[[弹窗]]
local CommonUIDialog = class("CommonUIDialog", cc.Layer)

--@prama1:要添加的UI
--@prama2:是否点击空白区关闭当前UI
function CommonUIDialog:ctor(ui, blankClose)
	self.name = self.__cname.."_"..ui.name
	self:setName(self.name)
	self.scene = SceneManager:getRunningScene()  --每一个弹窗绑定场景，以便场景退出清理弹窗	

	self.blankClose = blankClose or true
	self.uiNode = ui

	self:initUI()
end

function CommonUIDialog:initUI()
	--底层响应关闭弹窗--屏蔽下层点击事件
	local winSize = ccDirector:getWinSize()
	self.ShieldLayer = ccui.Layout:create()
		:addTo(self,10)
		:setContentSize(winSize)
		:setIgnoreAnchorPointForPosition(false)
		:setAnchorPoint(ccAchorPointCenter)
		:setPosition(winSize.width * 0.5, winSize.height * 0.5)
		:setTouchEnabled(true)
		:setSwallowTouches(true)
		:addClickEventListener(function()
			if self.blankClose then			
				self:close()
			end
		end)

	--下方遮罩 
	self.bottomLayer = ccui.Layout:create()
	self.bottomLayer:setContentSize(winSize)
	self.bottomLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.bottomLayer:setBackGroundColor(cc.c3b(0,0,0))
	self.bottomLayer:setIgnoreAnchorPointForPosition(false)
	self.bottomLayer:setAnchorPoint(cc.p(0.5,0.5))
	self.bottomLayer:setPosition(cc.p(winSize.width/2, winSize.height/2))
	self.bottomLayer:setOpacity(0)
    self:addChild(self.bottomLayer, 50)
	
	self.uiNode:addTo(self, 20)
		:setIgnoreAnchorPointForPosition(false)
		:setAnchorPoint(ccAchorPointCenter)
		:setTag(GlobalConfig.Layer_Tag.DialogContent)
		:setCascadeOpacityEnabled(true)
		:setPosition(ccp(winSize.width * 0.5, winSize.height * 0.5))

	self.uiNode.originScale = self.uiNode:getScale()
	self.uiNode.originPos   = ccp(self.uiNode:getPositionX(),  self.uiNode:getPositionY())
	self.uiNode.originRotate= self.uiNode:getRotation()

	--屏蔽上层点击事件
	self.topSheildLayer = ccui.Layout:create()
	self.topSheildLayer:setContentSize(winSize)
	self.topSheildLayer:setIgnoreAnchorPointForPosition(false)
	self.topSheildLayer:setAnchorPoint(cc.p(0.5,0.5))
	self.topSheildLayer:setPosition(cc.p(winSize.width/2,winSize.height/2))
	self.topSheildLayer:setTouchEnabled(true)
    self:addChild(self.topSheildLayer, 200)

	self.uiNode._isDialog = true
end

function CommonUIDialog:onEnterTransitionFinish()
	
end

function CommonUIDialog:fadeIn()
	self:setVisible(true)
end

--显示当前UI
function CommonUIDialog:show(showType)
	self.showType = showType or GlobalConfig.DialogOpenType.ScaleTo

	self.uiNode:setVisible(false)
	self:setVisible(true)

	PopWindowManager:add(self)
	
	self:doShowAnimation(showType)
end

--缓冲渐变效果
function CommonUIDialog:doShowAnimation(showType)
	if self.willOpenCallback then
		self.willOpenCallback()
	end

	self:setVisible(true)
	local function cb()
		self.topSheildLayer:setVisible(false)
		if self.openedCallback and self.uiNode._isDialog then
			self.openedCallback()
		end
	end
	local originScale = self.uiNode.originScale
	self.uiNode:stopAllActions()
	self.uiNode:setScale(originScale * 0.8)
	self.uiNode:setOpacity(0)
	self.uiNode:runAction(cc.FadeIn:create(0.3))
	self.uiNode:runAction(cc.Sequence:create(
		cc.Show:create(),
		cc.EaseBackInOut:create(cc.ScaleTo:create(0.3, originScale)),
		cc.CallFunc:create(cb)
	))

end

--缓冲渐变效果
function CommonUIDialog:doCloseAnimation(showType)

	--即将关闭回调
	if self.willCloseCallback then
		self.willCloseCallback()
	end
	
	--关闭后的回调
	local function closedCallback()		
		if self.closedCallback then
			self.closedCallback()
			self.closedCallback = nil
		end
		PopWindowManager:remove()
		self:runAction(cc.RemoveSelf:create())
	end

	local originScale = self.uiNode.originScale
	self.uiNode:stopAllActions()
	self.uiNode:runAction(cc.Sequence:create(
			cc.Spawn:create(
				cc.FadeOut:create(0.2),
				cc.EaseBackIn:create(cc.ScaleTo:create(0.2, 0.85))
				),
			cc.Hide:create(),
			cc.CallFunc:create(closedCallback)
		))
end

function CommonUIDialog:doCloseHide()
    self:runAction(cc.Sequence:create(
        cc.DelayTime:create(0.4),
        cc.Hide:create(),
        cc.RemoveSelf:create()
    ))
end

--隐藏遮罩
function CommonUIDialog:hideMask(__direct)
	self.uiNode:stopAllActions()
	if __direct then
		self.bottomLayer:setOpacity(0)
	else
		self.bottomLayer:runAction(cc.FadeTo:create(0.3, 0))
	end
end

--添加到节点
function CommonUIDialog:addToNode(toNode)
	toNode = toNode or SceneManager:getRunningScene()
	local winSize = ccDirector:getWinSize()
	self:setIgnoreAnchorPointForPosition(false)
	self:setAnchorPoint(ccAchorPointCenter)
	self:addTo(toNode, GlobalConfig.ZOrderControl.Dialog)
	self:setPosition(ccp(winSize.width * 0.5, winSize.height * 0.5))
end

--打开弹窗前回调
function CommonUIDialog:setWillOpenCallback(cb)
	self.willOpenCallback = cb
end

--打开弹窗后回调
function CommonUIDialog:setOpenedCallback(cb)
	self.openedCallback = cb
end

--关闭弹窗后回调
function CommonUIDialog:setClosedCallback(cb)
	self.closedCallback = cb
end
--关闭弹窗前回调
function CommonUIDialog:setWillCloseCallback(cb)
	self.willCloseCallback = cb
end

--点击空白区域关闭弹窗回调
function CommonUIDialog:setClickBlankClose(isBlankClose)
	self.blankClose = isBlankClose
end

--关闭弹窗
function CommonUIDialog:close(cb)
	
--	self:doCloseHide()
	self.topSheildLayer:setVisible(true)
	self:doCloseAnimation(self.showType)
end

return CommonUIDialog