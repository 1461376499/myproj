
local BaseScene = class("BaseScene", cc.Scene)
BaseScene.SceneName = ""

function BaseScene:ctor()
	self:enableNodeEvents()	

	--更新runningScene，director:runningScene在切换的时候不及时
	SceneManager:setRunningScene(self)	
end

--
function BaseScene:onEnter()
	--场景push/pop的时候会重复调用onEnter,随时更新runningScene
	self:enableNodeEvents()	
	SceneManager:setRunningScene(self)
end


--[[通常情况下，不要在这个函数里添加node逻辑, 因为场景切换可能重复添加]]
function BaseScene:onEnterTransitionFinish()

end

--
function BaseScene:onExit()
	PopWindowManager:cleanup(self)	
	self:disableNodeEvents()
end


--[[自动清理场景弹窗，和节点监听， 通常情况不要重写这个函数]]
function BaseScene:onCleanup()
	
end



return BaseScene