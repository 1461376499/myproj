--code by ZPC 2019/07/17

local GameConfigHelper = {

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
	}
}


return GameConfigHelper
