--code by ZPC 2019/07/17

local GameGlobalConfig = {

	--场景层级
	ZOrderControl = {
		Default		= 0,		--默认层级
		TopUI		= 50,		--顶部UI层级
		Fight		= 100,		--战斗层级
		BottomUI	= 150,		--底部UI层级
		Dialog		= 200,		--弹窗层级
		Tips		= 250,		--提示、飘浮文字层级
		Guide		= 300,		--引导层级
		System		= 350,		--系统层级
	},

	--图层标识
	Layer_Tag = {
		DialogContent = 1000
	},

	--弹窗打开弹出动画类型
	DialogOpenType = {
		Direct = 0,
		ScaleTo = 1,
		ScaleEase = 2
	},
	
	--数字样式
	NumberFormat = {
		-- 默认
		FORMAT_NORMAL      = 0,
		-- 百分比
		FORMAT_PERCENTAGE  = 1,
		-- 4位数
		FORMAT_NUMBER_FOUR = 2,
		-- 5位数
		FORMAT_NUMBER_FIVE = 3,
		-- 6位数
		FORMAT_NUMBER_SIX  = 4,
		-- 小数
		FORMAT_NUMBER_FLOAT= 5
	},

	Language = {
		
	},

	ShaderResources = {					--"vert"字段不填,读取默认值
		--默认
		Default = {key = "Default",vert = "shader/ccShader_PositionTextureColor_noMVP.vert", frag = "shader/default.frag"},
		--置灰
		Grey = {key = "GREY",vert = "shader/ui_grey.vsh", frag = "shader/ui_grey.fsh"},

		--流光
		Flow_Light = {key = "Flow_Light",vert = "", frag = ""},

		--雪花
		Ice = {key = "Flow_Light",vert = "shader/ccShader_PositionTextureColor_noMVP.vert", frag = "effect_ice.frag"},

		--冰冻
		Frozen = {key = "Frozen", vert = "", frag = "FrozenShader.fsh"}
	}
}


return GameGlobalConfig
