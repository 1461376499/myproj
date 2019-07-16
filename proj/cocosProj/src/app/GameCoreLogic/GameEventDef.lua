--code by ZPC,2017/07/16

--[[
		内部消息定义
  ]]--

local GameEventDef = GameEventDef or {}

function GameEventDef.DispathEvent(events,  sub,  data)
	local customEvent = cc.EventCustom:new(events["KEY"])
	customEvent["_userData"] = {
		sub = events[sub],
		data = data
	}
	ccDirector:getEventDispatcher():dispatchEvent(customEvent)
end

--[[  
	英雄信息
	升级
  ]]--
GameEventDef["HEROINFO"] = {
	["KEY"] 	= "kEventDef.HeroInfo",
	["LVUP"]	= "kEventDef.HeroInfo.LvUp",
	["TIERUP"]	= "kEventDef.HeroInfo.TierUp",
	["EQUIP"]	= "kEventDef.HeroInfo.Equip",
	["ACTIVE"]	= "kEventDef.HeroInfo.Active",
	["AWAKE"]	= "kEventDef.HeroInfo.Awake",
}




return GameEventDef