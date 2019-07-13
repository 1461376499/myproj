--[[
	对象缓存
	]]--
local GameUICacheHelper = class("GameUICacheHelper")

--对象池
GameUICacheHelper.M = {}

function GameUICacheHelper:ctor()
	self.cacheIdx = 0
end

function GameUICacheHelper:put(key, count)
	count = count or 1
	for i = 1, count do
		local obj = self:_create(key)
		self:_put(obj)
	end
end

function GameUICacheHelper:get(key, parent)
	local retWidget = self:_get()
	if retWidget then
		retWidget:addTo(parent)

		--put的时候retain了
		retWidget:release()
	end
	return retWidget;
end

function GameUICacheHelper:collect()


end

function GameUICacheHelper:clear()
	for i,obj in ipairs(self.M) do
		obj:release()
	end
	self.M = {}
	self.cacheIdx = 0
end


--Internal Function-------------------------------------------------------------

--[[
	创建一个对象
	@prama1: ui路径
]]--
function GameUICacheHelper:_create(_key)
	self.cacheIdx = self.cacheIdx + 1
	
	local obj = CommonUIUtils:loadWidget(key)
	obj.poolKey = _key
	obj.inPool = false
	obj.index = self.cacheIdx

	
end

--[[
	添加一个UI到对象池
	@prama1: 添加的对象
]]--
function GameUICacheHelper:_put(obj)
	if obj and obj.inPool == false then
		obj:retain()
		obj.inPool = true
		table.insert(self.M, obj)	
	end
end


--[[
	从对象池中取出一个对象
	@prama1: ui路径，也是缓存的Key值
	return  获取到的对象
]]--
function GameUICacheHelper:_get(key)
	local retObj, index;

	for i, obj in ipairs(self.M) do
		if obj.inPool and key ==  obj.poolKey then
			retObj = obj
			index = i
			break;
		end
	end

	if retObj then
		table.remove(self.M, index)
		retObj.inPool = false
	end

	return retObj;
end



return GameUICacheHelper