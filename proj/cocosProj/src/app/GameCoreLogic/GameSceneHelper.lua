local GameSceneHelper = class("GameSceneHelper")

function GameSceneHelper:ctor()


end

function GameSceneHelper:pushScene(sceneName, params)
	

end


function GameSceneHelper:pushScene()


end

function GameSceneHelper:setRunningScene(scene)
	self.runningScene = scene
end

function GameSceneHelper:getRunningScene()
	return self.runningScene
end


return GameSceneHelper