-- Auto Generate by Excel LanguageSwitch.xlsx, Don't try to modify!

local _Config = {}

_Config = {
    id_1 = {Id = 1, Order = 2, LangId = 'cn', FontName = 'cn1', Res = 'sy_language_txt_chinese', Scale = 0.7}, 
    id_2 = {Id = 2, Order = 1, LangId = 'en', FontName = 'en', Res = 'sy_language_txt_english', Scale = 0.7}, 
    id_3 = {Id = 3, Order = 3, LangId = 'gr', FontName = 'gr', Res = 'sy_language_txt_german', Scale = 0.6}, 
    id_4 = {Id = 4, Order = 4, LangId = 'fr', FontName = 'fr', Res = 'sy_language_txt_french', Scale = 0.6}, 
    _length = 4
}

function _Config.getData(Id)
    local _data = _Config["id_"..Id]
    if _data then return _data end
    return nil
end

function _Config.getItem(Id, Key)
    local _data = _Config.getData(Id)
    if _data then return _data[Key] end
    return nil
end

function _Config.getDataWithKey(Key, Value)
    local _dataList = {}
    for k,_data in pairs(_Config) do
        if type(_data) == "table" and _data[Key] == Value then
            table.insert(_dataList, _data)
        end
    end
    return _dataList
end

function _Config.Data()
    local _dataList = {}
    for k,_data in pairs(_Config) do
        if type(_data) == "table" then table.insert(_dataList, _data) end
    end
    return _dataList
end

return _Config