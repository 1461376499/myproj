--��������


local SceneManager = class("SceneManager")

function SceneManager:ctor()


end

--�򿪳���
function SceneManager:openScene(sceneName, params)
	__App:gotoScene(sceneName,params)
end

--�򿪳���
function SceneManager:gotoScene(sceneName, params)
	__App:gotoScene(sceneName,params)
end

--��ջ��ѹ��һ������
function SceneManager:pushScene(sceneName, params)
	self.lastScene = self.runningScene
	__App:pushScene(sceneName,params)
end

--ɾ��ջ������
function SceneManager:popScene()
	__App:popScene()
end

--����runnning����
function SceneManager:setRunningScene(scene)
	self.runningScene = scene
end

--��ȡrunnning����
function SceneManager:getRunningScene()
	return self.runningScene
end


return SceneManager