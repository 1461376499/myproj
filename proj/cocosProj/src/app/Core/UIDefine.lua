local UIDefine = {}

--登录界面
UIDefine.LoginLayer = {script = "app.views.ui.LoginLayer", csb = "layer/login/login_register_mail.csb", implent = "app.model.LoginModel"}

--注册界面
UIDefine.RegisterLayer = {script = "app.views.ui.RegisterLayer", csb =  "layer/bangzhu.csb"}

--yes no ok弹窗
UIDefine.CommonUIPopup = {script = "app.Core.Common.CommonUIPopup",csb =  "layer/general/confirmpop_layer.csb"}

return UIDefine