--场景管理


local SceneManager = class("SceneManager")

function SceneManager:ctor()


end

--打开场景
function SceneManager:openScene(sceneName, params)
	__App:gotoScene(sceneName,params)
end

--打开场景
function SceneManager:gotoScene(sceneName, params)
	__App:gotoScene(sceneName,params)
end

--向栈中压入一个场景
function SceneManager:pushScene(sceneName, params)
	self.lastScene = self.runningScene
	__App:pushScene(sceneName,params)
end

--删除栈顶场景
function SceneManager:popScene()
	__App:popScene()
end

--设置runnning场景
function SceneManager:setRunningScene(scene)
	self.runningScene = scene
end

--获取runnning场景
function SceneManager:getRunningScene()
	return self.runningScene
end


return SceneManager