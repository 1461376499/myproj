--��������


local GameSceneHelper = class("GameSceneHelper")

function GameSceneHelper:ctor()


end

--�򿪳���
function GameSceneHelper:openScene(sceneName, params)
	__App:gotoScene(sceneName,params)
end

--�򿪳���
function GameSceneHelper:gotoScene(sceneName, params)
	__App:gotoScene(sceneName,params)
end

--��ջ��ѹ��һ������
function GameSceneHelper:pushScene(sceneName, params)
	self.lastScene = self.runningScene
	__App:pushScene(sceneName,params)
end

--ɾ��ջ������
function GameSceneHelper:popScene()
	__App:popScene()
end

--����runnning����
function GameSceneHelper:setRunningScene(scene)
	self.runningScene = scene
end

--��ȡrunnning����
function GameSceneHelper:getRunningScene()
	return self.runningScene
end


return GameSceneHelper