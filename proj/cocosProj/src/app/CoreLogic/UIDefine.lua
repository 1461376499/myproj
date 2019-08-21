local UIDefine = {}

--登录界面
UIDefine.UILoginLayer = {script = "app.views.ui.UILoginLayer", csb = "layer/login/login_register_mail.csb", implent = "app.model.LoginLayerModel"}

--注册界面
UIDefine.UIRegister = {script = "app.views.ui.UIRegister", csb =  "layer/bangzhu.csb"}

--yes no ok弹窗
UIDefine.CommonUIPopup = {script = "app.utils.CommonUIPopup",csb =  "layer/general/confirmpop_layer.csb"}

return UIDefine