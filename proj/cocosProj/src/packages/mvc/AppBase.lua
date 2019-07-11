
local AppBase = class("AppBase")

AppBase.APP_ENTER_BACKGROUND_EVENT = "APP_ENTER_BACKGROUND_EVENT"
AppBase.APP_ENTER_FOREGROUND_EVENT = "APP_ENTER_FOREGROUND_EVENT"

function AppBase:ctor(configs)
	self.defaultSceneRoot = "GameSceneStart"
	self.sceneRoot = "app.GameMainScene."

    if CC_SHOW_FPS then
        cc.Director:getInstance():setDisplayStats(true)
    end

	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    local customListenerBg = cc.EventListenerCustom:create(AppBase.APP_ENTER_BACKGROUND_EVENT,
                                handler(self, self.onEnterBackground))
    eventDispatcher:addEventListenerWithFixedPriority(customListenerBg, 1)
    local customListenerFg = cc.EventListenerCustom:create(AppBase.APP_ENTER_FOREGROUND_EVENT,
                                handler(self, self.onEnterForeground))
    eventDispatcher:addEventListenerWithFixedPriority(customListenerFg, 1)

    -- event
    self:onCreate()
end


function AppBase:onEnterBackground()

end
function AppBase:onEnterForeground()

end

function AppBase:enterScene(initSceneName,args,transitionType, time, more)
	self.lastSceneName = self.currSceneName

    initSceneName = initSceneName or self.defaultSceneRoot
	local abslutePath = self.sceneRoot..initSceneName
	local sceneClass = require(abslutePath)
    local scene = sceneClass.new(unpack(checktable(args)))

	display.runScene(scene, transitionType, time, more)
	self.lastSceneName = initSceneName
end

function AppBase:run(sceneName, transition, time, more)
  
	
end


function AppBase:onCreate()
end

return AppBase
