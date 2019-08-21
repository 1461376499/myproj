require "config"
require "cocos.init"
require "app.init"


package.path = package.path .. ";src/"


cc.FileUtils:getInstance():setPopupNotify(false)

g_NeedHotUpdate = false

if device.platform == "android" or device.platform == "ios" then
	g_NeedHotUpdate = true
	ccFileUtils:addSearchPath(ccFileUtils:getWritablePath() .. "update/", true)
	ccFileUtils:addSearchPath(ccFileUtils:getWritablePath() .. "update/res/", true)
	ccFileUtils:addSearchPath(ccFileUtils:getWritablePath() .. "update/src/", true)

elseif device.platform == "windows" then			-- windows don't soppurt hot update,temporary
	ccFileUtils:addSearchPath(ccFileUtils:getDefaultResourceRootPath() .. "res/")
	g_NeedHotUpdate = false
end

if g_NeedHotUpdate then
	function versionCompare()
		local versionUpdate = "0.0.0"
		local path = ccFileUtils:getWritablePath() .. "update/project.manifest"
		if ccFileUtils:isFileExist(path) then
			versionUpdate = jcon.decode(ccFileUtils:getStringFromFile(path)).version
		end

		local versionAssets = "0.0.0"
		path = ccFileUtils:getWritablePath() .. "res/project.manifest"
		if ccFileUtils:isFileExist(path) then
			versionAssets = jcon.decode(ccFileUtils:getStringFromFile(path)).version
		end
		
		if string.gsub(versionUpdate, ".","") >=  string.gsub(versionAssets, ".", "") then
			return false
		else
			return true
		end
		return false
	end

	if versionCompare() then
		--delete update dict
		ccFileUtils:removeDirectory(ccFileUtils:getWritablePath().."update/")
	end
end


local function main()
	require("app.views.scene.GameSceneStart"):new()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
