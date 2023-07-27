push = require 'push'
Class = require 'class'

require 'Player'

require 'Bullet'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PLAYER_SPEED = 3

gameState = 'start'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    mediumFont = love.graphics.newFont('font.ttf', 10)
	largeFont = love.graphics.newFont('font.ttf', 20)
	
	love.graphics.setFont(mediumFont)
	
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = true,
		vsync = true
	})

	sounds = {
		['hit'] = love.audio.newSource('sounds/hit.wav', 'static'),
		['score'] = love.audio.newSource('sounds/score.wav', 'static')
	}
	
	player = Player(VIRTUAL_WIDTH / 2 - 30, VIRTUAL_HEIGHT - 20 )
	
	bullet2 = Bullet(VIRTUAL_WIDTH/2, -10)
	bullet1 = Bullet(20, -10)
	bullet3 = Bullet(VIRTUAL_WIDTH - 20,  -10)

	score = 0

	
end


function love.keypressed(key)
    if key == 'escape' then
		love.event.quit()
    end

	if key == 'enter' or key == 'return' then
	    if gameState == 'start' then
			gameState = 'game'
	    elseif gameState == 'game' then
			gameState = 'end'
			
	    elseif gameState == 'end' then
			
			gameState = 'start'
			score = 0
	    end
		
	end

end 	




function love.update(dt)


	if gameState == 'game' then 
		bullet1.y = math.min(bullet1.y + 3, VIRTUAL_HEIGHT)
		bullet2.y = math.min(bullet2.y + 3.3, VIRTUAL_HEIGHT)
		bullet3.y = math.min(bullet3.y + 2.8, VIRTUAL_HEIGHT)
	end



	if bullet1.y == VIRTUAL_HEIGHT then
		bullet1.y = 0 
		bullet1.x = math.random(0, VIRTUAL_WIDTH/3)
		
		score = score + 1
		sounds['hit']:play()

	elseif bullet2.y == VIRTUAL_HEIGHT then
		bullet2.y = 0
		bullet2.x = math.random(VIRTUAL_WIDTH/3, VIRTUAL_WIDTH*2/3)

		score = score + 1
		sounds['hit']:play()

	elseif bullet3.y == VIRTUAL_HEIGHT then
		bullet3.y = 0
		bullet3.x = math.random(VIRTUAL_WIDTH*2/3, VIRTUAL_WIDTH - 4)

		score = score + 1
		sounds['hit']:play()
	end


	
	if bullet1:collides(player) then
		sounds['score']:play(1)
		gameState = 'end'

	elseif bullet2:collides(player) then
		sounds['score']:play(1)
		gameState = 'end'

	elseif bullet3:collides(player) then
		sounds['score']:play(1)
		gameState = 'end'

	end


	if gameState == "end" then
	 bullet1.y = -10 
	 bullet2.y = -10
	 bullet3.y = -10 
    end


	if love.keyboard.isDown('left') then
		player.x = math.max(player.x - PLAYER_SPEED, 0)
	elseif love.keyboard.isDown('right') then
		player.x = math.min(player.x + PLAYER_SPEED, VIRTUAL_WIDTH - player.width)
	end
	


	if love.keyboard.isDown('a') then
		player.x = math.max(player.x - PLAYER_SPEED, 0)
	elseif love.keyboard.isDown('d') then
		player.x = math.min(player.x + PLAYER_SPEED, VIRTUAL_WIDTH - player.width)
	end

end



function love.draw()
 push:start()
 
 love.graphics.clear(0/225, 0/225, 35/225, 225/225)

    if gameState == 'start' then
		love.graphics.setFont(mediumFont)
		love.graphics.printf('press enter to start', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'game' then
		love.graphics.setFont(largeFont)
		love.graphics.printf(score, 0, 30, VIRTUAL_WIDTH, 'center') 
    elseif gameState == 'end' then
		love.graphics.setFont(largeFont)
		love.graphics.printf(score, 0, 30, VIRTUAL_WIDTH, 'center')
		love.graphics.setFont(mediumFont)
		love.graphics.printf('GAME OVER!', 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center' )
    end 

  player:render()

  bullet1:render()
  bullet2:render()
  bullet3:render()
 
  push:finish()
end
