-----------------------------------------------------------------------------------------
--
-- main.lua
-- Created by: Sebastian N
-- Created on: May 3
--
-- This program moves an object to four sides and has gravity
-----------------------------------------------------------------------------------------
-- Addition of physics
local physics = require('physics')
physics.start()
physics.setGravity(0, 25)
--physics.setDrawMode('hybrid')

local theBullets = {} -- This is the table created

-- Left barrier
local leftBarrier = display.newRect(0, display.contentHeight / 2, 1, display.contentHeight)
leftBarrier.id = 'The left Barrier'
physics.addBody(leftBarrier, 'static', {
	friction = 0.5,
	bounce = 0.3
})

-- Right barrier
--local rightBarrier = display.newRect(display.contentWidth, display.contentHeight / 2, 1, display.contentHeight)
--rightBarrier.id = 'The right barrier'
--physics.addBody(rightBarrier, 'static', {
--	friction = 0.5,
--	bounce = 0.3
--})

-- The land from the top
local topLand = display.newImageRect('./Assets/Sprites/land.png', 1000, 200)
topLand.x = display.contentCenterX + 800
topLand.y = display.contentCenterY
topLand.id = 'Top land'
physics.addBody(topLand, 'static', {
	friction = 0.5,
	bounce = 0.3
	})

-- The land
local theLand = display.newImageRect('./Assets/Sprites/land.png', 2000, 400)
theLand.x = display.contentCenterX + 500
theLand.y = display.contentHeight
theLand.id = 'The land'
-- Addition of physics for the land
physics.addBody(theLand, 'static', {
	friction = 0.5,
	bounce = 0.3
	})

-- The character
local theSnowMan = display.newImageRect('./Assets/Sprites/SnowMan.png', 350, 400)
theSnowMan.x = display.contentCenterX + 500
theSnowMan.y = display.contentCenterY - 500
theSnowMan.id = 'Snow Man'
-- Addition of physics for the snow man
physics.addBody(theSnowMan, 'dynamic', {
	density = 3.0,
	friction = 0.5,
	bounce = 0.3
	})
theSnowMan.isFixedRotation = true

-- The second dynamic sprite
--local theLandSquare = display.newImage('./Assets/Sprites/landSquare.png')
--theLandSquare.x = display.contentCenterX
--theLandSquare.y = display.contentCenterY
--theLandSquare.id = 'The land square'
--physics.addBody(theLandSquare, 'dynamic', {
--	friction = 0.5,
--	bounce = 0.3
--	})
--theLandSquare.isFixedRotation = true

-- the enemy
local theEnemy = display.newImageRect('./Assets/Sprites/enemy.png', 300, 400)
theEnemy.x = display.contentWidth - 300
theEnemy.y = display.contentHeight - 300
theEnemy.id = 'the enemy'
physics.addBody(theEnemy, 'dynamic', {
	friction = 0.5,
	bounce = 0.3
	})
theEnemy.isFixedRotation = true

-- D-pad
local thedPad = display.newImage('./Assets/Sprites/d-pad.png')
thedPad.x = 160
thedPad.y = display.contentHeight - 160
thedPad.id = 'The d-pad'
thedPad.alpha = 0.5

-- Up arrow
local upArrow = display.newImage('./Assets/Sprites/upArrow.png')
upArrow.x = 160
upArrow.y = display.contentHeight - 268.7
upArrow.id = 'Up arrow'

-- Down arrow
local downArrow = display.newImage('./Assets/Sprites/downArrow.png')
downArrow.x = 160
downArrow.y = display.contentHeight - 52.3
downArrow.id = 'Down arrow'

-- Left arrow
local leftArrow = display.newImage('./Assets/Sprites/leftArrow.png')
leftArrow.x = 52
leftArrow.y = display.contentHeight - 160
leftArrow.id = 'Left arrow'

-- Right arrow
local rightArrow = display.newImage('./Assets/Sprites/rightArrow.png')
rightArrow.x = 268.7
rightArrow.y = display.contentHeight - 160
rightArrow.id = 'Right arrow'

-- Jump button
local jumpButton = display.newImage('./Assets/Sprites/jumpButton.png')
jumpButton.x = display.contentWidth - 80
jumpButton.y = display.contentHeight - 80
jumpButton.id = 'Jump button'
jumpButton.alpha = 1

local shootButton = display.newImage('./Assets/Sprites/jumpButton.png')
shootButton.x = display.contentWidth - 230
shootButton.y = display.contentHeight - 80
shootButton.id = 'Shoot button'

-- Up Arrow Functions
function upArrow:touch(event)
	if (event.phase == 'ended') then
		-- Movement function
		transition.moveBy(theSnowMan, { 
			x = 0,
			y = -50,
			time = 100
			})
	end
end

-- Down Arrow Functions
function downArrow:touch(event)
	if (event.phase == 'ended') then
		-- Movement function
		transition.moveBy(theSnowMan, { 
			x = 0,
			y = 50,
			time = 100
			})
	end
end

-- Left Arrow Functions
function leftArrow:touch(event)
	if (event.phase == 'ended') then
		-- Movement function
		transition.moveBy(theSnowMan, { 
			x = -50,
			y = 0,
			time = 100
			})
	end
end

-- Right Arrow Functions
function rightArrow:touch(event)
	if (event.phase == 'ended') then
		-- Movement function
		transition.moveBy(theSnowMan, { 
			x = 50,
			y = 0,
			time = 100
			})
	end
end

-- Respawn snowman function
local function falllingSnow(event)
	if theSnowMan.y > display.contentHeight + 300 then
		theSnowMan.x = display.contentCenterX + 500
		theSnowMan.y = display.contentCenterY - 500
	end
	--if theLandSquare.y > display.contentHeight + 300 then
	--	theLandSquare.x = display.contentCenterX
	--	theLandSquare.y = display.contentCenterY
	--end
end

-- Respawn land function
--local function fallingLand(event)
--	if theLandSquare.y > display.contentHeight + 300 then
--		theLandSquare.x = display.contentCenterX
--		theLandSquare.y = display.contentCenterY
--	end
--end


-- Jumping function
local function jumpingSnow(event)
	if event.phase == 'ended' then
		theSnowMan:setLinearVelocity(0, -750)
	end
end

-- Collision function
local function collisionControl(self, event)
	if (event.phase == 'began') then
		print(self.id.. ' is on collision with '..event.other.id)
	elseif (event.phase == 'ended') then
		print(self.id.. ' ended collision with '..event.other.id)
	end
end

-- Shoot function 
function shootButton:touch(event)
	if (event.phase == 'began') then
		-- Creating the bullet in screen
		local singleBullet = display.newImage('./Assets/Sprites/Kunai.png')
		singleBullet.x = theSnowMan.x + 250
		singleBullet.y = theSnowMan.y
		singleBullet.id = 'the bullet'
		physics.addBody(singleBullet, 'dynamic')
		singleBullet.isFixedRotation = true
		-- Making the object a bullet
		singleBullet.isBullet = true
		singleBullet.gravityScale = 0
		singleBullet:setLinearVelocity(1500, 0)

		-- Putting the bullet into the table
		table.insert(theBullets, singleBullet)
		print('# of bullet '.. tostring(#theBullets))
	end
end

local function checkBulletsOutBounds(event)
	-- variable for the counter
	local bulletCounter

	if #theBullets > 0 then
		for bulletCounter = #theBullets, 1, -1 do
			if theBullets[bulletCounter].x > display.contentWidth + 1000 then
				theBullets[bulletCounter]:removeSelf()
				theBullets[bulletCounter] = nil
				table.remove(theBullets, bulletCounter)
				print('# of bullet left: '.. tostring(#theBullets))
			end
		end
	end
end

-- Multi collision function
local function onCollision(event)
	if (event.phase == 'began') then
		-- Variables for object order
		local obj1 = event.object1
		local obj2 = event.object2
		local explosionLocationX = obj1.x
		local explosionLocationY = obj1.y

		if (obj1.id == 'the bullet' and obj2.id == 'the enemy') or 
			(obj1.id == 'the enemy' and obj2.id == 'the bullet') then
			-- Removing objects from screen
			--display.remove(obj1)
			--display.remove(obj2)

			-- For loop to erase bullets
			local bulletCounter
			for bulletCounter = #theBullets, 1, -1 do
				if (theBullets[bulletCounter] == obj1 or theBullets[bulletCounter] == obj2) then
					theBullets[bulletCounter]:removeSelf()
					theBullets[bulletCounter] = nil
					table.remove(theBullets, bulletCounter)
					break
				end
			end

			--Remove character
			theEnemy:removeSelf()
			theEnemy = nil

			-- Increase score
			print('You could increase your score here')

			-- Sound effect
			local explosionSound = audio.loadStream('./Assets/Sounds/explosion.wav')
			local explosionChannel = audio.play(explosionSound)

			-- Code that deals with the explosions 
			-- variable that contains the parameters for the function
			local emitterParams = {

			    startColorAlpha = 1,

			    startParticleSizeVariance = 250,

			    startColorGreen = 0.3031555,

			    yCoordFlipped = -1,

			    blendFuncSource = 769,

			    rotatePerSecondVariance = 153.95,

			    particleLifespan = 0.7237,

			    tangentialAcceleration = -1440.74,

			    finishColorBlue = 0.3699196,

			    finishColorGreen = 0.5443883,

			    blendFuncDestination = 769,

			    startParticleSize = 400.95,

			    startColorRed = 0.8373094,

			    textureFileName = "./assets/sprites/fire.png",

			    startColorVarianceAlpha = 1,

			    maxParticles = 100,

			    finishParticleSize = 540,

			    duration = 0.25,

			    finishColorRed = 1,

			    maxRadiusVariance = 72.63,

			    finishParticleSizeVariance = 250,

			    gravityy = -6710.05,

			    gravityx = -8000,

			    speedVariance = 90.79,

			    tangentialAccelVariance = -420.11,

			    angleVariance = -142.62,

			    angle = -244.11
			}

			-- Function that generates explosion (particle emitter)
			local emitter = display.newEmitter(emitterParams)
			emitter.x = explosionLocationX
			emitter.y = explosionLocationY
		end
	end
end




-- Event Listeners
upArrow:addEventListener('touch', upArrow)
downArrow:addEventListener('touch', downArrow)
leftArrow:addEventListener('touch', leftArrow)
rightArrow:addEventListener('touch', rightArrow)
Runtime:addEventListener('enterFrame', falllingSnow)
jumpButton:addEventListener('touch', jumpingSnow)
--Runtime:addEventListener('enterFrame', fallingLand)

-- Event listener for the bullets
shootButton:addEventListener('touch', shootButton)
Runtime:addEventListener('enterFrame', checkBulletsOutBounds)

-- Event listener for collision
theSnowMan.collision = collisionControl
theSnowMan:addEventListener('collision')
--theLandSquare.collision = collisionControl
--theLandSquare:addEventListener('collision')

-- Event listener for multi collision
Runtime:addEventListener('collision', onCollision)



