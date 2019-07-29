
local BaseScene = class("BaseScene", cc.Scene)
BaseScene.SceneName = ""

function BaseScene:ctor()
	self:enableNodeEvents()	

	--����runningScene��director:runningScene���л���ʱ�򲻼�ʱ
	SceneHelper:setRunningScene(self)
	
end

--
function BaseScene:onEnter()
	--����push/pop��ʱ����ظ�����onEnter,��ʱ����runningScene
	self:enableNodeEvents()	
	SceneHelper:setRunningScene(self)
end


--[[ͨ������£���Ҫ��������������node�߼�, ��Ϊ�����л������ظ����]]
function BaseScene:onEnterTransitionFinish()

end

--
function BaseScene:onExit()
	PopWindowHelper:cleanup(self)	
	self:disableNodeEvents()
end


--[[�Զ��������������ͽڵ������ ͨ�������Ҫ��д�������]]
function BaseScene:onCleanup()
	
end



return BaseScene