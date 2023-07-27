Player = Class{}

function Player:init(x, y)
	self.x = x
	self.y = y
	
	self.width = 20
	self.height = 20
end

function Player:collides(object)
    if self.x > object.x +object.width or self.x > self.x + slef.width then
        return false
    end

    if self.x > object.x +object.height or self.x > self.x + slef.height then
        return false
    end
    
    return true
end
function Player:render()
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
