--场景管理


local GameSceneHelper = class("GameSceneHelper")

function GameSceneHelper:ctor()


end

--打开场景
function GameSceneHelper:openScene(sceneName, params)
	__App:gotoScene(sceneName,params)
end

--打开场景
function GameSceneHelper:gotoScene(sceneName, params)
	__App:gotoScene(sceneName,params)
end

--向栈中压入一个场景
function GameSceneHelper:pushScene(sceneName, params)
	self.lastScene = self.runningScene
	__App:pushScene(sceneName,params)
end

--删除栈顶场景
function GameSceneHelper:popScene()
	__App:popScene()
end

--设置runnning场景
function GameSceneHelper:setRunningScene(scene)
	self.runningScene = scene
end

--获取runnning场景
function GameSceneHelper:getRunningScene()
	return self.runningScene
end


return GameSceneHelper