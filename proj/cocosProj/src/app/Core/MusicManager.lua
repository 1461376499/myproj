--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local MusicManager = class("MusicManager")
if nil == ccexp.AudioEngine then
    return
end
local AudioEngine = ccexp.AudioEngine
--local AudioEngine = cc.SimpleAudioEngine:getInstance()
local M = {
    bgmMusic     = {},
    effectSounds = {}
}
function MusicManager:ctor()
	self.volume = 0.3
end

function MusicManager:setVolume(volume)
	self.volume = volume
	for k,v in pairs(M.bgmMusic) do
        AudioEngine:setVolume(v["id"], volume)
    end
end

function MusicManager:playMusic()  --播放背景音乐
    local musicKey = self:getMusicKey()
    if self:getMusicEnabled() then
        self:pauseAllMusic(musicKey)

        if M.bgmMusic[musicKey] then
            self:resumeMusic(musicKey)
        else
            M.bgmMusic[musicKey] = {
                id  = AudioEngine:play2d(string.format("sfx/%s.mp3", self:getMusicName(musicKey)), true, self.volume),
                musicKey = musicKey
            }
            print("music test")
            print(self:getMusicName(musicKey))
            print(musicKey)
        end
    end
end

function MusicManager:resumeMusic(key)
    AudioEngine:setVolume(M.bgmMusic[key]["id"], self.volume)
    AudioEngine:resume(M.bgmMusic[key]["id"])
end

--暂停背景音乐
function MusicManager:pauseAllMusic(ignoreKey)
    for k,v in pairs(M.bgmMusic) do
        if ignoreKey ~= k then
            AudioEngine:setVolume(v["id"],0)
            AudioEngine:pause(v["id"])
        end
    end
end

--删除背景音乐
function MusicManager:delAllMusic()
    for k,v in pairs(M.bgmMusic) do
        AudioEngine:setVolume(v["id"],0)
        AudioEngine:setLoop(v["id"],false)
    end
    M.bgmMusic = {}
end

--暂停音效
function MusicManager:pauseAllEffect()
    for k,v in pairs(M.effectSounds) do
		AudioEngine:setVolume(v["id"],0)
        AudioEngine:pause(v["id"])
    end
end

--恢复音效
function MusicManager:resumeAllEffect()
    for k,v in pairs(M.effectSounds) do
		AudioEngine:setVolume(v["id"], self.volume)
        AudioEngine:resume(v["id"])
    end
end

function MusicManager:playEffect(effectKey, isLoop)    --播放音效

    isLoop = isLoop or false

    if effectKey and effectKey ~= "" and self:getEffectEnabled() then
        M.effectSounds[effectKey] = {
            id  = AudioEngine:play2d(string.format("sfx/%s.mp3", self:getMusicName(effectKey)), isLoop),
            effectKey = effectKey
        }
        AudioEngine:setFinishCallback(M.effectSounds[effectKey]["id"], function(id, file)
            if M.effectSounds[effectKey] and M.effectSounds[effectKey]["id"] == id then
                M.effectSounds[effectKey] = nil
            end
        end)
    end
end

function MusicManager:changeEffectStop(effectKey)
    if M.effectSounds[effectKey] ~= nil then        
        AudioEngine:setVolume(M.effectSounds[effectKey]["id"],0)
        AudioEngine:setLoop(M.effectSounds[effectKey]["id"],false)
    end
end

function MusicManager:effectPlaying(effectKey)
    if M.effectSounds[effectKey] ~= nil then
        return true
    end
    return false
end

function MusicManager:getMusicName(key)
    local config  = DataConfig.Music.getData(key)

    if config ~= nil then

        return config.Path
    else
        return "unknown"
    end
end

function MusicManager:getMusicFilePath(key)
    return string.format( "sfx/%s.mp3", self:getMusicName(key))
end

function MusicManager:changeMusicState(state)

    cc.UserDefault:getInstance():setBoolForKey("isPlayBackgroundMusic", state)

    if state then
        self:playMusic()
    else
        self:pauseAllMusic()
    end
end

function MusicManager:changeEffectState(state)

    cc.UserDefault:getInstance():setBoolForKey("isPlayEffectMusic", state)

    if state then
        self:playEffect("JZ_AN_DJ")
    else
        for id, effectsKey in pairs(M.effectSounds) do
            self:changeEffectStop(id)
        end
    end
end

function MusicManager:getMusicEnabled()
    return cc.UserDefault:getInstance():getBoolForKey("isPlayBackgroundMusic", true)
end

function MusicManager:getEffectEnabled()
    return cc.UserDefault:getInstance():getBoolForKey("isPlayEffectMusic", true)
end

function MusicManager:getMusicKey()
    local key = "Music1"

--    if sceneManager:isFightScene() then  --非挂机战斗场景
--        key = "MusicBs"
--    elseif sceneManager:isIdleScene() then
--        local idleScene = sceneManager:getRunningScene()
--        if idleScene._fighting_Layer and idleScene._fighting_Layer:isVisible() then  --挂机战斗
--            key = "Music1"
--        elseif idleScene._castle_Layer and idleScene._castle_Layer:isVisible() then --城堡
--            key = "MusicCB"
--        elseif idleScene._gonghui_Layer and idleScene._gonghui_Layer:isVisible()  then --工会
--            key = "MusicGH"
--        end
--    end

    return key
end

return MusicManager



--endregion
