Player = Class{}

function Player:init(x, y)
    self.x = x
    self.y = y
    
        
    self.width = 70
    self.height = 20

end
   


function Player:render() 
  love.graphics.setColor(51/225, 102/225, 153/225, 225/225)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)  
end
    