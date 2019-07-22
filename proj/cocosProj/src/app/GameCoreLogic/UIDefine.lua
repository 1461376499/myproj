local UIDefine = {}

--登录界面
UIDefine.UILoginLayer = {script = "app.GameUILayer.UILoginLayer", csb = "layer/login/login_register_mail.csb", implent = "app.GameUILayer.UIImplentLogic.UILoginLayerImplent"}

--注册界面
UIDefine.UIRegister = {script = "app.GameUILayer.UIRegister", csb =  "layer/bangzhu.csb"}

--yes no ok弹窗
UIDefine.CommonUIPopup = {script = "app.CommonUtils.CommonUIPopup",csb =  "layer/general/confirmpop_layer.csb"}

return UIDefine