--code by zpc 2019/07/19
--[[
	yesno/ok样式弹窗
]]--

local CommonUIPopup = class("CommonUIPopup", BaseUI)

--显示样式
CommonUIPopup.ShowStyle = {
	YesNo = 1,
	Ok    = 2}

--初始化
function CommonUIPopup:init()
	--点击空白区就关闭
	self._tapBlankClose = true	

	--样式	
	self._style = self.ShowStyle.YesNo

	--标题
	self._title = ""

	--内容
	self._content = ""

	self:initUI()
	self:initData()
end

--初始化UI及点击事件
function CommonUIPopup:initUI()
	local widget = self.widget:getChildByName("widget")
	widget:setTouchEnabled(true)
	widget:setSwallowTouches(true)
	widget:addClickEventListener(function()
			if self._tapBlankClose then
				self:close()
			end
		end)

	self.btn_ok = widget:getChildByName("btn_ok")
	self.btn_ok:addClickEventListener(function()
			if self.okCallback then
				self.okCallback()
				self.okCallback = nil
			end
		end)
	self.btn_no = widget:getChildByName("btn_no")
	self.btn_no:addClickEventListener(function()
			if self.noCallback then
				self.noCallback()
				self.noCallback = nil
			end
		end)
	self.btn_yes = widget:getChildByName("btn_yes")
	self.btn_yes:addClickEventListener(function()
			if self.yesCallback then
				self.yesCallback()
				self.yesCallback = nil
			end
		end)
	
	self.txt_title = widget:getChildByName("txt_title")
	self.text_msg = widget:getChildByName("text_msg")

	self.btn_close = widget:getChildByName("btn_close")
	self.btn_close:addClickEventListener(handler(self, self.close))
end

--初始化数据
function CommonUIPopup:initData()
	self.text_msg:setString(self._content)
	if self._style == self.ShowStyle.YesNo then
		self:showYesNoPopup()
	elseif self._style == self.ShowStyle.Ok then
		self:showOkPopup()
	end
end

--显示yes/no弹窗样式
function CommonUIPopup:showYesNoPopup()
	self._style = self.ShowStyle.YesNo
	self.btn_ok:setVisible(false)
	self.btn_no:setVisible(true)
	self.btn_yes:setVisible(true)
	self.btn_close:setVisible(false)
end

--显示ok弹窗样式
function CommonUIPopup:showOkPopup()
	self._style = self.ShowStyle.Ok
	self.btn_no:setVisible(false)
	self.btn_yes:setVisible(false)
	self.btn_ok:setVisible(true)
end

--设置标题
function CommonUIPopup:setTitle(title)
	self._title = title or ""
	self.txt_title:setString(title)
end

--设置文字内容
function CommonUIPopup:setContents(content)
	self._content = content or ""
	self.text_msg:setString(content)
end

--注册yes按钮点击回调
function CommonUIPopup:setYesCallback(callback)
	self.yesCallback = callback
end

--注册no按钮点击回调
function CommonUIPopup:setNoCallback(callback)
	self.noCallback = callback
end

--注册ok按钮点击回调
function CommonUIPopup:setOkCallback(callback)
	self.okCallback = callback
end

--设置是否显示关闭按钮
function CommonUIPopup:setCloseBtnEnabled(enabled)
	self.btn_close:setVisible(enabled)
end

--设置是否点击空白区域关闭弹窗
function CommonUIPopup:setTapBlankClose(boolean)
	if boolean == nil then
		boolean = true
	end
	self._tapBlankClose = boolean
end

return CommonUIPopup