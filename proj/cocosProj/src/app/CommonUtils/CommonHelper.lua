local CommonHelper = class("CommonHelper")
	
function CommonHelper:ctor()
	

end


--添加一个弹窗类型的UI
--@param1:UIDefine里定义的名字
--@param2:要传入的数据
function CommonHelper:addUIModal(uiDef, args)
	local ui = require(uiDef.script).new()
	ui:initialization(uiDef, args)
	ui:addToNode()
	ui:show()
	return ui
end

--添加一个普通UI
--@param1:UIDefine里定义的名字
function CommonHelper:addUI(uiDef, args, parent, zorder)
	local ui = require(uiDef.script).new()
	ui:initialization(uiDef, args)
	if parent then
		ui:addTo(parent)
	end
	if zorder then
		ui:setLocalZOrder(zorder)
	end
	return ui
end

--prama: csb文件路径
function CommonHelper:loadWidget(csb)
	local widget = cc.CSLoader:createNode(csb)
	widget:setPosition(display.center)
	widget:setAnchorPoint(ccAchorPointCenter)

	self:onAdaptCoord(widget)
	return widget
end

--[[
	靠边布局
]]--
function CommonHelper:onAdaptCoord(_widget)
    local panel_left = _widget:getChildByName("panel_left")
    if panel_left ~= nil then
        panel_left:setPositionX(panel_left:getPositionX()-display.cx)
    end  

    local panel_right = _widget:getChildByName("panel_right")
    if panel_right ~= nil then
        panel_right:setPositionX(panel_right:getPositionX() + display.cx)
    end  
end

--[[
	将一个数字格式的颜色转换为rgba颜色
]]--
function CommonHelper:colorConvert( color )
	local c = string.format("%d",color)

	local r = math.floor(c/256/256/256)
	local g = math.floor(c/256/256%256)
	local b = math.floor(c/256%256)
	local a = math.floor(c%256)
	
	return cc.c4b(r, g, b, a)
end

--[[
	弹出一个弹窗yes/no/ok样式
]]--
function CommonHelper:showYesNoPopup(content, yesCallback, noCallback, tapBlankClose)
	local pupop = CommonHelper:addUIModal(UIDefine.CommonUIPopup)
	pupop:showYesNoPopup()
	pupop:setContents(content)
	pupop:setYesCallback(yesCallback)
	pupop:setNoCallback(noCallback)
	pupop:setTapBlankClose(tapBlankClose or true)
	return pupop;
end

function CommonHelper:showOkPopup(title, content, okCallback, tapBlankClose, isShowCloseBtn)
	local pupop = CommonHelper:addUIModal(UIDefine.CommonUIPopup)
	pupop:showOkPopup()
	pupop:setTitle(title)
	pupop:setContents(content)
	pupop:setOkCallback(okCallback)
	pupop:setCloseBtnEnabled(isShowCloseBtn)
	pupop:setTapBlankClose(tapBlankClose)
	return pupop;
end

--转换到节点空间坐标
function CommonHelper:convertToNodePosition(this, p, that)
	local p_world = this:convertToWorldSpace(p)
	return that:convertToNodeSpace(p_world)
end

--[[
	通用数字显示格式
	@param1 : number, 要转换的数字(如果数字为百分比，传入的数字为转换为小数的真实数字。例：0.03 ---> 3%)
	@param2 : 转换格式类型，常量定义在 GameMacros 中
]]
function CommonHelper:formatNumberExtend(number, format)
    
	-- 如果不是数字，刚返回0
	if type(number) ~= "number" then
		return 0
    end
	
    local result = number
    local r2     = number
    local symbol = ""

	if Macros.NumberFormat.FORMAT_PERCENTAGE == format then

        local tmp = math.floor(number * 1000) % 10

        if tmp == 0 then
            result = string.format("%.0f", number * 100) .. "%"
        else
            result = string.format("%.1f", number * 100) .. "%"
        end
    elseif Macros.NumberFormat.FORMAT_NUMBER_FLOAT == format then
        local surplus = math.floor(number * 100)
        local symbol  = "%.2f"
        if surplus % 10 == 0 then
            if surplus % 100 == 0 then
                symbol = "%d"
            else
                symbol = "%.1f"
            end
        end
        result = string.format(symbol, number)
	else

		local FormatByte = {}
		FormatByte.data = 
		{
			{ id = Macros.NumberFormat.FORMAT_NORMAL, 	   value = 0, maxLimit = 1000000000000 },
			{ id = Macros.NumberFormat.FORMAT_NUMBER_FOUR, value = 4, maxLimit = 1000000000000 },
			{ id = Macros.NumberFormat.FORMAT_NUMBER_FIVE, value = 5, maxLimit = 10000000000000 },
			{ id = Macros.NumberFormat.FORMAT_NUMBER_SIX,  value = 6, maxLimit = 100000000000000 }
		}
		FormatByte.getByte = function(id)

			for i = 1, #FormatByte.data do
				if FormatByte.data[i].id == id then
					return FormatByte.data[i].value, FormatByte.data[i].maxLimit
				end
			end

			return nil
		end

		local byte, maxLimit = FormatByte.getByte(format)

		if byte ~= 0 then

            local length  = string.len(tostring(math.floor(number))) - byte + 1
            local surplus = 0

			if number >= maxLimit then
				symbol = "∞"
	            return symbol, number, symbol, symbol
			elseif length > 6 then
                symbol = "B"
                number = number / 1000000000
                surplus = number % 1000000000
			elseif length > 3 then
                symbol = "M"
				number = number / 1000000
                surplus = number % 1000000
			elseif length > 1 then
                symbol = "K"
				number = number / 1000
                surplus = number % 1000
			else
				symbol = ""
            end
            
            local formatStr = "%" .. byte .."d" .. symbol

            if byte == 4 and result > 9999 and number < 10 then
                formatStr = "%.1f" .. symbol
                result = string.trim(string.format(formatStr, number))
            else
                result = string.trim(string.format(formatStr, math.floor(number)))
            end

            r2 = string.trim(string.format("%" .. byte .."d" .. symbol, math.floor(number)))
		else
			result = string.trim(string.format("%d", math.floor(number)))
		end
	end
	return result, string.format("%d", number), symbol, r2
end

--参数 总秒数，返回： --:--:-- 格式的时间
function CommonHelper:formatTimeHHMMSS(second)

    local hour = math.floor(second/3600)
    local minutes = math.floor((second - hour*3600)/60)
    local sec = second - hour * 3600 - minutes * 60
    if hour < 10 then
        hour = "0"..hour
    end
    if minutes < 10 then
        minutes = "0"..minutes
    end
    if sec < 10 then
        sec = "0"..sec
    end
    return "" .. hour ..":"..minutes..":"..sec
end

--[[
	节点之间的切换
  ]]
function CommonHelper:layerChange(node, toNode, zOrder)
    if not node then 
        return
    end
	if nil == zOrder then
		zOrder = 0
	end

    local _parent = node:getParent()
    if _parent then
        local x, y = node:getParent():convertToWorldSpace(cc.p(node:getPositionX(), node:getPositionY()))
        x, y = toNode:convertToNodeSpace(cc.p(x, y))
    
        node:retain()
        node:removeFromParent(false)
        node:setPosition(cc.p(x, y))
        toNode:addChild(node, zOrder)
        node:release()
    end
end

--lua table 深度拷贝
function CommonHelper:table_deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

--@note  是否全是数字
function CommonHelper:isAllNum(sName)  
	local ret = true
    local sStr = sName  
    local nLenInByte = #sStr 
    for i=1,nLenInByte do  
        local curByte = string.byte(sStr, i)  
        local byteCount = 0
        if curByte>0 and curByte<=127 then  
            byteCount = 1  
        elseif curByte>=192 and curByte<223 then  
            byteCount = 2  
        elseif curByte>=224 and curByte<239 then  
            byteCount = 3  
        elseif curByte>=240 and curByte<=247 then  
            byteCount = 4  
        end

        if curByte>57 or curByte<48 then
        	ret = false
        end

        local char = nil  
        if byteCount > 0 then  
            char = string.sub(sStr, i, i+byteCount-1)  
            i = i + byteCount -1  
        end  
    end  
    return ret  
end

-- note 获取中英混合字符长度
function CommonHelper:getInputStrWidth(inputstr)
   local lenInByte = #inputstr
   local width = 0
   local i = 1
    while (i<=lenInByte) 
    do
        local curByte = string.byte(inputstr, i)
        local byteCount, tmpValue = 1, 1
        if curByte>0 and curByte<=127 then
            byteCount = 1                                               --1字节字符
        elseif curByte>=192 and curByte<223 then
            byteCount = 2                                               --双字节字符
            tmpValue  = 2
        elseif curByte>=224 and curByte<239 then
            byteCount = 3                                               --汉字(当前项目需求汉字用两个字节处理)
            tmpValue  = 2
        elseif curByte>=240 and curByte<=247 then
            byteCount = 4                                               --4字节字符
            tmpValue  = 2
        end
         
        local char = string.sub(inputstr, i, i + byteCount - 1)
        -- cclog(char) --看看这个字是什么
        i = i + byteCount   -- 重置下一字节的索引
        width = width + tmpValue   -- 字符的个数（长度）
    end
    return width
end


--@note     是否含有中文
function CommonHelper:isIncludeChinese(sName)  
	local ret = false
    local sStr = sName  
    local nLenInByte = #sStr 
    for i=1,nLenInByte do  
        local curByte = string.byte(sStr, i)  
        local byteCount = 0;  
        if curByte>0 and curByte<=127 then  
            byteCount = 1  
        elseif curByte>=192 and curByte<223 then  
            byteCount = 2  
        elseif curByte>=224 and curByte<239 then  
            byteCount = 3  
        elseif curByte>=240 and curByte<=247 then  
            byteCount = 4  
        end  
        local char = nil  
        if byteCount > 0 then  
            char = string.sub(sStr, i, i+byteCount-1)  
            i = i + byteCount -1  
        end  
        if byteCount > 1 then
        	ret = true  
        end  
    end  
      
    return ret  
end

--@param    sName:要转换的字符串  
--@return   nMaxCount，字符串上限,中文字为2的倍数  
--@note     每个nMaxCount个字符加入一个换行
function CommonHelper:transformStr(sName,nMaxCount)  
    if sName == nil then  
        return  
    end  
    if nMaxCount == nil then  
        nMaxCount = 18  
    end  

    local sStr = sName  
    local tCode = {}  
    local tName = {}  
    local nLenInByte = #sStr  
    local nWidth = 0  
    for i=1,nLenInByte do  
        local curByte = string.byte(sStr, i)  
        local byteCount = 0;  
        if curByte>0 and curByte<=127 then  
            byteCount = 1  
        elseif curByte>=192 and curByte<223 then  
            byteCount = 2  
        elseif curByte>=224 and curByte<239 then  
            byteCount = 3  
        elseif curByte>=240 and curByte<=247 then  
            byteCount = 4  
        end  
        local char = nil  
        if byteCount > 0 then  
            char = string.sub(sStr, i, i+byteCount-1)  
            i = i + byteCount -1  
        end  
        if byteCount == 1 then  
            nWidth = nWidth + 1  
            table.insert(tName,char)  
            table.insert(tCode,1)  
              
        elseif byteCount > 1 then  
            nWidth = nWidth + 2  
            table.insert(tName,char)  
            table.insert(tCode,2)  
        end  
    end  
      
    if nWidth > nMaxCount then  
        local _sN = ""  
        local _len = 0  
        for i=1,#tName do  
            _sN = _sN .. tName[i]  
            _len = _len + tCode[i]  
            if _len >= nMaxCount then  
            	_sN = _sN .. "\n"
            	_len = 0
            end  
        end
        sName = _sN
    end  
    return sName  
end

--@param    sName:要切割的字符串  
--@return   nMaxCount，字符串上限,中文字为2的倍数  
--@param    nShowCount：显示英文字个数，中文字为2的倍数,可为空  
--@note     函数实现：截取字符串一部分，剩余用“...”替换
function CommonHelper:getShortStr(sName,nMaxCount,nShowCount)  
    if sName == nil or nMaxCount == nil then  
        return  
    end  
    local sStr = sName  
    local tCode = {}  
    local tName = {}  
    local nLenInByte = #sStr  
    local nWidth = 0  
    if nShowCount == nil then  
       nShowCount = nMaxCount - 3  
    end  
    for i=1,nLenInByte do  
        local curByte = string.byte(sStr, i)  
        local byteCount = 0;  
        if curByte>0 and curByte<=127 then  
            byteCount = 1  
        elseif curByte>=192 and curByte<223 then  
            byteCount = 2  
        elseif curByte>=224 and curByte<239 then  
            byteCount = 3  
        elseif curByte>=240 and curByte<=247 then  
            byteCount = 4  
        end  
        local char = nil  
        if byteCount > 0 then  
            char = string.sub(sStr, i, i+byteCount-1)  
            i = i + byteCount -1  
        end  
        if byteCount == 1 then  
            nWidth = nWidth + 1  
            table.insert(tName,char)  
            table.insert(tCode,1)  
              
        elseif byteCount > 1 then  
            nWidth = nWidth + 2  
            table.insert(tName,char)  
            table.insert(tCode,2)  
        end  
    end  
      
    if nWidth > nMaxCount then  
        local _sN = ""  
        local _len = 0  
        for i=1,#tName do  
            _sN = _sN .. tName[i]  
            _len = _len + tCode[i]  
            if _len >= nShowCount then  
                break  
            end  
        end  
        sName = _sN .. "..."  
    end  
    return sName  
end

--返回当前字符实际占用的字符数
function CommonHelper:subStringGetByteCount(str, index)
    local curByte = string.byte(str, index)
    local byteCount = 1;
    if curByte == nil then
        byteCount = 0
    elseif curByte > 0 and curByte <= 127 then
        byteCount = 1
    elseif curByte>=192 and curByte<=223 then
        byteCount = 2
    elseif curByte>=224 and curByte<=239 then
        byteCount = 3
    elseif curByte>=240 and curByte<=247 then
        byteCount = 4
    end
    return byteCount;
end

function CommonHelper:subStringGetTrueIndex(str, index)
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat 
        lastCount = CommonHelper:SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(curIndex >= index);
    return i - lastCount;
end

--截取中英混合的UTF8字符串，endIndex可缺省
function CommonHelper:subStringUTF8(str, startIndex, endIndex)
    if startIndex < 0 then
        startIndex = SubStringGetTotalIndex(str) + startIndex + 1;
    end
 
    if endIndex ~= nil and endIndex < 0 then
        endIndex = SubStringGetTotalIndex(str) + endIndex + 1;
    end
 
     if endIndex == nil then 
         return string.sub(str, CommonHelper:SubStringGetTrueIndex(str, startIndex));
     else
         return string.sub(str, CommonHelper:SubStringGetTrueIndex(str, startIndex), CommonHelper:SubStringGetTrueIndex(str, endIndex + 1) - 1);
     end
end

--检测node是否存在(有父级显示对象，不计visible)
--使用该方法必须保证node 已被retain，否则在真机上会出现直接崩溃的情况
function CommonHelper:checkNodeExist(node)
    local nodeExist = false
    local fucResult = pcall(function(checkNode)
            if checkNode and checkNode.getParent ~= nil and checkNode:getParent() ~= nil then
                nodeExist = true
            end
        end, node)

    return nodeExist and fucResult
end

--将显示对象转换为sprite
function CommonHelper:getViewRenderSprite(__panel, __openAntiAlias)

    --保存渲染之前的锚点和坐标
    local _savedAnchorPoint = __panel:getAnchorPoint()
    local _savedPosition = cc.p(__panel:getPosition())
    
    --渲染前将__panel锚点和坐标清零并设置显示
    __panel:setAnchorPoint(cc.p(0, 0))
    __panel:setPosition(cc.p(0, 0))
    __panel:setVisible(true)

    --创建RenderTexture，并渲染
    local _renderTexture = cc.RenderTexture:create(__panel:getContentSize().width, __panel:getContentSize().height)
	_renderTexture:beginWithClear(0,0,0,0)
	__panel:visit()
	_renderTexture:endToLua()

    --渲染后将__panel锚点和坐标恢复并设置隐藏
    __panel:setAnchorPoint(_savedAnchorPoint)
    __panel:setPosition(_savedPosition)
    __panel:setVisible(false)

    --取_renderTexture的image的_texture
    local _image = _renderTexture:newImage()
    cc.Director:getInstance():getTextureCache():removeTextureForKey("_key_")
    local _texture =  cc.Director:getInstance():getTextureCache():addImage(_image,"_key_")
    _image:release()

    --创建精灵,并设置到__panel的位置
    local _sprite_render = cc.Sprite:createWithTexture(_texture)
    if __openAntiAlias then _sprite_render:getTexture():setAntiAliasTexParameters() end --设置抗锯齿
    _sprite_render:setIgnoreAnchorPointForPosition(false)
    _sprite_render:setAnchorPoint(_savedAnchorPoint)
    _sprite_render:setPosition(_savedPosition)
    
    return _sprite_render
end


function CommonHelper:getCurrentFontPath()
    local fontName = DataConfig.LangSwitch.getItem(GlobalHelper.m_language,"FontName")
    return string.format( "font/fnt_%s.fnt", fontName)
end

--创建fnt字体
function CommonHelper:createBMFontLabel(_text, _hAlignment, _bmfontPath, _maxLineWidth, _imageOffset)
    _bmfontPath = _bmfontPath or CommonHelper:getCurrentFontPath()

    _hAlignment = _hAlignment or cc.TEXT_ALIGNMENT_CENTER
    _maxLineWidth = _maxLineWidth or 0
    _imageOffset = _imageOffset or cc.p(0, 0)

    local _scale = DataConfig.LangSwitch.getItem(GlobalHelper.m_language,"Scale")
    local _label = cc.Label:createWithBMFont(_bmfontPath, _text, _hAlignment, _maxLineWidth, _imageOffset)
    _label:setScale(_scale)

    return _label
end

--创建ttf字体
function CommonHelper:createTTFFontLabel(str,_bmfontPath,fontsize,size,type1,type2)
    local _scale = DataConfig.LangSwitch.getItem(GlobalHelper.m_language,"Scale")
    local _label = cc.Label:createWithTTF(str,_bmfontPath,fontsize,size,type1,type2)
    _label:setScale(_scale)
    return _label
end


----------------------shader----------------------------
--自定义
function CommonHelper:shader_Custom(node, shaderKey, func)
	ShaderHelper:render(node, shaderKey, func)
end
--流光
function CommonHelper:shader_Flow_Light(node, func)
	ShaderHelper:render(node, Macros.ShaderResources.Flow_Light, func)
end

--置灰
function CommonHelper:shader_Grey(node, func)
	ShaderHelper:render(node, Macros.ShaderResources.Grey, func)
end
--默认
function CommonHelper:shader_Default(node, func)
	ShaderHelper:render(node, Macros.ShaderResources.Default, func)
end

-------------------------------------------------------------------

function CommonHelper:spineBoneConvertToNodePos(spine, boneName,toNode)
--	local 
end
return CommonHelper