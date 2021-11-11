-- title:  main.lua
-- author(s): ReptitceFnct
-- desc:   little shoot'em up; use the arrow for move the player and for shoot use the key space; for quit the game you can use escape
-- script: lua
-- input:  
-- saveid: shoot'em up v.3

-------------
-- H E A D --
-------------

-- this line display mark in the the console when the program work
io.stdout:setvbuf('no')

-- stop the love filter when the image is resized
love.graphics.setDefaultFilter("nearest")

-- for intialited the random 
math.randomseed(love.timer.getTime())

-- return the angle between two points 
function math.angle(x1, y1, x2, y2) return math.atan2(y2 - y1, x2 - x1) end


-----------------------
-- V A R I A B L E S --
-----------------------

-- sprite 
local image

--screen 
local screenWidth
local screenHeight


-- heros
heros = {}

-- sound -- 
-- sound of shoot
soundShoot = love.audio.newSource("sounds/shoot.wav", "static")

-- sound explosion
soundExplosion = love.audio.newSource("sounds/explode_touch.wav", "static")


-- list --

-- sprite
list_sprites = {}

-- shoot
list_shoots = {}

-- aliens
list_aliens = {}

--level 16X12 the map 

level = {}
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,2,2,2,2,2,2,2,2,0,0 })
table.insert(level, { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,2,2,2,2,2,2,2,2,0,0 })
table.insert(level, { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,2,2,2,2,2,2,2,2,0,0 })
table.insert(level, { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,2,2,2,2,2,2,2,2,0,0 })
table.insert(level, { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 })

-- camera
camera = {}
camera.y = 0
camera.speed = 1

--display screen
displayScreen = "menu"

-- game win 
win = false
timerWin = 0
 

--sprite image
imgSprites =  {}
local n

for n = 1, 3 do
  
  imgSprites[n] = love.graphics.newImage("Images/tuile_"..n..".png")
end

-- explosion image 
imgExplosion = {}

for n = 1, 5 do 
  
  imgExplosion[n] = love.graphics.newImage("Images/explode_"..n..".png")
end


-- menu image 
imgMenu = love.graphics.newImage("Images/menu.jpg")

-- game over image
imgGameOver = love.graphics.newImage("Images/gameover.jpg")

-- win image 

imgWin = love.graphics.newImage("Images/victory.jpg")

-- backgroud image
imgBackground = love.graphics.newImage("Images/fond.jpg")

-----------------------
-- F U N C T I O N S --
-----------------------

-- this function tcheck the collide between two object 
function collide(a1, a2)
  if (a1==a2) then return false end
  
  local dx = a1.x - a2.x
  local dy = a1.y - a2.y
    if (math.abs(dx) < a1.image:getWidth() + a2.image:getWidth()) then
      
      if (math.abs(dy) < a1.image:getHeight() + a2.image:getHeight()) then
        
        return true
      end
    end
  return false
end

-- this functuon is call for create a shoot and stock it in a list 
function CreateShoot(pType, pImage, pX, pY, pSpeedX, pSpeedY)
  
    local shoot = CreateSprite(pImage, pX, pY, pSpeedX, pSpeedY)
    shoot.type = pType
    shoot.speedX = pSpeedX
    shoot.speedY = pSpeedY
    table.insert(list_shoots, shoot)
    
    soundShoot:play()
end

-- this function is call for create an alien and give to it its specificity 
function CreateAlien(pType, pX, pY)
  
  
  local ImageName = ""
  if pType == 1 then
    
    ImageName = "enemy1"

    
  elseif pType == 2 then 
  
    ImageName = "enemy2"

  elseif pType == 3 then 
  
    ImageName = "tourelle"
    
  elseif pType == 10 then 
    
    ImageName = "enemy3"

  end
  
  local alien = CreateSprite(ImageName, pX, pY)
  
  alien.type = pType
  
  alien.sleep = true
  alien.chronoShoot = 0
  
    if pType == 1 then
    
    
    alien.vy = 2
    alien.vx = camera.speed
    alien.energy = 1
    
  elseif pType == 2 then 
  
    
    alien.vy = 2
    local direction = math.random(1, 2)
    alien.energy = 3
    
    if direction == 1 then
      
      alien.vx = 1
      
    else
      
      alien.vx = -1
    end
    
  elseif pType == 3 then 
     
     alien.vx = 0
     alien.vy = camera.speed
     alien.energy = 5
     
  elseif pType == 10 then 
    
    alien.vx = 0
    alien.vy = camera.speed * 2 
    alien.energy = 20
    alien.angle = 0
    
  end
  
  table.insert(list_aliens, alien)
end 

-- this function is call each time we want to display a sprite or an animation of sprite
function CreateSprite(pImageName, pX, pY)
  
  sprite = {}
  sprite.x = pX
  sprite.y = pY
  sprite.remove = false
  sprite.image = love.graphics.newImage("Images/"..pImageName..".png")
  sprite.w = sprite.image:getWidth()
  sprite.h = sprite.image:getHeight()
  
  sprite.frame = 1
  sprite.listFrames = {}
  sprite.maxFrames = 1
  
  table.insert(list_sprites, sprite)
  
  return sprite
end 


-- this function is call for make the animation of explosion
function CreateExplosion (pX, pY)
  
  local newExplosion = CreateSprite("explode_1", pX, pY)
  
  newExplosion.listFrames = imgExplosion
  newExplosion.maxFrames = 5
  
  
end

-- call one time at the start of the game 
function love.load()
  
  -- screen option
  love.window.setMode(1024,768)
  love.window.setTitle("shoot'em up")
  
  -- background
  backgroundX = 0
  backgroundY = 0
  
  
  -- size of the screen 
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()
  

  -- resize of the hero sprite
  heros = CreateSprite("heros", screenWidth / 2, screenHeight / 2)
  
  GameStart()
  
  
end


-- in this function we put all the thing we want to call at the start of the game 
function GameStart()
  
  -- definition of the spawn point and the life point of the hero 
  heros.x = screenWidth / 2
  heros.y = screenHeight - (heros.h * 2)
  heros.life = 3
  
  
  --color of the player life 
  colorLife = {0, 255, 0, 1}
  lifeText = {colorLife, "life : "..heros.life}
  
  -- creation of aliens --
  
  --creation of the first alien
  local line = 4
  CreateAlien(1, screenWidth / 2, -(64 / 2) - (64 * (line - 1)))
  
  --creation of the second alien
  local line = 10
  CreateAlien(2, screenWidth / 2, -(64 / 2) - (64 * (line - 1)))
  
  --creation of the third alien
  local line = 11
  CreateAlien(3, 3 * 64, -(64 / 2) - (64 * (line - 1)))
  
  --creation of alien boss
  local line = 20
  CreateAlien(10, screenWidth / 2, -(64 / 2) - (64 * (line - 1)))
  
  -- remove the value of the camera
  camera.y = 0
  
  --win
  win = false
  timerWin = 0
  
end


-- funtion call at the end of game for refresh all the value (alien position, all the shoot, etc ...) 
function GameEnd()
  
  --reset value(for security)
  heros.x = 0
  heros.y = 0
  heros.life = 0
  
  --remove shoot
  for n = #list_shoots, 1, -1 do
    
    local shoot = list_shoots[n]
    shoot.remove = true
    shoot.maxFrames = 0
    table.remove(list_shoots, n)
  end
  
  --remove alien 
  local nAlien
  for nAlien = #list_aliens, 1, -1 do
    
    local alien = list_aliens[nAlien]
    alien.remove = true
    table.remove(list_aliens, nAlien)
  end
end


-- all the thing we want to update hero and ennemi position, shoot position the camera position and the background etc... (is for free love.update)
function updateGame()
  
    -- move camera
    camera.y = camera.y + camera.speed 
    
    -- scroll background
    backgroundY = backgroundY + camera.speed
    
    local n
    
    -- treatement of shoots
    for n = #list_shoots, 1, -1 do
      
      local shoot = list_shoots[n]
      shoot.x = shoot.x + shoot.speedX
      shoot.y = shoot.y + shoot.speedY
      
      -- tcheck if we hit the hero
      if shoot.type == "ennemi" then 
        
        if collide(heros, shoot) then
          
          shoot.remove = true
          table.remove(list_shoots, n)
          heros.life = heros.life - 1
          -- refresh the value life each time we take a hit 
          lifeText = {colorLife, "life : "..heros.life}
          
          if heros.life <= 0 then
            
            displayScreen = "gameOver"
            
          end
        end
      end 
      
      -- tcheck if we hit the allien
      if shoot.type == "ally" then 
        
        local nAlien
        for nAlien = #list_aliens, 1, -1 do 
          
          local alien = list_aliens[nAlien]
          if alien.sleep == false then
            
            if collide(shoot, alien) then
              
              CreateExplosion(shoot.x, shoot.y)
              shoot.remove = true
              table.remove(list_shoots, n)
              alien.energy = alien.energy - 1
              soundExplosion:play()
              
              if alien.energy <= 0 then
                
                for nExplosion = 1, 5 do
                  CreateExplosion(alien.x + math.random(-10, 10), alien.y + math.random(-10 , 10))
                end
                
                if alien.type == 10 then
                  
                  win = true 
                  timerWin = 50
                  
                  for nExplosion = 1, 20 do
                    
                    CreateExplosion(alien.x + math.random(-50, 50), alien.y + math.random(-50 , 50))
                  end
                end
                
                alien.remove = true
                table.remove(list_aliens, nAlien)
                
              end
            end
          end
        end
      end 
      
      -- tcheck if the shoot is out of the screen 
      if (shoot.y < 0 or shoot.y > screenHeight) and shoot.remove == false then 
        
        -- mark of sprite destruction
        shoot.remove = true
        table.remove(list_shoots, n)
        
        
      end 
    end
    
    -- treatement of the aliens
    for n = #list_aliens, 1, -1 do 
      
      local alien = list_aliens[n]
      
      if alien.y > 0 then 
        
        alien.sleep = false
      end
      
      if alien.sleep == false then
        
        alien.x = alien.x + alien.vx
        alien.y = alien.y + alien.vy
        
        
        
        
        
        if alien.type == 1 or alien.type == 2 then
          
          alien.chronoShoot = alien.chronoShoot - 1
          
          
          if alien.chronoShoot <= 0 then
           
            alien.chronoShoot = 60
          
            CreateShoot("ennemi", "laser2", alien.x, alien.y, 0, 10)
          end
          
        elseif alien.type == 3 then
          
          alien.chronoShoot = alien.chronoShoot - 1
          
          if alien.chronoShoot <= 0 then
           
            alien.chronoShoot = math.random(30, 40)
            local vX, vY
            local angle
            angle = math.angle(alien.x, alien.y, heros.x, heros.y)
            vX = 10 * math.cos(angle)
            vY = 10 * math.sin(angle)
            
            CreateShoot("ennemi", "laser2", alien.x, alien.y, vX, vY)
          end
        
        elseif alien.type == 10 then
        
          if alien.y > screenHeight / 3 then
            
            alien.y = screenHeight / 3
            
          end
          
          alien.chronoShoot = alien.chronoShoot - 1
          
          if alien.chronoShoot <= 0 then
           
            alien.chronoShoot = math.random(7, 10)
            local vX, vY
            alien.angle = alien.angle + 0.5
            angle = math.angle(alien.x, alien.y, heros.x, heros.y)
            vX = 10 * math.cos(alien.angle)
            vY = 10 * math.sin(alien.angle)
            
            CreateShoot("ennemi", "laser2", alien.x, alien.y, vX, vY)
          end
        
        end
      
      else
      
        alien.y = alien.y + camera.speed 
      end
    
      if alien.y > screenHeight then
        
        alien.remove = true
        table.remove(list_aliens, n)
      end
    
    
    end
    
    
    
    -- treatement and destruction of sprites
    for n = #list_sprites, 1, -1 do 
      
      local sprite = list_sprites[n]
      
      -- animated sprite ? 
      if sprite.maxFrames > 1 then
      
        sprite.frame = sprite.frame + 0.2
        if math.floor(sprite.frame) > sprite.maxFrames then
          
          sprite.remove = true 
          
        else
          
          sprite.image  = sprite.listFrames[math.floor(sprite.frame)]
        end
        
      end
      
      if sprite.remove == true then
        
        table.remove(list_sprites, n)
      end 
    end 
    
    -- here gestion of the hero move
    if love.keyboard.isDown("right") and heros.x < screenWidth then
      
      heros.x = heros.x + 8
    end
    
    if love.keyboard.isDown("down") and heros.y < screenHeight then
      
      heros.y = heros.y + 8
    end
    
    if love.keyboard.isDown("left") and heros.x > 0  then
      
      heros.x = heros.x - 8
    end
    
    if love.keyboard.isDown("up") and heros.y > 0 then
      
      heros.y = heros.y - 8
    end
    
    
    -- gestion of the win 
    if win == true then
      
      timerWin = timerWin - 1
      if timerWin <= 0 then
      
      displayScreen = "Win"
      end
    end
end

-- call each frame (here 60 time per segond)
function love.update(dt)
  
  
  if displayScreen == "inGame" then
  
    updateGame()
    
  elseif displayScreen == "menu" then
  elseif displayScreen == "GameOver"then 
  end
end

-- this function can be call if we have a bugg and we want to fix it 
function drawDebugg()
  
  love.graphics.print("Number of shoots = "..#list_shoots.."  ".."Number of sprites = "..#list_sprites.."   ".."Number of aliens : "..#list_aliens.." ".."Life points :"..heros.life, 0, 0)
end



-- here we have all we want to diplay is for free love.draw
function drawGame()
  
  -- background
 love.graphics.draw(imgBackground, 0, 0, 0, 1.3, 1.2)
 

  
  
  
  
  --display level 
  local nbLines = #level
  local line, column
  local x, y
  
  x = 0 
  y = (0 - 64) + camera.y
  
  for line = nbLines, 1, -1 do 
    
    for column = 1, 16 do
      
      -- draw sprite
      local sprite = level[line][column]
      if sprite > 0 then
        
        love.graphics.draw(imgSprites[sprite], x, y, 0, 2, 2)
      end
      
      x = x + 64
    end 
    x = 0
    y = y - 64
  end 
  
  local n
  
  for n = 1, #list_sprites do
    
    local s = list_sprites[n]
    love.graphics.draw(s.image, s.x, s.y, 0, 2, 2, s.w / 2, s.h / 2)
  end 
  
  --call of the function drawDebugg
  --drawDebugg()
  
  
  -- hero life
 love.graphics.print(lifeText, 0, screenHeight - 30, 0, 2, 2)
 
end


-- draw the screen of menu 
function drawMenu()
  
  
  love.graphics.draw(imgMenu, 0, 0)
end


-- draw the screen of game over 
function  drawGameOver()
  
  love.graphics.draw(imgGameOver, 0, 0)
  love.graphics.print("press N to restart the game", screenWidth/ 2, screenHeight / 2, 0, 2, 1.5)
  
end


-- draw the screen of win 
function  drawWin()
  
  love.graphics.draw(imgWin, 0, 0)
  love.graphics.print("press N to restart the game", screenWidth/ 2, screenHeight / 2 + 100, 0, 2, 1.5)
end


-- for display thing on the screen (player, enemy , wallpaper, etc...)
function love.draw()
  
  if displayScreen == "inGame" then
    
    drawGame()
    
  elseif displayScreen == "menu" then
    
    drawMenu()
    
  elseif displayScreen == "gameOver" then
    
    drawGameOver()
  
  elseif displayScreen == "Win" then
    
    drawWin()
    
  end
  
  
  
end

-- tcheck all the key what whe pressed when the game is play 
function love.keypressed(key)
  
  
  -- tchek the key when the game is play 
  if displayScreen == "inGame" then
    if key == "space" then 
    
      CreateShoot("ally", "laser1", heros.x, heros.y - (heros.h * 2) / 2, 0, -10)
    end 
    
  
  -- tcheck the key when we are on the menu 
  elseif displayScreen == "menu" then
    if key == "space" then 
    
      displayScreen = "inGame"
      
    end 
    
    
  --tchek the key when we are on the game over screen 
  elseif displayScreen == "gameOver" then
    if key == "n" then
      
      
      GameEnd()
      GameStart()
      displayScreen = "menu"
    end
    
    
  elseif displayScreen == "Win" then
    if key == "n" then
      
      GameEnd()
      GameStart()
      displayScreen = "menu"
    end
  end
  
  -- quit the game if we use the key escape
  if key == "escape"then
    
    love.event.quit()
  end
end 
