local CommonUINotice = class("CommonUINotice",cc.Layer)
local speed = 1

function CommonUINotice:ctor()
    self:enableNodeEvents(true)
    self:setCascadeOpacityEnabled(true)

    self.backImg = ccui.Scale9Sprite:create("update/notice_bg.png")
    self.backImg:setAnchorPoint(cc.p(0.5,0.5))
    self.backImg:setPosition(cc.p(display.cx, display.cy+(display.top-display.cy)/3))
    self.backImg:setOpacity(0)
    self:addChild(self.backImg, 0)
end



function CommonUINotice:addNotice(string, txtColor, font)
    self:reset()
    
    self.noticeText = CommonHelper:createBMFontLabel(string,nil,nil,display.width-40)
    self.noticeText._saveScale = self.noticeText:getScaleX()
    self.noticeText:setOpacity(255)
    self.noticeText:align(display.CENTER, display.cx, display.cy+(display.top-display.cy)/3)
    -- self.noticeText:enableOutline(cc.c3b(0, 0, 0), 0.5)
    self:addChild(self.noticeText, 10)
    -- reset
    --缓动效果，第一波时间必须相同
    local _lineNum = self.noticeText:getStringNumLines()
    if _lineNum > 1 then
        self.backImg:setContentSize(cc.size(self.backImg:getContentSize().width,42*_lineNum))
    end
    self.backImg:runAction(cc.ScaleTo:create(0.1*speed, self.noticeText._saveScale))
    self.backImg:runAction(cc.FadeIn:create(0.1*speed))
    self.noticeText:runAction(cc.ScaleTo:create(0.1*speed, self.noticeText._saveScale))
    self.noticeText:runAction(cc.FadeIn:create(0.1*speed))
    local actions1 = cc.Sequence:create(
        cc.MoveBy:create(0.1*speed, cc.p(0, 30)),
        --缓慢上升
        cc.MoveBy:create(0.4*speed, cc.p(0, 5)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 4)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 3)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 2)),
        cc.MoveBy:create(0.3*speed, cc.p(0, 1)),
        cc.FadeOut:create(1.5*speed),
        cc.CallFunc:create(handler(self, self.reset)))
    local actions2 = cc.Sequence:create(
        cc.MoveBy:create(0.1*speed, cc.p(0, 30)),
        --缓慢上升
        cc.MoveBy:create(0.4*speed, cc.p(0, 5)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 4)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 3)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 2)),
        cc.MoveBy:create(0.3*speed, cc.p(0, 1)),
        cc.FadeOut:create(1.5*speed),
        cc.CallFunc:create(handler(self, self.reset)))
    self.backImg:runAction(actions1)
    self.noticeText:runAction(actions2)
end

--物品的缩放
local itemScale = 0.6

function CommonUINotice:addNoticeWithItem(itemId, itemNum)
    self:reset()
    local str = CommonHelper:convertToCurrentLanguage(32009)
    local itemName = CommonHelper:convertToCurrentLanguage(GameDataConfig.Item.getData(itemId).NameLang)
    str = string.format( str, itemName, CommonHelper:formatNumber(itemNum, globalConfig.NumberFormat.FORMAT_NUMBER_FOUR))

    self.noticeText = CommonHelper:createBMFontLabel(CommonHelper:convertToCurrentLanguage(32010), cc.TEXT_ALIGNMENT_LEFT)
    self.noticeText._saveScale = self.noticeText:getScaleX()
    self.noticeText:setAnchorPoint(cc.p(1, 0.5))
    self.noticeText2 = CommonHelper:createBMFontLabel("x "..CommonHelper:formatNumber(itemNum, globalConfig.NumberFormat.FORMAT_NUMBER_FOUR))
    self.noticeText2:setOpacity(255)
    self.item = require('app.GameUILogic.IconLogic.EquipmentIcon'):create(itemId, itemNum)
        :setScale(itemScale)
	    :setAnchorPoint(cc.p(0.5, 0.5))
    self.item:setOpacity(255)
    self.item:hideNum()
    local itemWidth = self.item:getContentSize().width
    self.noticeText:setPosition(cc.p(display.cx - itemWidth/2 - 40, display.cy+(display.top-display.cy)/3))
    self.item:setPosition(cc.p(display.cx - itemWidth/2 , display.cy+(display.top-display.cy)/3))
    self.noticeText2:setPosition(cc.p(display.cx + itemWidth/2 - 10, display.cy+(display.top-display.cy)/3))
    self:addChild(self.noticeText, 10)
    self:addChild(self.noticeText2, 10)
    self:addChild(self.item, 10)
    -- reset
    --缓动效果，第一波时间必须相同
    self.backImg:runAction(cc.ScaleTo:create(0.1*speed, self.noticeText._saveScale))
    self.backImg:runAction(cc.FadeIn:create(0.1*speed))
    self.noticeText:runAction(cc.ScaleTo:create(0.1*speed, self.noticeText._saveScale))
    self.noticeText:runAction(cc.FadeIn:create(0.1*speed))
    self.noticeText2:runAction(cc.ScaleTo:create(0.1*speed, self.noticeText._saveScale))
    self.noticeText2:runAction(cc.FadeIn:create(0.1*speed))
    self.item:runAction(cc.ScaleTo:create(0.1*speed, itemScale))
    self.item:runAction(cc.FadeIn:create(0.1*speed))
    local actions1 = cc.Sequence:create(
        cc.MoveBy:create(0.1*speed, cc.p(0, 30)),
        --缓慢上升
        cc.MoveBy:create(0.4*speed, cc.p(0, 5)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 4)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 3)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 2)),
        cc.MoveBy:create(0.3*speed, cc.p(0, 1)),
        cc.FadeOut:create(1.5*speed),
        cc.CallFunc:create(handler(self, self.reset)))
    local actions2 = cc.Sequence:create(
        cc.MoveBy:create(0.1*speed, cc.p(0, 30)),
        --缓慢上升
        cc.MoveBy:create(0.4*speed, cc.p(0, 5)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 4)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 3)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 2)),
        cc.MoveBy:create(0.3*speed, cc.p(0, 1)),
        cc.FadeOut:create(1.5*speed))
    local actions3 = cc.Sequence:create(
        cc.MoveBy:create(0.1*speed, cc.p(0, 30)),
        --缓慢上升
        cc.MoveBy:create(0.4*speed, cc.p(0, 5)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 4)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 3)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 2)),
        cc.MoveBy:create(0.3*speed, cc.p(0, 1)),
        cc.FadeOut:create(1.5*speed))
    local actions4 = cc.Sequence:create(
        cc.MoveBy:create(0.1*speed, cc.p(0, 30)),
        --缓慢上升
        cc.MoveBy:create(0.4*speed, cc.p(0, 5)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 4)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 3)),
        cc.MoveBy:create(0.4*speed, cc.p(0, 2)),
        cc.MoveBy:create(0.3*speed, cc.p(0, 1)),
        cc.FadeOut:create(1.5*speed))
    self.backImg:runAction(actions1)
    self.noticeText:runAction(actions2)
    self.noticeText2:runAction(actions3)
    self.item:runAction(actions4)
    
	musicManager:playEffect("ZJ_AN_LQZY")
end

function CommonUINotice:addNoticeByLangId(id)
    self:addNotice((CommonHelper:ConvertLanguageToText(id)))
end

function CommonUINotice:reset()
    self.backImg:stopAllActions()
    self.backImg:setOpacity(0)
    self.backImg:setScale(0.9)
    self.backImg:setPosition(cc.p(display.cx, display.cy+(display.top-display.cy)/3))
    if self.noticeText then
        self.noticeText:removeSelf()
        self.noticeText = nil
    end
    if self.noticeText2 then
        self.noticeText2:removeSelf()
        self.noticeText2 = nil
    end
    if self.item ~= nil then
        self.item:removeSelf()
        self.item = nil
    end
end

-- function CommonUINotice:onEnter()
--     self:reset()
-- end

function CommonUINotice:onExit()
    self:reset()
end

return CommonUINotice