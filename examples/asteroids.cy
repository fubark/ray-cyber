-- Copyright (c) 2023 Cyber (See LICENSE)

-- Asteroids, a game ported from Raylib examples.
-- Original authors: Ian Eito, Albert Martos and Ramon Santamaria

import os
import math
--import ray 'https://github.com/fubark/ray-cyber'
import ray '../mod.cy'

-- Types and Structures Definition
type Player object:
    my position
    my speed
    my acceleration
    my rotation
    my collider
    my color

type Shoot object:
    my position
    my speed
    my radius
    my rotation
    my lifeSpawn
    my active
    my color

type Meteor object:
    my position
    my speed
    my radius
    my active
    my color

type Vec2 ray.Vector2
type Vec3 ray.Vector3

-- Global Variables Declaration
my Root.screenWidth = 800
my Root.screenHeight = 450

-- Some Constants
my Root.PLAYER_BASE_SIZE = 20.0
my Root.PLAYER_SPEED = 6.0
my Root.PLAYER_MAX_SHOOTS = 10

my Root.METEORS_SPEED = 2.0
my Root.MAX_BIG_METEORS = 4
my Root.MAX_MEDIUM_METEORS = 8
my Root.MAX_SMALL_METEORS = 16

my Root.gameOver = false
my Root.pause = false
my Root.victory = false

-- NOTE: Defined triangle is isosceles with common angles of 70 degrees.
my Root.shipHeight = 0.0

my Root.player = [Player:]
my Root.shoot = List.fill([Shoot:], PLAYER_MAX_SHOOTS)
my Root.bigMeteor = List.fill([Meteor:], MAX_BIG_METEORS)
my Root.mediumMeteor = List.fill([Meteor:], MAX_MEDIUM_METEORS)
my Root.smallMeteor = List.fill([Meteor:], MAX_SMALL_METEORS)

my Root.midMeteorsCount = 0
my Root.smallMeteorsCount = 0
my Root.destroyedMeteorsCount = 0

-- Program main entry point
main()

func main():
    -- Initialization (Note windowTitle is unused on Android)
    ray.InitWindow(screenWidth, screenHeight, 'classic game: asteroids')
    InitGame()

    ray.SetTargetFPS(60)

    -- Main game loop
    -- Detect window close button or ESC key
    while !ray.WindowShouldClose():
        UpdateDrawFrame()
    
    -- De-Initialization
    UnloadGame()         -- Unload loaded data (textures, sounds, models...)
    ray.CloseWindow()    -- Close window and OpenGL context

-- Initialize game variables
func InitGame():
    my posx = 0.0
    my posy = 0.0
    my velx = 0.0
    my vely = 0.0
    my correctRange = false
    victory = false
    pause = false

    shipHeight = (PLAYER_BASE_SIZE/2.0)/math.tan(20*ray.DEG2RAD)

    -- Initialization player
    player.position = [Vec2 x: float(screenWidth/2), y: float(screenHeight/2) - shipHeight/2.0]
    player.speed = [Vec2 x: 0, y: 0]
    player.acceleration = 0.0
    player.rotation = 0.0
    player.collider = [Vec3
        x: player.position.x + math.sin(player.rotation*ray.DEG2RAD)*(shipHeight/2.5),
        y: player.position.y - math.cos(player.rotation*ray.DEG2RAD)*(shipHeight/2.5),
        z: 12,
    ]
    player.color = ray.LIGHTGRAY

    destroyedMeteorsCount = 0

    -- Initialization shoot
    for 0..PLAYER_MAX_SHOOTS -> i:
        shoot[i].position = [Vec2 x: 0, y: 0]
        shoot[i].speed = [Vec2 x: 0, y: 0]
        shoot[i].radius = 2.0
        shoot[i].active = false
        shoot[i].lifeSpawn = 0
        shoot[i].color = ray.WHITE

    for 0..MAX_BIG_METEORS -> i:
        posx = float(ray.GetRandomValue(0, screenWidth))

        while !correctRange:
            if posx > float(screenWidth/2 - 150) and posx < float(screenWidth/2 + 150):
                posx = float(ray.GetRandomValue(0, screenWidth))
            else: correctRange = true

        correctRange = false

        posy = float(ray.GetRandomValue(0, screenHeight))

        while !correctRange:
            if posy > float(screenHeight/2 - 150) and posy < float(screenHeight/2 + 150):
                posy = float(ray.GetRandomValue(0, screenHeight))
            else: correctRange = true

        bigMeteor[i].position = [Vec2 x: posx, y: posy]

        correctRange = false
        velx = float(ray.GetRandomValue(-int(METEORS_SPEED), int(METEORS_SPEED)))
        vely = float(ray.GetRandomValue(-int(METEORS_SPEED), int(METEORS_SPEED)))

        while !correctRange:
            if velx == 0.0 and vely == 0.0:
                velx = float(ray.GetRandomValue(-int(METEORS_SPEED), int(METEORS_SPEED)))
                vely = float(ray.GetRandomValue(-int(METEORS_SPEED), int(METEORS_SPEED)))
            else: correctRange = true

        bigMeteor[i].speed = [Vec2 x: velx, y: vely]
        bigMeteor[i].radius = 40.0
        bigMeteor[i].active = true
        bigMeteor[i].color = ray.BLUE

    for 0..MAX_MEDIUM_METEORS -> i:
        mediumMeteor[i].position = [Vec2 x: -100, y: -100]
        mediumMeteor[i].speed = [Vec2 x: 0, y: 0]
        mediumMeteor[i].radius = 20.0
        mediumMeteor[i].active = false
        mediumMeteor[i].color = ray.BLUE

    for 0..MAX_SMALL_METEORS -> i:
        smallMeteor[i].position = [Vec2 x: -100, y: -100]
        smallMeteor[i].speed = [Vec2 x: 0, y: 0]
        smallMeteor[i].radius = 10.0
        smallMeteor[i].active = false
        smallMeteor[i].color = ray.BLUE

    midMeteorsCount = 0
    smallMeteorsCount = 0

-- Update game (one frame)
func UpdateGame():
    if gameOver:
        if ray.IsKeyPressed(ray.KEY_ENTER):
            InitGame()
            gameOver = false
        return

    if ray.IsKeyPressed(ray.KEY_P):
        pause = !pause

    if pause: return

    -- Player logic: rotation
    if ray.IsKeyDown(ray.KEY_LEFT): player.rotation -= 5.0
    if ray.IsKeyDown(ray.KEY_RIGHT): player.rotation += 5.0

    -- Player logic: speed
    player.speed.x = math.sin(player.rotation*ray.DEG2RAD)*PLAYER_SPEED
    player.speed.y = math.cos(player.rotation*ray.DEG2RAD)*PLAYER_SPEED

    -- Player logic: acceleration
    if ray.IsKeyDown(ray.KEY_UP):
        if player.acceleration < 1.0: player.acceleration += 0.04
    else:
        if player.acceleration > 0.0: player.acceleration -= 0.02
        else player.acceleration < 0.0: player.acceleration = 0.0

    if ray.IsKeyDown(ray.KEY_DOWN):
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
    if ray.IsKeyPressed(ray.KEY_SPACE):
        for 0..PLAYER_MAX_SHOOTS -> i:
            if !shoot[i].active:
                shoot[i].position = [Vec2
                    x: player.position.x + math.sin(player.rotation*ray.DEG2RAD)*(shipHeight),
                    y: player.position.y - math.cos(player.rotation*ray.DEG2RAD)*(shipHeight),
                ]
                shoot[i].active = true
                shoot[i].speed.x = 1.5*math.sin(player.rotation*ray.DEG2RAD)*PLAYER_SPEED
                shoot[i].speed.y = 1.5*math.cos(player.rotation*ray.DEG2RAD)*PLAYER_SPEED
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
                shoot[i].position = [Vec2 x: 0, y: 0]
                shoot[i].speed = [Vec2 x: 0, y: 0]
                shoot[i].lifeSpawn = 0
                shoot[i].active = false

    -- Collision logic: player vs meteors
    player.collider = [Vec3
        x: player.position.x + math.sin(player.rotation*ray.DEG2RAD)*(shipHeight/2.5),
        y: player.position.y - math.cos(player.rotation*ray.DEG2RAD)*(shipHeight/2.5),
        z: 12,
    ]

    for 0..MAX_BIG_METEORS -> a:
        my meteor = bigMeteor[a]
        if ray.CheckCollisionCircles(
            [Vec2 x: player.collider.x, y: player.collider.y], player.collider.z,
            meteor.position, meteor.radius) and meteor.active:
            gameOver = true

    for 0..MAX_MEDIUM_METEORS -> a:
        my meteor = mediumMeteor[a]
        if ray.CheckCollisionCircles(
            [Vec2 x: player.collider.x, y: player.collider.y], player.collider.z,
            meteor.position, meteor.radius) and meteor.active:
            gameOver = true

    for 0..MAX_SMALL_METEORS -> a:
        my meteor = smallMeteor[a]
        if ray.CheckCollisionCircles(
            [Vec2 x: player.collider.x, y: player.collider.y], player.collider.z,
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
        my shooti = shoot[i]
        if shooti.active:
            for 0..MAX_BIG_METEORS -> a:
                my meteor = bigMeteor[a]
                if meteor.active and ray.CheckCollisionCircles(shooti.position, shooti.radius, meteor.position, meteor.radius):
                    shooti.active = false
                    shooti.lifeSpawn = 0
                    meteor.active = false
                    destroyedMeteorsCount += 1

                    for 0..2 -> j:
                        if midMeteorsCount%2 == 0:
                            mediumMeteor[midMeteorsCount].position = [Vec2
                                x: meteor.position.x, y: meteor.position.y
                            ]
                            mediumMeteor[midMeteorsCount].speed = [Vec2
                                x: math.cos(shooti.rotation*ray.DEG2RAD)*METEORS_SPEED*-1,
                                y: math.sin(shooti.rotation*ray.DEG2RAD)*METEORS_SPEED*-1,
                            ]
                        else:
                            mediumMeteor[midMeteorsCount].position = [Vec2
                                x: meteor.position.x, y: meteor.position.y
                            ]
                            mediumMeteor[midMeteorsCount].speed = [Vec2
                                x: math.cos(shooti.rotation*ray.DEG2RAD)*METEORS_SPEED,
                                y: math.sin(shooti.rotation*ray.DEG2RAD)*METEORS_SPEED
                            ]

                        mediumMeteor[midMeteorsCount].active = true
                        midMeteorsCount += 1
                    --bigMeteor[a].position = [Vec2 x: -100, y: -100]
                    meteor.color = ray.RED
                    break

            for 0..MAX_MEDIUM_METEORS -> b:
                my meteor = mediumMeteor[b]
                if meteor.active and ray.CheckCollisionCircles(shooti.position, shooti.radius, meteor.position, meteor.radius):
                    shooti.active = false
                    shooti.lifeSpawn = 0
                    meteor.active = false
                    destroyedMeteorsCount += 1

                    for 0..2 -> j:
                        if smallMeteorsCount%2 == 0:
                            smallMeteor[smallMeteorsCount].position = [Vec2
                                x: meteor.position.x, y: meteor.position.y
                            ]
                            smallMeteor[smallMeteorsCount].speed = [Vec2
                                x: math.cos(shooti.rotation*ray.DEG2RAD)*METEORS_SPEED*-1,
                                y: math.sin(shooti.rotation*ray.DEG2RAD)*METEORS_SPEED*-1,
                            ]
                        else:
                            smallMeteor[smallMeteorsCount].position = [Vec2
                                x: meteor.position.x, y: meteor.position.y
                            ]
                            smallMeteor[smallMeteorsCount].speed = [Vec2
                                x: math.cos(shooti.rotation*ray.DEG2RAD)*METEORS_SPEED,
                                y: math.sin(shooti.rotation*ray.DEG2RAD)*METEORS_SPEED
                            ]

                        smallMeteor[smallMeteorsCount].active = true
                        smallMeteorsCount += 1
                    --mediumMeteor[b].position = [Vec2 x: -100, y: -100];
                    meteor.color = ray.GREEN
                    break

            for 0..MAX_SMALL_METEORS -> c:
                my meteor = smallMeteor[c]
                if meteor.active and ray.CheckCollisionCircles(shooti.position, shooti.radius, meteor.position, meteor.radius):
                    shooti.active = false
                    shooti.lifeSpawn = 0
                    meteor.active = false
                    destroyedMeteorsCount += 1
                    meteor.color = ray.YELLOW
                    -- smallMeteor[c].position = [Vec2 x: -100, y:-100]
                    break

    if destroyedMeteorsCount == MAX_BIG_METEORS + MAX_MEDIUM_METEORS + MAX_SMALL_METEORS:
        victory = true

-- Draw game (one frame)
func DrawGame():
    ray.BeginDrawing()
    ray.ClearBackground(ray.RAYWHITE)

    if !gameOver:
        -- Draw spaceship
        my v1 = [Vec2
            x: player.position.x + math.sin(player.rotation*ray.DEG2RAD)*(shipHeight),
            y: player.position.y - math.cos(player.rotation*ray.DEG2RAD)*(shipHeight),
        ]
        my v2 = [Vec2
            x: player.position.x - math.cos(player.rotation*ray.DEG2RAD)*(PLAYER_BASE_SIZE/2.0),
            y: player.position.y - math.sin(player.rotation*ray.DEG2RAD)*(PLAYER_BASE_SIZE/2.0),
        ]
        my v3 = [Vec2
            x: player.position.x + math.cos(player.rotation*ray.DEG2RAD)*(PLAYER_BASE_SIZE/2.0),
            y: player.position.y + math.sin(player.rotation*ray.DEG2RAD)*(PLAYER_BASE_SIZE/2.0),
        ]
        ray.DrawTriangle(v1, v2, v3, ray.MAROON)

        -- Draw meteors
        for 0..MAX_BIG_METEORS -> i:
            my meteor = bigMeteor[i]
            if meteor.active:
                ray.DrawCircleV(meteor.position, meteor.radius, ray.DARKGRAY)
            else:
                ray.DrawCircleV(meteor.position, meteor.radius, ray.Fade(ray.LIGHTGRAY, 0.3))

        for 0..MAX_MEDIUM_METEORS -> i:
            my meteor = mediumMeteor[i]
            if meteor.active:
                ray.DrawCircleV(meteor.position, meteor.radius, ray.GRAY)
            else:
                ray.DrawCircleV(meteor.position, meteor.radius, ray.Fade(ray.LIGHTGRAY, 0.3))

        for 0..MAX_SMALL_METEORS -> i:
            my meteor = smallMeteor[i]
            if meteor.active:
                ray.DrawCircleV(meteor.position, meteor.radius, ray.GRAY)
            else:
                ray.DrawCircleV(meteor.position, meteor.radius, ray.Fade(ray.LIGHTGRAY, 0.3))

        -- Draw shoot
        for 0..PLAYER_MAX_SHOOTS -> i:
            my shooti = shoot[i]
            if shooti.active:
                ray.DrawCircleV(shooti.position, shooti.radius, ray.BLACK)

        if victory:
            ray.DrawText('VICTORY', screenWidth/2 - ray.MeasureText('VICTORY', 20)/2, screenHeight/2, 20, ray.LIGHTGRAY)

        if pause:
            ray.DrawText('GAME PAUSED', screenWidth/2 - ray.MeasureText('GAME PAUSED', 40)/2, screenHeight/2 - 40, 40, ray.GRAY)
    else: ray.DrawText('PRESS [ENTER] TO PLAY AGAIN', ray.GetScreenWidth()/2 - ray.MeasureText('PRESS [ENTER] TO PLAY AGAIN', 20)/2, ray.GetScreenHeight()/2 - 50, 20, ray.GRAY)

    ray.EndDrawing()

-- Unload game variables
func UnloadGame():
    -- TODO: Unload all dynamic loaded data (textures, sounds, models...)
    pass

-- Update and Draw (one frame)
func UpdateDrawFrame():
    UpdateGame()
    DrawGame()
