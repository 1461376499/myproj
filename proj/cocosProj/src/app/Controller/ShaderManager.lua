local ShaderManager = class("ShaderManager")

local glProgramCache = cc.GLProgramCache:getInstance()

function ShaderManager:ctor()
	
end

function ShaderManager:init()
	
end

function ShaderManager:get(shaderConfig)		
	local _key = shaderConfig["key"]
	local _glGLProgram = glProgramCache:getGLProgram(_key)
	if _glGLProgram == nil then	
		local vert = shaderConfig["vert"]
		if vert == nil  or vert == "" then
			vert = "shader/ccShader_PositionTextureColor_noMVP.vert"
		end
		local vertSource = ccFileUtils:getStringFromFile(vert)
		local fragSource = ccFileUtils:getStringFromFile(shaderConfig["frag"])
		_glGLProgram = cc.GLProgram:createWithByteArrays(vertSource, fragSource)
		_glGLProgram:link()
		_glGLProgram:updateUniforms()
		glProgramCache:addGLProgram(_glGLProgram, _key)		
	end
	return _glGLProgram
end

function ShaderManager:render(node, shaderConfig, func)
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


function ShaderManager:set(node, glstate)
	local name = node:getName()

	--[[if type of the node is UI and has virtualRender, means that classes extend UIWidget, you must consider the virtualRender node]]
	if node.getVirtualRenderer then
		local sp_render = node:getVirtualRenderer()
		sp_render:setGLProgramState(glstate)	
	else
		node:setGLProgramState(glstate)	
	end
	
	local children = node:getChildren() or  {}
	for k, child in pairs(children) do
		self:set(child, glstate)
	end
end

function ShaderManager:clear()
	cc.GLProgramCache:destroyInstance()
end

return ShaderManager
