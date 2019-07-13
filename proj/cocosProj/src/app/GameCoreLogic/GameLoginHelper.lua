
local GameLoginHelper = class("GameLoginHelper")

local Plist = ".plist"
local Png = ".png"

local proloadingList = {
	function()
		--json.encode_sparse_array(true)		//这是cjson里的极度稀疏数组,cjson.encode({[11] = "data"})，将输出:{"1000":"data"},  json.encode({[11] = "data"})，将输出:[null,null,null,null,null,null,null,null,null,null,"data"]
	end,
	function()
		UIUtils = require("app.CommonUtils.CommonUIUtils").new()
		UIDialog = require("app.CommonUtils.CommonUIDialog").new()
	end,
	function()
		PopWindowHelper = require("app.GameCoreLogic.GamePopWindowHelper").new()
		MusicHelper = require("app.GameCoreLogic.GameMusicHelper").new()
	end,
	function()
		UICacheHelper = require("app.GameCoreLogic.GameUICacheHelper").new()
		SceneHelper = require("app.GameCoreLogic.GameSceneHelper").new()
	end,
}

--需要加载的plist列表
local resPlist = {
    
}

--需要加载的其他图片列表
local otherFrames = {
    
}

--必要的热更新图片列表
local updateFrames = {
    
}

function GameLoginHelper:ctor()
	self._hotUpdated = true


end


--第三方登录
function GameLoginHelper:start3rdLogin()
	
end
--检查热更新
function GameLoginHelper:chechUpdate()


end

function GameLoginHelper:preLoading(cb)
	self.loadFinishCallBack = cb
	--卸载通用
	self:unloadCommon()

	--异步加载通用
	self:loadAsynCommon()
	release_print("异步加载通用")
end

function GameLoginHelper:unloadCommon()	
	for k,v in pairs( package.loaded) do
		local match1 = string.find(k,"app.")
		local match2 = string.find(k,"framework.")
		if match1 or match2 then
			package.loaded[k] = nil
		end
	end

	require("cocos.framework.init")
end


function GameLoginHelper:loadAsynCommon()
	local index = 1
	local function load_schedule_func()
		local listFunc = proloadingList[index]
		if listFunc then
			listFunc()
		else
			if self.loadScheduler then
				ccDirector:getScheduler():unscheduleScriptEntry(self.loadScheduler)
				self.loadScheduler = nil
			end
			if self.loadFinishCallBack then
				self.loadFinishCallBack()
			end
		end
		index = index + 1
	end
	self.loadScheduler = ccDirector:getScheduler():scheduleScriptFunc(load_schedule_func, 2/60, false)
end


--加载资源文件
function GameLoginHelper:loadRes()
	self:unloadResOld()

	self:loadResNew()
end


--卸载旧资源
function GameLoginHelper:unloadResOld()
	if self._hotUpdated then
		--删除缓存路径
		ccFileUtils:purgeCacheEntries()	

		--删除所有 cocos2d 缓存数据
		ccDirector:purgeCachedData()

		--清理所有弹窗
		PopWindHelper:clear()

		--移除缓存ui
		UICacheHelper:clear()	

		--todo清理战斗对象池

		--移除所有加载的非plist图片
		self:removeOtherFrames()

		--移除热更新图片
		self:removeUpdateFrames()

		--删除已经加载的plist
		for k, v in pairs(resPlist) do
			display.removeSpriteFrames(v .. Plist, v .. Png)
		end		
	end
end

--移除其他已经加载过的非plist图片
function GameLoginHelper:removeOtherFrames()
	for k, frame in pairs(otherFrames) do
		display.removeSpriteFrame(frame..Png)
	end
end


--移除热更新图片
function GameLoginHelper:removeUpdateFrames()
	for k, frame in pairs(updateFrames) do
		display.removeSpriteFrame(frame..Png)
	end
end

--加载新资源
function GameLoginHelper:loadResNew()
	
	--加载plist文件
	local index = 1
	local function loadPlist_ScheduleFunc()
		local file = self.resPlist[index]
		if file then
			display.loadSpriteFrames(file..Plist, file..Png)
			index = index + 1
		elseif self.loadPlist_timer then
			ccDirector:getScheduler():unscheduleScriptEntry(self.loadPlist_timer)
			self.loadPlist_timer = nil
		end
	end	
	self.loadPlist_timer = ccDirector:getScheduler():scheduleScriptFunc(loadPlist_ScheduleFunc, 2 / 60, false)
end


return GameLoginHelper