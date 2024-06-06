-- Copyright (c) 2023 Cyber (See LICENSE)

-- Clash Game
-- Ported from GameDevTV/CPPCourse
-- https://gitlab.com/GameDevTV/CPPCourse/top-down-section
-- This port revises how the camera view is rendered so that variables such as screenWidth/screenHeight
-- can be adjusted without breaking the presentation.
-- This port also adds a gameplay mechanic with a score and advancing difficulty.

use os
use m 'math'

--use rl 'https://github.com/fubark/ray-cyber'
use rl '../mod.cy'

use Tex2D -> rl.Texture2D
use Rect -> rl.Rectangle
use Vec2 -> rl.Vector2

let .screenWidth = 600
let .screenHeight = 400
let .score = 0

let .CharIdleTex = false
let .CharRunTex = false
let .WeaponTex = false
let .GoblinIdleTex = false
let .GoblinRunTex = false
let .SlimeIdleTex = false
let .SlimeRunTex = false

let .viewPos = Vec2{x=0, y=0}
let .mapScale = 4.0
let .boundsMinX = 45.0 * mapScale
let .boundsMinY = 45.0 * mapScale
let .boundsMaxX = 700.0 * mapScale
let .boundsMaxY = 700.0 * mapScale
let .knight = false
let .enemies = []

-- Assumes script path is the second arg.
let basePath = os.dirName(os.realPath(os.args()[1])).?

rl.InitWindow(screenWidth, screenHeight, 'Clash Game')
rl.SetTargetFPS(60)

let rockTex = rl.LoadTexture("$(basePath)/nature_tileset/Rock.png")
let logTex = rl.LoadTexture("$(basePath)/nature_tileset/Log.png")

let mapTex = rl.LoadTexture("$(basePath)/nature_tileset/OpenWorldMap24x24.png")

CharIdleTex = rl.LoadTexture("$(basePath)/characters/knight_idle_spritesheet.png")
CharRunTex = rl.LoadTexture("$(basePath)/characters/knight_run_spritesheet.png")

WeaponTex = rl.LoadTexture("$(basePath)/characters/weapon_sword.png")

GoblinIdleTex = rl.LoadTexture("$(basePath)/characters/goblin_idle_spritesheet.png")
GoblinRunTex = rl.LoadTexture("$(basePath)/characters/goblin_run_spritesheet.png")

SlimeIdleTex = rl.LoadTexture("$(basePath)/characters/slime_idle_spritesheet.png")
SlimeRunTex = rl.LoadTexture("$(basePath)/characters/slime_run_spritesheet.png")

let props = [
    Prop.new(Vec2{x=600, y=300}, rockTex),
    Prop.new(Vec2{x=400, y=500}, logTex),
]

InitGame()
while !rl.WindowShouldClose():
    rl.BeginDrawing()
    rl.ClearBackground(rl.WHITE)

    let knightPos = knight.base.getWorldPos()
    viewPos = Vec2{x=knightPos.x - float(screenWidth/2), y=knightPos.y - float(screenHeight/2)}
    if viewPos.x < 0.0: viewPos.x = 0.0
    if viewPos.y < 0.0: viewPos.y = 0.0
    if viewPos.x > float(mapTex.width) * mapScale - float(screenWidth):
        viewPos.x = float(mapTex.width) * mapScale - float(screenWidth)

    -- Draw the map
    rl.DrawTextureEx(mapTex, Vec2.scale(viewPos, -1), 0, mapScale, rl.WHITE)

    -- Draw the props
    for props -> prop:
        prop.render()

    if !knight.base.getAlive():
        -- Character is not alive
        rl.DrawText('Game Over!', 30, 20, 40, rl.RED)
        rl.DrawText("Score: $(score)", 30, 70, 40, rl.GREEN)
        rl.DrawText('PRESS [ENTER] TO PLAY AGAIN', 30, 120, 20, rl.GREEN)
        rl.EndDrawing()
        if rl.IsKeyPressed(rl.KEY_ENTER):
            InitGame()
        continue
    else:
        -- Character is alive
        rl.DrawText("Health: $(m.floor(float(knight.getHealth())))", 30, 20, 40, rl.RED)
        rl.DrawText("Score: $(score)", 30, 70, 40, rl.GREEN)

    knight.tick(rl.GetFrameTime())
    knight.render()

    -- Check prop collisions
    for props -> prop:
        if rl.CheckCollisionRecs(prop.getCollideRect(), knight.base.getCollideRect()):
            knight.base.undoMovement()

    for enemies -> enemy:
        enemy.tick(rl.GetFrameTime())
        enemy.base.render()

    if rl.IsMouseButtonPressed(rl.MOUSE_LEFT_BUTTON):
        for enemies -> enemy:
            if rl.CheckCollisionRecs(enemy.base.getCollideRect(), knight.getWeaponCollideRect()):
                removeEnemy(enemy)
                score += 10
                -- Spawn 2 more
                spawnRandomEnemy(knight)
                spawnRandomEnemy(knight)

    rl.EndDrawing()
rl.CloseWindow()

let Character.new():
    let o = Character{
        base = BaseCharacter.new(),
        weapon = WeaponTex,
        weaponCollideRect = Rect{x=0, y=0, width=0, height=0},
        health = 100.0,
    }
    o.base.texture = CharIdleTex
    o.base.idle = CharIdleTex
    o.base.run = CharRunTex
    o.base.width = float(o.base.texture.width / o.base.maxFrames)
    o.base.height = float(o.base.texture.height)
    return o

let Character{base, weapon, weaponCollideRect, health}:
    let tick(deltaTime):
        if !self.base.getAlive(): return

        if rl.IsKeyDown(rl.KEY_A): self.base.velocity.x -= 1.0
        if rl.IsKeyDown(rl.KEY_D): self.base.velocity.x += 1.0
        if rl.IsKeyDown(rl.KEY_W): self.base.velocity.y -= 1.0
        if rl.IsKeyDown(rl.KEY_S): self.base.velocity.y += 1.0
        self.base.tick(deltaTime)

    let render():
        self.base.render()
        -- Draw the sword
        let origin = Vec2{x=0, y=0}
        let offset = Vec2{x=0, y=0}
        let rotation = 0.0
        if self.base.rightLeft > 0:
            origin = Vec2{x=0, y=float(self.weapon.height) * self.base.scale}
            offset = Vec2{x=35, y=55}
            self.weaponCollideRect = Rect{
                x = self.base.worldPos.x + offset.x,
                y = self.base.worldPos.y + offset.y - float(self.weapon.height) * self.base.scale,
                width = float(self.weapon.width) * self.base.scale,
                height = float(self.weapon.height) * self.base.scale,
            }
            rotation = if (rl.IsMouseButtonDown(rl.MOUSE_LEFT_BUTTON)) 35.0 else 0.0
        else:
            origin = Vec2{x=float(self.weapon.width) * self.base.scale, y=float(self.weapon.height) * self.base.scale}
            offset = Vec2{x=25, y=55}
            self.weaponCollideRect = Rect{
                x = self.base.worldPos.x + offset.x - float(self.weapon.width) * self.base.scale,
                y = self.base.worldPos.y + offset.y - float(self.weapon.height) * self.base.scale,
                width = float(self.weapon.width) * self.base.scale,
                height = float(self.weapon.height) * self.base.scale,
            }
            rotation = if (rl.IsMouseButtonDown(rl.MOUSE_LEFT_BUTTON)) -35.0 else 0.0
        let source = Rect{x=0, y=0,
            width = float(self.weapon.width * self.base.rightLeft),
            height = float(self.weapon.height),
        }
        let screenPos = Vec2.sub(self.base.worldPos, viewPos)
        let dest = Rect{
            x = screenPos.x + offset.x,
            y = screenPos.y + offset.y,
            width = float(self.weapon.width) * self.base.scale,
            height = float(self.weapon.height) * self.base.scale,
        }
        rl.DrawTexturePro(self.weapon, source, dest, origin, rotation, rl.WHITE)

    let takeDamage(damage):
        self.health -= damage
        if self.health <= 0.0:
            self.base.setAlive(false)

    let getHealth(): return self.health
    let getWeaponCollideRect(): return self.weaponCollideRect


let BaseCharacter.new():
    return BaseCharacter{
        worldPos = Vec2{x=0, y=0},
        velocity = Vec2{x=0, y=0},
        worldPosLastFrame = Vec2{x=0, y=0},
        frame = 0,
        width = 0.0,
        height = 0.0,
        alive = true,
        speed = 4.0,
        scale = 4.0,
        updateTime = 1.0/12.0,
        runningTime = 0.0,
        maxFrames = 6,
        rightLeft = 1,
        texture = false,
        idle = false,
        run = false,
    }

let BaseCharacter{
    worldPos, velocity, alive,
    width, height, speed, scale,

    -- animation variables
    runningTime, frame, maxFrames, updateTime,

    -- 1 : facing right, -1 : facing left
    rightLeft,

    worldPosLastFrame,
    texture, idle, run }:

    let getWorldPos():
        return self.worldPos

    let setAlive(isAlive):
        self.alive = isAlive

    let getAlive():
        return self.alive

    let undoMovement():
        self.worldPos = self.worldPosLastFrame

    let tick(deltaTime):
        self.worldPosLastFrame = self.worldPos

        -- update animation frame
        self.runningTime += deltaTime
        if self.runningTime >= self.updateTime:
            self.frame += 1
            self.runningTime = 0.0
            if self.frame > self.maxFrames:
                self.frame = 0

        if self.velocity.len() != 0.0:
            -- Update pos based on velocity.
            self.worldPos = self.worldPos.add(self.velocity.normalize().scale(self.speed))
            if self.velocity.x < 0.0: self.rightLeft = -1
            else: self.rightLeft = 1

            -- Check bounds.
            if self.worldPos.x < boundsMinX: self.worldPos.x = boundsMinX
            if self.worldPos.y < boundsMinY: self.worldPos.y = boundsMinY
            if self.worldPos.x > boundsMaxX: self.worldPos.x = boundsMaxX
            if self.worldPos.y > boundsMaxY: self.worldPos.y = boundsMaxY

            self.texture = self.run
        else:
            self.texture = self.idle

        self.velocity.x = 0.0
        self.velocity.y = 0.0

    let render():
        if !self.alive: return
        let source = Rect{x=float(self.frame) * self.width, y=0.0, width=float(self.rightLeft) * self.width, height=self.height}

        let screenPos = Vec2.sub(self.worldPos, viewPos)
        let dest = Rect{x=screenPos.x, y=screenPos.y,
            width = self.scale * self.width, height = self.scale * self.height}
        rl.DrawTexturePro(self.texture, source, dest, Vec2{x=0, y=0}, 0, rl.WHITE)

    let getCollideRect():
        return Rect{
            x = self.worldPos.x,
            y = self.worldPos.y,
            width = self.width * self.scale,
            height = self.height * self.scale,
        }

let Prop.new(pos, tex):
    return Prop{worldPos=pos, texture=tex, scale=4.0}

let Prop{worldPos, texture, scale}:
    let render():
        let screenPos = Vec2.sub(self.worldPos, viewPos)
        rl.DrawTextureEx(self.texture, screenPos, 0.0, self.scale, rl.WHITE)

    let getCollideRect():
        return Rect{
            x = self.worldPos.x,
            y = self.worldPos.y,
            width = float(self.texture.width) * self.scale,
            height = float(self.texture.height) * self.scale,
        }

let Enemy.new(pos, idleTex, runTex):
    let o = Enemy{
        base = BaseCharacter.new(),
        damagePerSec = 10.0,
        radius = 25.0,
    }
    o.base.worldPos = pos
    o.base.texture = idleTex
    o.base.idle = idleTex
    o.base.run = runTex
    o.base.width = float(o.base.texture.width / o.base.maxFrames)
    o.base.height = float(o.base.texture.height)
    o.base.speed = 3.5
    return o

let Enemy{base, target, damagePerSec, radius}:
    let tick(deltaTime):
        if !self.base.getAlive(): return

        -- get toTarget
        self.base.velocity = Vec2.sub(self.target.base.getWorldPos(), self.base.getWorldPos())
        if self.base.velocity.len() < self.radius: self.base.velocity = Vec2{x=0, y=0}
        self.base.tick(deltaTime)

        if rl.CheckCollisionRecs(self.target.base.getCollideRect(), self.base.getCollideRect()):
            self.target.takeDamage(self.damagePerSec * deltaTime)

    let setTarget(char):
        self.target = char

    let getScreenPos():
        return Vec2.sub(self.base.worldPos, self.target.base.getWorldPos())

let spawnRandomEnemy(target):
    let x = float(rl.GetRandomValue(int(boundsMinX), int(boundsMaxX)))
    let y = float(rl.GetRandomValue(int(boundsMinY), int(boundsMaxY)))
    let creature = rl.GetRandomValue(0, 1)
    let enemy = false
    if creature == 0:
        enemy = Enemy.new(Vec2{x=x, y=y}, GoblinIdleTex, GoblinRunTex)
    else:
        enemy = Enemy.new(Vec2{x=x, y=y}, SlimeIdleTex, SlimeRunTex)
    enemy.setTarget(target)
    enemies.append(enemy)

let removeEnemy(enemy):
    for enemies -> it, i:
        if it == enemy:
            enemies.remove(i)
            break

let InitGame():
    knight = Character.new()
    knight.base.worldPos.x = float(rl.GetRandomValue(int(boundsMinX), int(boundsMaxX)))
    knight.base.worldPos.y = float(rl.GetRandomValue(int(boundsMinY), int(boundsMaxY)))

    score = 0

    enemies = []
    for 0..10:
        spawnRandomEnemy(knight)
