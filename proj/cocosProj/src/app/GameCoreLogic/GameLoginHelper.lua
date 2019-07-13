
local GameLoginHelper = class("GameLoginHelper")

local proloadingList = {
	function()
		print("proloadingList", json.encode({[11] = "data"}))
		--json.encode_sparse_array(true)		//这是cjson里的极度稀疏数组,cjson.encode({[11] = "data"})，将输出:{"1000":"data"},  json.encode({[11] = "data"})，将输出:[null,null,null,null,null,null,null,null,null,null,"data"]

	end,
	function()
		
	end,
	function()
		
	end,
}

function GameLoginHelper:ctor()
	
end

function GameLoginHelper:preLoading(cb)
	self.loadFinishCallBack = cb
	--卸载通用
	self:unloadCommon()

	--异步加载通用
	self:loadAsynCommon()
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
				ccScheduler:unscheduleScriptEntry(self.loadScheduler)
				self.loadScheduler = nil
			end
			if self.loadFinishCallBack then
				self.loadFinishCallBack()
			end
		end
		index = index + 1
	end
	self.loadScheduler = ccScheduler:scheduleScriptFunc(load_schedule_func, 2/60, false)
end

return GameLoginHelper