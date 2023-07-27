Bullet = Class{}

function Bullet:init(x, y)
    self.x = x
    self.y = y

    self.width = 6.5
    self.height = 10
end

function Bullet:collides(player)
    if self.x > player.x + player.width or player.x > self.x + self.width then
		return false
	end
	
	if self.y > player.y + player.height or player.y > self.y + self.height then
		return false
	end
	
	return true
end

function Bullet:render()
    love.graphics.setColor(76/225, 76/225, 96/225, 225/225)
    love.graphics.rectangle( 'fill', self.x, self.y, self.width, self.height)
end

