local GameManager = class("GameManager")

GameManager.m_language = 1			--语言

function GameManager:ctor()
	
end


function GameManager:endGame()
	--清出缓存shader
	ShaderManager:clear()

	--清出缓存ui
	UICacheManager:clear()
end

return GameManager