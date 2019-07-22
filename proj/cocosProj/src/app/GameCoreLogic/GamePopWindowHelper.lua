---[[弹窗自动管理]]

local GamePopWindowHelper = class("GamePopWindowHelper")

function GamePopWindowHelper:ctor()
	self.popWindows = {}
end


--添加一个新的弹窗
function GamePopWindowHelper:add(window)
	
	self:hideCurWindow()
	table.insert(self.popWindows, 1, window)
	self:showTop()
end

--显示顶层弹窗
function GamePopWindowHelper:showTop()
	if #self.popWindows > 0 then
		local topWind = self.popWindows[1]
		topWind:setVisible(true)
	end
end

--隐藏当前的弹窗
function GamePopWindowHelper:hideCurWindow()
	if #self.popWindows > 0 then
		local wind = self.popWindows[1]
		wind:setVisible(false)
	end
end

--关闭顶层弹窗/显示顶层下方一层的弹窗
function GamePopWindowHelper:remove()
	if #self.popWindows > 0 then
		table.remove(self.popWindows, 1)
	end
	local wind = self.popWindows[1]
	if wind then
		wind:hideMask()
		wind:fadeIn()
	end
end

--清理所有弹窗
function GamePopWindowHelper:cleanup(sn)
	if sn then
		for index = #self.popWindows, 1, -1 do
			local window = self.popWindows[index]
			if window.scene == SceneHelper:getRunningScene() then
				table.remove(self.popWindows, index)
			end
		end
	else
		self.popWindows = {}
	end
end

return GamePopWindowHelper