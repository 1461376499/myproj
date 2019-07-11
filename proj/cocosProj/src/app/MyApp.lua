
local MyApp = class("MyApp", cc.load("mvc").AppBase)

function MyApp:onCreate()
    math.randomseed(os.time())
end


function MyApp:run()	
	self:gotoScene("GameSceneLogin")
end

function MyApp:gotoScene(sceneName, params)
	
	self:enterScene(sceneName, params, "fade", 0.6, display.COLOR_WHITE)
end

return MyApp
