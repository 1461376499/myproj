local GameSceneHelper = class("GameSceneHelper")

function GameSceneHelper:ctor()


end

function GameSceneHelper:pushScene(sceneName, params)
	self.lastScene = self.runningScene
	__App:pushScene(sceneName,params)
end


function GameSceneHelper:popScene()
	__App:popScene()
end

function GameSceneHelper:setRunningScene(scene)
	self.runningScene = scene
end

function GameSceneHelper:getRunningScene()
	return self.runningScene
end


return GameSceneHelper