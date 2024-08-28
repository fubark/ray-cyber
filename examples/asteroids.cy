-- Copyright (c) 2023 Cyber (See LICENSE)

-- Asteroids, a game ported from Raylib examples.
-- Original authors: Ian Eito, Albert Martos and Ramon Santamaria

use os
use math
--use rl 'https://github.com/fubark/ray-cyber'
use rl '../mod.cy'

-- Types and Structures Definition
type Player(position Vec2, speed Vec2, acceleration float,
    rotation float, collider Vec3, color rl.Color)

type Shoot(position Vec2, speed Vec2, radius float,
    rotation float, lifeSpawn int, active bool, color rl.Color)

type Meteor(position Vec2, speed Vec2, radius float, active bool, color rl.Color)

use Vec2 -> rl.Vector2
use Vec3 -> rl.Vector3

-- Global Variables Declaration
var .screenWidth = 800
var .screenHeight = 450

-- Some Constants
var .PLAYER_BASE_SIZE = 20.0
var .PLAYER_SPEED = 6.0
var .PLAYER_MAX_SHOOTS = 10

var .METEORS_SPEED = 2.0
var .MAX_BIG_METEORS = 4
var .MAX_MEDIUM_METEORS = 8
var .MAX_SMALL_METEORS = 16

var .gameOver = false
var .pause = false
var .victory = false

-- NOTE: Defined triangle is isosceles with common angles of 70 degrees.
var .shipHeight = 0.0

var .player = Player{}
var .shoot = List.fill(Shoot{}, PLAYER_MAX_SHOOTS as int)
var .bigMeteor = List.fill(Meteor{}, MAX_BIG_METEORS as int)
var .mediumMeteor = List.fill(Meteor{}, MAX_MEDIUM_METEORS as int)
var .smallMeteor = List.fill(Meteor{}, MAX_SMALL_METEORS as int)

var .midMeteorsCount = 0
var .smallMeteorsCount = 0
var .destroyedMeteorsCount = 0

-- Program main entry point
main()

func main():
    -- Initialization (Note windowTitle is unused on Android)
    rl.InitWindow(screenWidth, screenHeight, 'classic game: asteroids')
    InitGame()

    rl.SetTargetFPS(60)

    -- Main game loop
    -- Detect window close button or ESC key
    while !rl.WindowShouldClose():
        UpdateDrawFrame()
    
    -- De-Initialization
    UnloadGame()         -- Unload loaded data (textures, sounds, models...)
    rl.CloseWindow()    -- Close window and OpenGL context

-- Initialize game variables
func InitGame():
    var posx = 0.0
    var posy = 0.0
    var velx = 0.0
    var vely = 0.0
    var correctRange = false
    victory = false
    pause = false

    shipHeight = (PLAYER_BASE_SIZE/2.0)/math.tan(20*rl.DEG2RAD)

    -- Initialization player
    player.position = Vec2{x=float(screenWidth/2), y=float(screenHeight/2) - shipHeight/2.0}
    player.speed = Vec2{x=0, y=0}
    player.acceleration = 0.0
    player.rotation = 0.0
    player.collider = Vec3{
        x = player.position.x + math.sin(player.rotation*rl.DEG2RAD)*(shipHeight/2.5),
        y = player.position.y - math.cos(player.rotation*rl.DEG2RAD)*(shipHeight/2.5),
        z = 12,
    }
    player.color = rl.LIGHTGRAY

    destroyedMeteorsCount = 0

    -- Initialization shoot
    for 0..PLAYER_MAX_SHOOTS -> i:
        shoot[i].position = Vec2{x=0, y=0}
        shoot[i].speed = Vec2{x=0, y=0}
        shoot[i].radius = 2.0
        shoot[i].active = false
        shoot[i].lifeSpawn = 0
        shoot[i].color = rl.WHITE

    for 0..MAX_BIG_METEORS -> i:
        posx = float(rl.GetRandomValue(0, screenWidth))

        while !correctRange:
            if posx > float(screenWidth/2 - 150) and posx < float(screenWidth/2 + 150):
                posx = float(rl.GetRandomValue(0, screenWidth))
            else: correctRange = true

        correctRange = false

        posy = float(rl.GetRandomValue(0, screenHeight))

        while !correctRange:
            if posy > float(screenHeight/2 - 150) and posy < float(screenHeight/2 + 150):
                posy = float(rl.GetRandomValue(0, screenHeight))
            else: correctRange = true

        bigMeteor[i].position = Vec2{x=posx, y=posy}

        correctRange = false
        velx = float(rl.GetRandomValue(-int(METEORS_SPEED), int(METEORS_SPEED)))
        vely = float(rl.GetRandomValue(-int(METEORS_SPEED), int(METEORS_SPEED)))

        while !correctRange:
            if velx == 0.0 and vely == 0.0:
                velx = float(rl.GetRandomValue(-int(METEORS_SPEED), int(METEORS_SPEED)))
                vely = float(rl.GetRandomValue(-int(METEORS_SPEED), int(METEORS_SPEED)))
            else: correctRange = true

        bigMeteor[i].speed = Vec2{x=velx, y=vely}
        bigMeteor[i].radius = 40.0
        bigMeteor[i].active = true
        bigMeteor[i].color = rl.BLUE

    for 0..MAX_MEDIUM_METEORS -> i:
        mediumMeteor[i].position = Vec2{x=-100, y=-100}
        mediumMeteor[i].speed = Vec2{x=0, y=0}
        mediumMeteor[i].radius = 20.0
        mediumMeteor[i].active = false
        mediumMeteor[i].color = rl.BLUE

    for 0..MAX_SMALL_METEORS -> i:
        smallMeteor[i].position = Vec2{x=-100, y=-100}
        smallMeteor[i].speed = Vec2{x=0, y=0}
        smallMeteor[i].radius = 10.0
        smallMeteor[i].active = false
        smallMeteor[i].color = rl.BLUE

    midMeteorsCount = 0
    smallMeteorsCount = 0

-- Update game (one frame)
func UpdateGame():
    if gameOver:
        if rl.IsKeyPressed(rl.KEY_ENTER):
            InitGame()
            gameOver = false
        return

    if rl.IsKeyPressed(rl.KEY_P):
        pause = !pause

    if pause: return

    -- Player logic: rotation
    if rl.IsKeyDown(rl.KEY_LEFT): player.rotation -= 5.0
    if rl.IsKeyDown(rl.KEY_RIGHT): player.rotation += 5.0

    -- Player logic: speed
    player.speed.x = math.sin(player.rotation*rl.DEG2RAD)*PLAYER_SPEED
    player.speed.y = math.cos(player.rotation*rl.DEG2RAD)*PLAYER_SPEED

    -- Player logic: acceleration
    if rl.IsKeyDown(rl.KEY_UP):
        if player.acceleration < 1.0: player.acceleration += 0.04
    else:
        if player.acceleration > 0.0: player.acceleration -= 0.02
        else player.acceleration < 0.0: player.acceleration = 0.0

    if rl.IsKeyDown(rl.KEY_DOWN):
        if player.acceleration > 0.0: player.acceleration -= 0.04
        else player.acceleration < 0.0: player.acceleration = 0.0

    -- Player logic: movement
    player.position.x += player.speed.x*player.acceleration
    player.position.y -= player.speed.y*player.acceleration

    -- Collision logic: player vs walls
    if player.position.x > float(screenWidth) + shipHeight:
        player.position.x = -shipHeight
    else player.position.x < -shipHeight:
        player.position.x = float(screenWidth) + shipHeight
    if player.position.y > float(screenHeight) + shipHeight:
        player.position.y = -shipHeight
    else player.position.y < -shipHeight:
        player.position.y = float(screenHeight) + shipHeight

    -- Player shoot logic
    if rl.IsKeyPressed(rl.KEY_SPACE):
        for 0..PLAYER_MAX_SHOOTS -> i:
            if !shoot[i].active:
                shoot[i].position = Vec2{
                    x = player.position.x + math.sin(player.rotation*rl.DEG2RAD)*(shipHeight),
                    y = player.position.y - math.cos(player.rotation*rl.DEG2RAD)*(shipHeight),
                }
                shoot[i].active = true
                shoot[i].speed.x = 1.5*math.sin(player.rotation*rl.DEG2RAD)*PLAYER_SPEED
                shoot[i].speed.y = 1.5*math.cos(player.rotation*rl.DEG2RAD)*PLAYER_SPEED
                shoot[i].rotation = player.rotation
                break

    -- Shoot life timer
    for 0..PLAYER_MAX_SHOOTS -> i:
        if shoot[i].active: shoot[i].lifeSpawn += 1

    -- Shot logic
    for 0..PLAYER_MAX_SHOOTS -> i:
        if shoot[i].active:
            -- Movement
            shoot[i].position.x += shoot[i].speed.x
            shoot[i].position.y -= shoot[i].speed.y

            -- Collision logic: shoot vs walls
            if shoot[i].position.x > float(screenWidth) + shoot[i].radius:
                shoot[i].active = false
                shoot[i].lifeSpawn = 0
            else shoot[i].position.x < -shoot[i].radius:
                shoot[i].active = false
                shoot[i].lifeSpawn = 0
            if shoot[i].position.y > float(screenHeight) + shoot[i].radius:
                shoot[i].active = false
                shoot[i].lifeSpawn = 0
            else shoot[i].position.y < -shoot[i].radius:
                shoot[i].active = false
                shoot[i].lifeSpawn = 0

            -- Life of shoot
            if shoot[i].lifeSpawn >= 60:
                shoot[i].position = Vec2{x=0, y=0}
                shoot[i].speed = Vec2{x=0, y=0}
                shoot[i].lifeSpawn = 0
                shoot[i].active = false

    -- Collision logic: player vs meteors
    player.collider = Vec3{
        x = player.position.x + math.sin(player.rotation*rl.DEG2RAD)*(shipHeight/2.5),
        y = player.position.y - math.cos(player.rotation*rl.DEG2RAD)*(shipHeight/2.5),
        z = 12,
    }

    for 0..MAX_BIG_METEORS -> a:
        var meteor = bigMeteor[a]
        if rl.CheckCollisionCircles(
            Vec2{x=player.collider.x, y=player.collider.y}, player.collider.z,
            meteor.position, meteor.radius) and meteor.active:
            gameOver = true

    for 0..MAX_MEDIUM_METEORS -> a:
        var meteor = mediumMeteor[a]
        if rl.CheckCollisionCircles(
            Vec2{x=player.collider.x, y=player.collider.y}, player.collider.z,
            meteor.position, meteor.radius) and meteor.active:
            gameOver = true

    for 0..MAX_SMALL_METEORS -> a:
        var meteor = smallMeteor[a]
        if rl.CheckCollisionCircles(
            Vec2{x=player.collider.x, y=player.collider.y}, player.collider.z,
            meteor.position, meteor.radius) and meteor.active:
            gameOver = true

    -- Meteors logic: big meteors
    for 0..MAX_BIG_METEORS -> i:
        if bigMeteor[i].active:
            -- Movement
            bigMeteor[i].position.x += bigMeteor[i].speed.x
            bigMeteor[i].position.y += bigMeteor[i].speed.y

            -- Collision logic: meteor vs wall
            if bigMeteor[i].position.x > float(screenWidth) + bigMeteor[i].radius:
                bigMeteor[i].position.x = -(bigMeteor[i].radius)
            else bigMeteor[i].position.x < -bigMeteor[i].radius: 
                bigMeteor[i].position.x = float(screenWidth) + bigMeteor[i].radius
            if bigMeteor[i].position.y > float(screenHeight) + bigMeteor[i].radius:
                bigMeteor[i].position.y = -(bigMeteor[i].radius)
            else bigMeteor[i].position.y < -bigMeteor[i].radius:
                bigMeteor[i].position.y = float(screenHeight) + bigMeteor[i].radius

    -- Meteors logic: medium meteors
    for 0..MAX_MEDIUM_METEORS -> i:
        if mediumMeteor[i].active:
            -- Movement
            mediumMeteor[i].position.x += mediumMeteor[i].speed.x
            mediumMeteor[i].position.y += mediumMeteor[i].speed.y

            -- Collision logic: meteor vs wall
            if mediumMeteor[i].position.x > float(screenWidth) + mediumMeteor[i].radius:
                mediumMeteor[i].position.x = -(mediumMeteor[i].radius)
            else mediumMeteor[i].position.x < -mediumMeteor[i].radius:
                mediumMeteor[i].position.x = float(screenWidth) + mediumMeteor[i].radius
            if mediumMeteor[i].position.y > float(screenHeight) + mediumMeteor[i].radius:
                mediumMeteor[i].position.y = -(mediumMeteor[i].radius)
            else mediumMeteor[i].position.y < -mediumMeteor[i].radius:
                mediumMeteor[i].position.y = float(screenHeight) + mediumMeteor[i].radius

    -- Meteors logic: small meteors
    for 0..MAX_SMALL_METEORS -> i:
        if smallMeteor[i].active:
            -- Movement
            smallMeteor[i].position.x += smallMeteor[i].speed.x
            smallMeteor[i].position.y += smallMeteor[i].speed.y

            -- Collision logic: meteor vs wall
            if smallMeteor[i].position.x > float(screenWidth) + smallMeteor[i].radius:
                smallMeteor[i].position.x = -(smallMeteor[i].radius)
            else smallMeteor[i].position.x < -smallMeteor[i].radius:
                smallMeteor[i].position.x = float(screenWidth) + smallMeteor[i].radius
            if smallMeteor[i].position.y > float(screenHeight) + smallMeteor[i].radius:
                smallMeteor[i].position.y = -(smallMeteor[i].radius)
            else smallMeteor[i].position.y < -smallMeteor[i].radius:
                smallMeteor[i].position.y = float(screenHeight) + smallMeteor[i].radius

    -- Collision logic: player-shoots vs meteors
    for 0..PLAYER_MAX_SHOOTS -> i:
        var shooti = shoot[i]
        if shooti.active:
            for 0..MAX_BIG_METEORS -> a:
                var meteor = bigMeteor[a]
                if meteor.active and rl.CheckCollisionCircles(shooti.position, shooti.radius, meteor.position, meteor.radius):
                    shooti.active = false
                    shooti.lifeSpawn = 0
                    meteor.active = false
                    destroyedMeteorsCount += 1

                    for 0..2 -> j:
                        if midMeteorsCount%2 == 0:
                            mediumMeteor[midMeteorsCount].position = Vec2{
                                x = meteor.position.x, y = meteor.position.y
                            }
                            mediumMeteor[midMeteorsCount].speed = Vec2{
                                x = math.cos(shooti.rotation*rl.DEG2RAD)*METEORS_SPEED*-1,
                                y = math.sin(shooti.rotation*rl.DEG2RAD)*METEORS_SPEED*-1,
                            }
                        else:
                            mediumMeteor[midMeteorsCount].position = Vec2{
                                x = meteor.position.x, y = meteor.position.y
                            }
                            mediumMeteor[midMeteorsCount].speed = Vec2{
                                x = math.cos(shooti.rotation*rl.DEG2RAD)*METEORS_SPEED,
                                y = math.sin(shooti.rotation*rl.DEG2RAD)*METEORS_SPEED
                            }

                        mediumMeteor[midMeteorsCount].active = true
                        midMeteorsCount += 1
                    --bigMeteor[a].position = Vec2{x=-100, y=-100}
                    meteor.color = rl.RED
                    break

            for 0..MAX_MEDIUM_METEORS -> b:
                var meteor = mediumMeteor[b]
                if meteor.active and rl.CheckCollisionCircles(shooti.position, shooti.radius, meteor.position, meteor.radius):
                    shooti.active = false
                    shooti.lifeSpawn = 0
                    meteor.active = false
                    destroyedMeteorsCount += 1

                    for 0..2 -> j:
                        if smallMeteorsCount%2 == 0:
                            smallMeteor[smallMeteorsCount].position = Vec2{
                                x = meteor.position.x, y = meteor.position.y
                            }
                            smallMeteor[smallMeteorsCount].speed = Vec2{
                                x = math.cos(shooti.rotation*rl.DEG2RAD)*METEORS_SPEED*-1,
                                y = math.sin(shooti.rotation*rl.DEG2RAD)*METEORS_SPEED*-1,
                            }
                        else:
                            smallMeteor[smallMeteorsCount].position = Vec2{
                                x = meteor.position.x, y = meteor.position.y
                            }
                            smallMeteor[smallMeteorsCount].speed = Vec2{
                                x = math.cos(shooti.rotation*rl.DEG2RAD)*METEORS_SPEED,
                                y = math.sin(shooti.rotation*rl.DEG2RAD)*METEORS_SPEED
                            }

                        smallMeteor[smallMeteorsCount].active = true
                        smallMeteorsCount += 1
                    --mediumMeteor[b].position = Vec2{x=-100, y=-100}
                    meteor.color = rl.GREEN
                    break

            for 0..MAX_SMALL_METEORS -> c:
                var meteor = smallMeteor[c]
                if meteor.active and rl.CheckCollisionCircles(shooti.position, shooti.radius, meteor.position, meteor.radius):
                    shooti.active = false
                    shooti.lifeSpawn = 0
                    meteor.active = false
                    destroyedMeteorsCount += 1
                    meteor.color = rl.YELLOW
                    -- smallMeteor[c].position = Vec2{x=-100, y=-100}
                    break

    if destroyedMeteorsCount == MAX_BIG_METEORS + MAX_MEDIUM_METEORS + MAX_SMALL_METEORS:
        victory = true

-- Draw game (one frame)
func DrawGame():
    rl.BeginDrawing()
    rl.ClearBackground(rl.RAYWHITE)

    if !gameOver:
        -- Draw spaceship
        var v1 = Vec2{
            x = player.position.x + math.sin(player.rotation*rl.DEG2RAD)*(shipHeight),
            y = player.position.y - math.cos(player.rotation*rl.DEG2RAD)*(shipHeight),
        }
        var v2 = Vec2{
            x = player.position.x - math.cos(player.rotation*rl.DEG2RAD)*(PLAYER_BASE_SIZE/2.0),
            y = player.position.y - math.sin(player.rotation*rl.DEG2RAD)*(PLAYER_BASE_SIZE/2.0),
        }
        var v3 = Vec2{
            x = player.position.x + math.cos(player.rotation*rl.DEG2RAD)*(PLAYER_BASE_SIZE/2.0),
            y = player.position.y + math.sin(player.rotation*rl.DEG2RAD)*(PLAYER_BASE_SIZE/2.0),
        }
        rl.DrawTriangle(v1, v2, v3, rl.MAROON)

        -- Draw meteors
        for 0..MAX_BIG_METEORS -> i:
            var meteor = bigMeteor[i]
            if meteor.active:
                rl.DrawCircleV(meteor.position, meteor.radius, rl.DARKGRAY)
            else:
                rl.DrawCircleV(meteor.position, meteor.radius, rl.Fade(rl.LIGHTGRAY, 0.3))

        for 0..MAX_MEDIUM_METEORS -> i:
            var meteor = mediumMeteor[i]
            if meteor.active:
                rl.DrawCircleV(meteor.position, meteor.radius, rl.GRAY)
            else:
                rl.DrawCircleV(meteor.position, meteor.radius, rl.Fade(rl.LIGHTGRAY, 0.3))

        for 0..MAX_SMALL_METEORS -> i:
            var meteor = smallMeteor[i]
            if meteor.active:
                rl.DrawCircleV(meteor.position, meteor.radius, rl.GRAY)
            else:
                rl.DrawCircleV(meteor.position, meteor.radius, rl.Fade(rl.LIGHTGRAY, 0.3))

        -- Draw shoot
        for 0..PLAYER_MAX_SHOOTS -> i:
            var shooti = shoot[i]
            if shooti.active:
                rl.DrawCircleV(shooti.position, shooti.radius, rl.BLACK)

        if victory:
            rl.DrawText('VICTORY', screenWidth/2 - rl.MeasureText('VICTORY', 20)/2, screenHeight/2, 20, rl.LIGHTGRAY)

        if pause:
            rl.DrawText('GAME PAUSED', screenWidth/2 - rl.MeasureText('GAME PAUSED', 40)/2, screenHeight/2 - 40, 40, rl.GRAY)
    else: rl.DrawText('PRESS [ENTER] TO PLAY AGAIN', rl.GetScreenWidth()/2 - rl.MeasureText('PRESS [ENTER] TO PLAY AGAIN', 20)/2, rl.GetScreenHeight()/2 - 50, 20, rl.GRAY)

    rl.EndDrawing()

-- Unload game variables
func UnloadGame():
    -- TODO: Unload all dynamic loaded data (textures, sounds, models...)
    pass

-- Update and Draw (one frame)
func UpdateDrawFrame():
    UpdateGame()
    DrawGame()
