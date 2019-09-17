---[[弹窗自动管理]]

local PopWindowManager = class("PopWindowManager")

function PopWindowManager:ctor()
	self.popWindows = {}
end

function PopWindowManager:getPopWindows()
	return self.popWindows
end

--添加一个新的弹窗
function PopWindowManager:add(window)
	
	self:hideCurrent()
	table.insert(self.popWindows, 1, window)
	self:showTop()
end

--显示顶层弹窗
function PopWindowManager:showTop(scene)
	if #self.popWindows > 0 then
		local window = self.popWindows[1]
		window:setVisible(true)
	end
end

--隐藏当前的弹窗
function PopWindowManager:hideCurrent()
	if #self.popWindows > 0 then
		local window = self.popWindows[1]
		window:setVisible(false)
	end
end

--关闭顶层弹窗/显示顶层下方一层的弹窗
function PopWindowManager:remove()
	if #self.popWindows > 0 then
		table.remove(self.popWindows, 1)
	end
	local window = self.popWindows[1]
	if window and window.scene == SceneManager:getRunningScene() then
		--window:hideMask()
		window:setVisible(true)
	end
end

--清理所有弹窗
function PopWindowManager:cleanup(scene)
	if scene then
		for index = #self.popWindows, 1, -1 do
			local window = self.popWindows[index]
			if window.scene == scene then
				table.remove(self.popWindows, index)
			end
		end
		--检测是否还有其他场景的弹窗/处理pushscene的情况
		self:showTop()
	else
		self.popWindows = {}
	end
	
	print("弹窗数量", #self.popWindows)
end

return PopWindowManager