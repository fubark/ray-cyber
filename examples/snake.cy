-- Copyright (c) 2023 Cyber (See LICENSE)

-- Snake, a game ported from Raylib examples.

import os 'os'
--import ray 'https://github.com/fubark/ray-cyber'
import ray '../mod.cy'

my Root.SNAKE_LENGTH = 256
my Root.SQUARE_SIZE = 31

type Vec2 ray.Vector2

type Snake object:
    my pos
    my size
    my speed
    my color

type Food object:
    my pos
    my size
    my active
    my color

my Root.screenWidth = 800
my Root.screenHeight = 450

my Root.framesCounter = 0
my Root.gameOver = false
my Root.pause = false

my Root.fruit = [Food:]
my Root.snake = arrayFill([Snake:], SNAKE_LENGTH)
my Root.snakePosition = arrayFill([Vec2:], SNAKE_LENGTH)
my Root.allowMove = false
my Root.offset = [Vec2 x: 0, y: 0]
my Root.counterTail = 0

func main():
    ray.InitWindow(screenWidth, screenHeight, 'classic game: snake')
    InitGame()
    ray.SetTargetFPS(60)

    -- Main game loop
    while !ray.WindowShouldClose():  -- Detect window close button or ESC key
        UpdateGame()
        DrawGame()

    UnloadGame()    -- Unload loaded data (textures, sounds, models...)
    ray.CloseWindow()   -- Close window and OpenGL context

main()

-- Initialize game variables
func InitGame():
    framesCounter = 0
    gameOver = false
    pause = false

    counterTail = 1
    allowMove = false

    offset.x = float(screenWidth % SQUARE_SIZE)
    offset.y = float(screenHeight % SQUARE_SIZE)

    for 0..SNAKE_LENGTH -> i:
        snake[i].pos = [Vec2 x: offset.x/2.0, y: offset.y/2.0]
        snake[i].size = [Vec2 x: float(SQUARE_SIZE), y: float(SQUARE_SIZE)]
        snake[i].speed = [Vec2 x: float(SQUARE_SIZE), y: 0]

        if i == 0:
            snake[i].color = ray.DARKBLUE
        else:
            snake[i].color = ray.BLUE

    for 0..SNAKE_LENGTH -> i:
        snakePosition[i] = [Vec2 x: 0, y: 0]

    fruit.size = [Vec2 x: float(SQUARE_SIZE), y: float(SQUARE_SIZE)]
    fruit.color = ray.SKYBLUE
    fruit.active = false

func UpdateGame():
    if !gameOver:
        if ray.IsKeyPressed(0u'P'):
            pause = !pause

        if !pause:
            -- Player control
            if ray.IsKeyPressed(ray.KEY_RIGHT) and snake[0].speed.x == 0.0 and allowMove:
                snake[0].speed = [Vec2 x: float(SQUARE_SIZE), y: 0]
                allowMove = false
            if ray.IsKeyPressed(ray.KEY_LEFT) and snake[0].speed.x == 0.0 and allowMove:
                snake[0].speed = [Vec2 x: float(-SQUARE_SIZE), y: 0]
                allowMove = false
            if ray.IsKeyPressed(ray.KEY_UP) and snake[0].speed.y == 0.0 and allowMove:
                snake[0].speed = [Vec2 x: 0, y: float(-SQUARE_SIZE)]
                allowMove = false
            if ray.IsKeyPressed(ray.KEY_DOWN) and snake[0].speed.y == 0.0 and allowMove:
                snake[0].speed = [Vec2 x: 0, y: float(SQUARE_SIZE)]
                allowMove = false

            -- Snake movement
            for 0..counterTail -> i:
                snakePosition[i] = copy(snake[i].pos)

            if framesCounter % 5 == 0:
                for 0..counterTail -> i:
                    if i == 0:
                        snake[0].pos.x += snake[0].speed.x
                        snake[0].pos.y += snake[0].speed.y
                        allowMove = true
                    else:
                        snake[i].pos = copy(snakePosition[i-1])

            -- Wall behaviour
            if snake[0].pos.x > float(screenWidth) - offset.x or
                snake[0].pos.y > float(screenHeight) - offset.y or
                snake[0].pos.x < 0.0 or snake[0].pos.y < 0.0:
                gameOver = true

            -- Collision with yourself
            for 1..counterTail -> i:
                if snake[0].pos.x == snake[i].pos.x and
                    snake[0].pos.y == snake[i].pos.y:
                    gameOver = true

            -- Fruit position calculation
            if !fruit.active:
                fruit.active = true
                fruit.pos = [Vec2
                    x: float(ray.GetRandomValue(0, screenWidth/SQUARE_SIZE - 1) * SQUARE_SIZE) + offset.x/2.0,
                    y: float(ray.GetRandomValue(0, screenHeight/SQUARE_SIZE - 1) * SQUARE_SIZE) + offset.y/2.0,
                ]

                while:
                    fruit.pos = [Vec2
                        x: float(ray.GetRandomValue(0, screenWidth/SQUARE_SIZE - 1) * SQUARE_SIZE) + offset.x/2.0,
                        y: float(ray.GetRandomValue(0, screenHeight/SQUARE_SIZE - 1) * SQUARE_SIZE) + offset.y/2.0,
                    ]
                    my hit = false
                    for 0..counterTail -> i:
                        if fruit.pos.x == snake[i].pos.x and fruit.pos.y == snake[i].pos.y:
                            hit = true
                            break
                    if !hit:
                        break

            -- Collision
            if snake[0].pos.x < fruit.pos.x + fruit.size.x and
                snake[0].pos.x + snake[0].size.x > fruit.pos.x and 
                snake[0].pos.y < fruit.pos.y + fruit.size.y and
                snake[0].pos.y + snake[0].size.y > fruit.pos.y:
                snake[counterTail].pos = copy(snakePosition[counterTail - 1])
                counterTail += 1
                fruit.active = false

            framesCounter += 1

    else:
        if ray.IsKeyPressed(ray.KEY_ENTER):
            InitGame()
            gameOver = false

func DrawGame():
    ray.BeginDrawing()
    ray.ClearBackground(ray.RAYWHITE)

    if !gameOver:
        -- Draw grid lines
        for 0..screenWidth/SQUARE_SIZE + 1 -> i:
            ray.DrawLine(
                SQUARE_SIZE*i + int(offset.x/2.0), int(offset.y/2.0),
                SQUARE_SIZE*i + int(offset.x/2.0), screenHeight - int(offset.y/2.0), ray.LIGHTGRAY)

        for 0..screenHeight/SQUARE_SIZE + 1 -> i:
            ray.DrawLine(
                int(offset.x/2.0), SQUARE_SIZE*i + int(offset.y/2.0),
                screenWidth - int(offset.x/2.0), SQUARE_SIZE*i + int(offset.y/2.0), ray.LIGHTGRAY)

        -- Draw snake
        for 0..counterTail -> i:
            my snakei = snake[i]
            ray.DrawRectangleV(snakei.pos, snakei.size, snakei.color)

        -- Draw fruit to pick
        ray.DrawRectangleV(fruit.pos, fruit.size, fruit.color)

        if pause:
            ray.DrawText('GAME PAUSED', screenWidth/2 - ray.MeasureText('GAME PAUSED', 40)/2, screenHeight/2 - 40, 40, ray.GRAY)
    else:
        ray.DrawText('PRESS [ENTER] TO PLAY AGAIN', ray.GetScreenWidth()/2 - ray.MeasureText('PRESS [ENTER] TO PLAY AGAIN', 20)/2, ray.GetScreenHeight()/2 - 50, 20, ray.GRAY)

    ray.EndDrawing()

func UnloadGame():
    -- TODO: Unload all dynamic loaded data (textures, sounds, models...)
    pass
