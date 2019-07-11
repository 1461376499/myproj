
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    -- add background image
--    display.newSprite("HelloWorld.png")
--        :move(display.center)
--        :addTo(self)

--    -- add HelloWorld label
--    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
--        :move(display.cx, display.cy + 200)
--        :addTo(self)
	local str1 = "1231hk31h2n3kl1l23jl12n3l123l12bn3l12n3lk1j2kl3j12lk4n1lk23nlk12j3lk12j3"
	local str2 = "config.lua"

	local md5 = Fox.getFileMD5(str2)
	local md6 = Fox.getDataMD5(str1, string.len(str1))
	print(md4)
	print(md5)
	print(md6)
end

return MainScene
