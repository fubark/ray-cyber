-- Copyright (c) 2023 Cyber (See LICENSE)

-- Snake, a game ported from Raylib examples.

use os
--use rl 'https://github.com/fubark/ray-cyber'
use rl '../mod.cy'
use Vec2 -> rl.Vector2

let .SNAKE_LENGTH = 256
let .SQUARE_SIZE = 31

let Snake{pos, size, speed, color}
let Food{pos, size, active, color}

let .screenWidth = 800
let .screenHeight = 450

let .framesCounter = 0
let .gameOver = false
let .pause = false

let .fruit = Food{}
let .snake = List.fill(Snake{}, SNAKE_LENGTH)
let .snakePosition = List.fill(Vec2{}, SNAKE_LENGTH)
let .allowMove = false
let .offset = Vec2{x: 0, y: 0}
let .counterTail = 0

-- Invoke main.
main()

let main():
    rl.InitWindow(screenWidth, screenHeight, 'classic game: snake')
    InitGame()
    rl.SetTargetFPS(60)

    -- Main game loop
    -- Detect window close button or ESC key
    while !rl.WindowShouldClose(): 
        UpdateGame()
        DrawGame()

    -- Unload loaded data (textures, sounds, models...)
    UnloadGame()

    -- Close window and OpenGL context
    rl.CloseWindow()

-- Initialize game variables
let InitGame():
    framesCounter = 0
    gameOver = false
    pause = false

    counterTail = 1
    allowMove = false

    offset.x = float(screenWidth % SQUARE_SIZE)
    offset.y = float(screenHeight % SQUARE_SIZE)

    for 0..SNAKE_LENGTH -> i:
        snake[i].pos = Vec2{x: offset.x/2.0, y: offset.y/2.0}
        snake[i].size = Vec2{x: float(SQUARE_SIZE), y: float(SQUARE_SIZE)}
        snake[i].speed = Vec2{x: float(SQUARE_SIZE), y: 0}

        if i == 0:
            snake[i].color = rl.DARKBLUE
        else:
            snake[i].color = rl.BLUE

    for 0..SNAKE_LENGTH -> i:
        snakePosition[i] = Vec2{x: 0, y: 0}

    fruit.size = Vec2{x: float(SQUARE_SIZE), y: float(SQUARE_SIZE)}
    fruit.color = rl.SKYBLUE
    fruit.active = false

let UpdateGame():
    if gameOver:
        if rl.IsKeyPressed(rl.KEY_ENTER):
            InitGame()
            gameOver = false
        return

    if rl.IsKeyPressed(rl.KEY_P):
        pause = !pause

    if pause: return
    
    -- Player control
    if rl.IsKeyPressed(rl.KEY_RIGHT) and snake[0].speed.x == 0.0 and allowMove:
        snake[0].speed = Vec2{x: float(SQUARE_SIZE), y: 0}
        allowMove = false
    if rl.IsKeyPressed(rl.KEY_LEFT) and snake[0].speed.x == 0.0 and allowMove:
        snake[0].speed = Vec2{x: float(-SQUARE_SIZE), y: 0}
        allowMove = false
    if rl.IsKeyPressed(rl.KEY_UP) and snake[0].speed.y == 0.0 and allowMove:
        snake[0].speed = Vec2{x: 0, y: float(-SQUARE_SIZE)}
        allowMove = false
    if rl.IsKeyPressed(rl.KEY_DOWN) and snake[0].speed.y == 0.0 and allowMove:
        snake[0].speed = Vec2{x: 0, y: float(SQUARE_SIZE)}
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
        fruit.pos = Vec2{
            x: float(rl.GetRandomValue(0, screenWidth/SQUARE_SIZE - 1) * SQUARE_SIZE) + offset.x/2.0,
            y: float(rl.GetRandomValue(0, screenHeight/SQUARE_SIZE - 1) * SQUARE_SIZE) + offset.y/2.0,
        }

        while:
            fruit.pos = Vec2{
                x: float(rl.GetRandomValue(0, screenWidth/SQUARE_SIZE - 1) * SQUARE_SIZE) + offset.x/2.0,
                y: float(rl.GetRandomValue(0, screenHeight/SQUARE_SIZE - 1) * SQUARE_SIZE) + offset.y/2.0,
            }
            let hit = false
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

let DrawGame():
    rl.BeginDrawing()
    rl.ClearBackground(rl.RAYWHITE)

    if !gameOver:
        -- Draw grid lines
        for 0..screenWidth/SQUARE_SIZE + 1 -> i:
            rl.DrawLine(
                SQUARE_SIZE*i + int(offset.x/2.0), int(offset.y/2.0),
                SQUARE_SIZE*i + int(offset.x/2.0), screenHeight - int(offset.y/2.0), rl.LIGHTGRAY)

        for 0..screenHeight/SQUARE_SIZE + 1 -> i:
            rl.DrawLine(
                int(offset.x/2.0), SQUARE_SIZE*i + int(offset.y/2.0),
                screenWidth - int(offset.x/2.0), SQUARE_SIZE*i + int(offset.y/2.0), rl.LIGHTGRAY)

        -- Draw snake
        for 0..counterTail -> i:
            let snakei = snake[i]
            rl.DrawRectangleV(snakei.pos, snakei.size, snakei.color)

        -- Draw fruit to pick
        rl.DrawRectangleV(fruit.pos, fruit.size, fruit.color)

        if pause:
            rl.DrawText('GAME PAUSED', screenWidth/2 - rl.MeasureText('GAME PAUSED', 40)/2, screenHeight/2 - 40, 40, rl.GRAY)
    else:
        rl.DrawText('PRESS [ENTER] TO PLAY AGAIN', rl.GetScreenWidth()/2 - rl.MeasureText('PRESS [ENTER] TO PLAY AGAIN', 20)/2, rl.GetScreenHeight()/2 - 50, 20, rl.GRAY)

    rl.EndDrawing()

let UnloadGame():
    -- TODO: Unload all dynamic loaded data (textures, sounds, models...)
    pass
