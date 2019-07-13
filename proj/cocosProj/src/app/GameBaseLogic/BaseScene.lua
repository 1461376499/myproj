
local BaseScene = class("BaseScene", cc.Scene)


function BaseScene:ctor()



end

--please override
function BaseScene:onEnter()
	
end

--please override
function BaseScene:onEnterTransitionFinish()

end


--please override
function BaseScene:onExitTransitionStart()
	
end

--please override
function BaseScene:onExit()
	self:disableNodeEvents()	
end


--please override
function BaseScene:onCleanup()
	
end



return BaseScene