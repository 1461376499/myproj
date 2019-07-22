local GameShaderHelper = class("GameShaderHelper")

local glProgramCache = cc.GLProgramCache:getInstance()

function GameShaderHelper:ctor()
	
end

function GameShaderHelper:init()
	
end

function GameShaderHelper:get(shaderConfig)		
	local _key = shaderConfig["key"]
	local _glGLProgram = glProgramCache:getGLProgram(_key)
	if _glGLProgram == nil then	
		local vertSource = ccFileUtils:getStringFromFile(shaderConfig["vert"])
		local fragSource = ccFileUtils:getStringFromFile(shaderConfig["frag"])
		_glGLProgram = cc.GLProgram:createWithByteArrays(vertSource, fragSource)
		_glGLProgram:link()
		_glGLProgram:updateUniforms()
		glProgramCache:addGLProgram(_glGLProgram, _key)		
	end
	return _glGLProgram
end

function GameShaderHelper:render(node, shaderConfig, func)
	if shaderConfig == nil then
		return;
	end

	local _glGLProgram = self:get(shaderConfig)
	if _glGLProgram then
		local _glstate = cc.GLProgramState:getOrCreateWithGLProgram(_glGLProgram)
		if _glstate then
			self:set(node, _glstate)
			if func then
				 func(node, _glstate)
			end
		end
	end
end


function GameShaderHelper:set(node, glstate)
	local name = node:getName()
	if node.getVirtualRenderer then
		if node.isScale9Enabled ~= nil and node:isScale9Enabled() then
			local sp_render = node:getVirtualRenderer()
			sp_render:setGLProgramState(glstate)	
			local spChildren = sp_render:getChildren()
			for k, child in pairs(spChildren) do
				self:set(child, glstate)
			end
		end
	else
		node:setGLProgramState(glstate)	
	end
	
	local children = node:getChildren() or  {}
	for k, child in pairs(children) do
		self:set(child, glstate)
	end
end

function GameShaderHelper:clear()
	glProgramCache:destroyInstance()
end

return GameShaderHelper
