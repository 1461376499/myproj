--[[
	UI对象缓存
  ]]--
local UICacheManager = class("UICacheManager")

--对象池
UICacheManager.M = {}

function UICacheManager:ctor()
	self.cacheIdx = 0
end

function UICacheManager:put(key, count)
	count = count or 1
	for i = 1, count do
		local obj = self:_create(key)
		self:_put(obj)
	end
end

function UICacheManager:get(key, parent)
	local retWidget = self:_get()
	if retWidget then
		retWidget:addTo(parent)

		--put的时候retain了
		retWidget:release()
	end
	return retWidget;
end

function UICacheManager:collect()


end

function UICacheManager:clear()
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
function UICacheManager:_create(_key)
	self.cacheIdx = self.cacheIdx + 1
	
	local obj = CommonHelper:loadWidget(key)
	obj.poolKey = _key
	obj.inPool = false
	obj.index = self.cacheIdx

	
end

--[[
	添加一个UI到对象池
	@prama1: 添加的对象
]]--
function UICacheManager:_put(obj)
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
function UICacheManager:_get(key)
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



return UICacheManager