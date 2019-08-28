--code by ZPC,2017/07/16

--[[
		内部消息定义
  ]]--

local GameEventConfig = GameEventConfig or {}

--[[  
	英雄信息
	升级
  ]]--
GameEventConfig["HEROINFO"] = {
	["KEY"] 	= "kEventDef.HeroInfo",
	["LVUP"]	= "kEventDef.HeroInfo.LvUp",
	["TIERUP"]	= "kEventDef.HeroInfo.TierUp",
	["EQUIP"]	= "kEventDef.HeroInfo.Equip",
	["ACTIVE"]	= "kEventDef.HeroInfo.Active",
	["AWAKE"]	= "kEventDef.HeroInfo.Awake",
}

--宠物信息
GameEventConfig["PETINFO"] = {
	["KEY"] 	= "kEventDef.PetInfo",
	["LVUP"]	= "kEventDef.PetInfo.LvUp",
	["TIERUP"]	= "kEventDef.PetInfo.TierUp",
	["EQUIP"]	= "kEventDef.PetInfo.Equip",
	["ACTIVE"]	= "kEventDef.PetInfo.Active",
	["AWAKE"]	= "kEventDef.PetInfo.Awake",
}




return GameEventConfig