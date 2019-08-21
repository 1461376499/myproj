
local MyApp = class("MyApp", cc.load("mvc").AppBase)

MyApp.APP_ENTER_BACKGROUND_EVENT = "APP_ENTER_BACKGROUND_EVENT"
MyApp.APP_ENTER_FOREGROUND_EVENT = "APP_ENTER_FOREGROUND_EVENT"

function MyApp:onCreate()
    math.randomseed(os.time())


	self.defaultSceneRoot = "GameSceneStart"
	self.sceneRoot = "app.views.scene."

	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    local customListenerBg = cc.EventListenerCustom:create(MyApp.APP_ENTER_BACKGROUND_EVENT,
                                handler(self, self.onEnterBackground))
    eventDispatcher:addEventListenerWithFixedPriority(customListenerBg, 1)
    local customListenerFg = cc.EventListenerCustom:create(MyApp.APP_ENTER_FOREGROUND_EVENT,
                                handler(self, self.onEnterForeground))
    eventDispatcher:addEventListenerWithFixedPriority(customListenerFg, 1)
end

function MyApp:run()	
	self:gotoScene("GameSceneLogin")
end

function MyApp:gotoScene(sceneName, params)	
	self:enterUIScene(sceneName, params, "fade", 0.6, display.COLOR_WHITE)
end

function MyApp:enterUIScene(initSceneName,args,transitionType, time, more)
    initSceneName = initSceneName or self.defaultSceneRoot
	local abslutePath = self.sceneRoot..initSceneName
	local sceneClass = require(abslutePath)
    local scene = sceneClass.new(unpack(checktable(args)))
	display.runScene(scene, transitionType, time, more)
end

function MyApp:pushScene(sceneName, params)	
	self:pushUIScene(sceneName, params, "fade", 0.6, display.COLOR_WHITE)
end

function MyApp:pushUIScene(sceneName,args,transitionType, time, more)
    sceneName = sceneName or self.defaultSceneRoot
	local abslutePath = self.sceneRoot..sceneName
	local sceneClass = require(abslutePath)
    local scene = sceneClass.new(unpack(checktable(args)))
	ccDirector:pushScene(scene)
end

function MyApp:popScene(sceneName, params)	
	self:popUIScene()
end

function MyApp:popUIScene()
	ccDirector:popScene()
end


function MyApp:onEnterBackground()

end
function MyApp:onEnterForeground()

end


return MyApp
