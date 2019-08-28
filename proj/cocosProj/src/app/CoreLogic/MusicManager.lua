--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local GameMusicHelper = class("GameMusicHelper")
if nil == ccexp.AudioEngine then
    return
end
local AudioEngine = ccexp.AudioEngine
--local AudioEngine = cc.SimpleAudioEngine:getInstance()
local M = {
    bgmSound     = {},
    effectSounds = {}
}
function GameMusicHelper:ctor()
end

function GameMusicHelper:playMusic()  --播放背景音乐
    local musicKey = GameBGMHelper:getMusicKey()
    if self:getMusicState() then
        self:pauseAllMusic(musicKey)

        if M.bgmSound[musicKey] then
            self:resumMusic(musicKey)
        else
            M.bgmSound[musicKey] = {
                id  = AudioEngine:play2d(string.format("sfx/%s.mp3", self:getMusicName(musicKey)), true, 0.3),
                key = musicKey
            }
            print("music test")
            print(self:getMusicName(musicKey))
            print(musicKey)
        end
    end
end

function GameMusicHelper:resumMusic(key)
    AudioEngine:setVolume(M.bgmSound[key]["id"],0.3)
    AudioEngine:resume(M.bgmSound[key]["id"])
end

--暂停背景音乐
function GameMusicHelper:pauseAllMusic(ignoreKey)
    for k,v in pairs(M.bgmSound) do
        if ignoreKey ~= k then
            AudioEngine:setVolume(v["id"],0)
            AudioEngine:pause(v["id"])
        end
    end
end

--删除背景音乐
function GameMusicHelper:delAllMusic()
    for k,v in pairs(M.bgmSound) do
        AudioEngine:setVolume(v["id"],0)
        AudioEngine:setLoop(v["id"],false)
    end
    M.bgmSound = {}
end

--暂停音效
function GameMusicHelper:pauseAllEffect()
    for k,v in pairs(M.effectSounds) do
        AudioEngine:pause(v["id"])
    end
end

--恢复音效
function GameMusicHelper:resumeAllEffect()
    for k,v in pairs(M.effectSounds) do
        AudioEngine:resume(v["id"])
    end
end

function GameMusicHelper:playEffect(effectKey, isLoop)    --播放音效

    isLoop = isLoop or false

    if effectKey and effectKey ~= "" and self:getEffectState() then
        M.effectSounds[effectKey] = {
            id  = AudioEngine:play2d(string.format("sfx/%s.mp3", self:getMusicName(effectKey)), isLoop),
            key = effectKey
        }
        AudioEngine:setFinishCallback(M.effectSounds[effectKey]["id"], function(id, file)
            if M.effectSounds[effectKey] and M.effectSounds[effectKey]["id"] == id then
                M.effectSounds[effectKey] = nil
            end
        end)
    end
end

function GameMusicHelper:changeEffectStop(effectKey)
    if M.effectSounds[effectKey] ~= nil then        
        AudioEngine:setVolume(M.effectSounds[effectKey]["id"],0)
        AudioEngine:setLoop(M.effectSounds[effectKey]["id"],false)
    end
end

function GameMusicHelper:effectPlaying(effectKey)
    if M.effectSounds[effectKey] ~= nil then
        return true
    end
    return false
end

function GameMusicHelper:getMusicName(key)
    local config  = DataConfig.Music.getData(key)

    if config ~= nil then

        return config.Path
    else
        return "unknown"
    end
end

function GameMusicHelper:getMusicFilePath(key)
    return string.format( "sfx/%s.mp3", self:getMusicName(key))
end

function GameMusicHelper:changeMusicState(state)

    cc.UserDefault:getInstance():setBoolForKey("isPlayBackgroundMusic", state)

    if state then
        self:playMusic()
    else
        self:pauseAllMusic()
    end
end

function GameMusicHelper:changeEffectState(state)

    cc.UserDefault:getInstance():setBoolForKey("isPlayEffectMusic", state)

    if state then
        self:playEffect("JZ_AN_DJ")
    else
        for k,v in pairs(M.effectSounds) do
            self:changeEffectStop(k)
        end
    end
end

function GameMusicHelper:getMusicState()
    return cc.UserDefault:getInstance():getBoolForKey("isPlayBackgroundMusic", true)
end

function GameMusicHelper:getEffectState()
    return cc.UserDefault:getInstance():getBoolForKey("isPlayEffectMusic", true)
end

function GameMusicHelper:getMusicKey()
    local key = "Music1"

    if sceneManager:isFightScene() then  --非挂机战斗场景
        key = "MusicBs"
    elseif sceneManager:isIdleScene() then
        local idleScene = sceneManager:getRunningScene()
        if idleScene._fighting_Layer and idleScene._fighting_Layer:isVisible() then  --挂机战斗
            key = "Music1"
        elseif idleScene._castle_Layer and idleScene._castle_Layer:isVisible() then --城堡
            key = "MusicCB"
        elseif idleScene._gonghui_Layer and idleScene._gonghui_Layer:isVisible()  then --工会
            key = "MusicGH"
        end
    end

    return key
end

return GameMusicHelper



--endregion
