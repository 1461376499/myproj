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
	local obj = self:_get(key)
	if obj == nil then
		self:put(key)
		obj = self:_get(key)
	end	
	if obj then
		obj:addTo(parent)

		--put的时候retain了
		obj:release()
	end
	
	return obj;
end

--回收
function UICacheManager:free(obj)	
	self:_put(obj)
end

function UICacheManager:clear()
	for i,obj in pairs(self.M) do
		obj:release()
	end
	self.M = {}
	self.cacheIdx = 0
end


---------------------------Internal Function-----------------------------
---------------------------Internal Function-----------------------------
---------------------------Internal Function-----------------------------
---------------------------Internal Function-----------------------------

--[[
	创建一个对象
	@prama1: key 路径
]]--
function UICacheManager:_create(key)
	self.cacheIdx = self.cacheIdx + 1
	local obj = CommonHelper:loadWidget(key)
	obj.poolKey = key
	obj.inPool = false
	obj.index = self.cacheIdx

	return obj
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
	local obj, i;

	for k, v in pairs(self.M) do
		if v.inPool and key == v.poolKey then
			obj = v
			i = k
			break;
		end
	end

	if obj then
		table.remove(self.M, i)
		obj.inPool = false
	end

	return obj;
end



return UICacheManager