-- Copyright (c) 2023 Cyber (See LICENSE)

-- Clash Game
-- Ported from GameDevTV/CPPCourse
-- https://gitlab.com/GameDevTV/CPPCourse/top-down-section
-- This port revises how the camera view is rendered so that variables such as screenWidth/screenHeight
-- can be adjusted without breaking the presentation.
-- This port also adds a gameplay mechanic with a score and advancing difficulty.

import os 'os'
import m 'math'

--import ray 'https://github.com/fubark/ray-cyber'
import ray '../mod.cy'

type Tex2D ray.Texture2D
type Rect ray.Rectangle
type Vec2 ray.Vector2

my Root.screenWidth = 600
my Root.screenHeight = 400
my Root.score = 0

my Root.CharIdleTex = none
my Root.CharRunTex = none
my Root.WeaponTex = none
my Root.GoblinIdleTex = none
my Root.GoblinRunTex = none
my Root.SlimeIdleTex = none
my Root.SlimeRunTex = none

my Root.viewPos = [Vec2 x: 0, y: 0]
my Root.mapScale = 4.0
my Root.boundsMinX = 45.0 * mapScale
my Root.boundsMinY = 45.0 * mapScale
my Root.boundsMaxX = 700.0 * mapScale
my Root.boundsMaxY = 700.0 * mapScale
my Root.knight = none
my Root.enemies = []

-- Assumes script path is the second arg.
my basePath = os.dirName(os.realPath(os.args()[1]) as string)

ray.InitWindow(screenWidth, screenHeight, 'Clash Game')
ray.SetTargetFPS(60)

my rockTex = ray.LoadTexture('$(basePath)/nature_tileset/Rock.png')
my logTex = ray.LoadTexture('$(basePath)/nature_tileset/Log.png')

my mapTex = ray.LoadTexture('$(basePath)/nature_tileset/OpenWorldMap24x24.png')

CharIdleTex = ray.LoadTexture('$(basePath)/characters/knight_idle_spritesheet.png')
CharRunTex = ray.LoadTexture('$(basePath)/characters/knight_run_spritesheet.png')

WeaponTex = ray.LoadTexture('$(basePath)/characters/weapon_sword.png')

GoblinIdleTex = ray.LoadTexture('$(basePath)/characters/goblin_idle_spritesheet.png')
GoblinRunTex = ray.LoadTexture('$(basePath)/characters/goblin_run_spritesheet.png')

SlimeIdleTex = ray.LoadTexture('$(basePath)/characters/slime_idle_spritesheet.png')
SlimeRunTex = ray.LoadTexture('$(basePath)/characters/slime_run_spritesheet.png')

my props = [
    Prop.new([Vec2 x: 600, y: 300], rockTex),
    Prop.new([Vec2 x: 400, y: 500], logTex),
]

InitGame()
while !ray.WindowShouldClose():
    ray.BeginDrawing()
    ray.ClearBackground(ray.WHITE)

    my knightPos = knight.base.getWorldPos()
    viewPos = [Vec2 x: knightPos.x - float(screenWidth/2), y: knightPos.y - float(screenHeight/2)]
    if viewPos.x < 0.0: viewPos.x = 0.0
    if viewPos.y < 0.0: viewPos.y = 0.0
    if viewPos.x > float(mapTex.width) * mapScale - float(screenWidth):
        viewPos.x = float(mapTex.width) * mapScale - float(screenWidth)

    -- Draw the map
    ray.DrawTextureEx(mapTex, Vec2.scale(viewPos, -1), 0, mapScale, ray.WHITE)

    -- Draw the props
    for props -> prop:
        prop.render()

    if !knight.base.getAlive():
        -- Character is not alive
        ray.DrawText('Game Over!', 30, 20, 40, ray.RED)
        ray.DrawText('Score: $(score)', 30, 70, 40, ray.GREEN)
        ray.DrawText('PRESS [ENTER] TO PLAY AGAIN', 30, 120, 20, ray.GREEN)
        ray.EndDrawing()
        if ray.IsKeyPressed(ray.KEY_ENTER):
            InitGame()
        continue
    else:
        -- Character is alive
        ray.DrawText('Health: $(m.floor(float(knight.getHealth())))', 30, 20, 40, ray.RED)
        ray.DrawText('Score: $(score)', 30, 70, 40, ray.GREEN)

    knight.tick(ray.GetFrameTime())
    knight.render()

    -- Check prop collisions
    for props -> prop:
        if ray.CheckCollisionRecs(prop.getCollideRect(), knight.base.getCollideRect()):
            knight.base.undoMovement()

    for enemies -> enemy:
        enemy.tick(ray.GetFrameTime())
        enemy.base.render()

    if ray.IsMouseButtonPressed(ray.MOUSE_LEFT_BUTTON):
        for enemies -> enemy:
            if ray.CheckCollisionRecs(enemy.base.getCollideRect(), knight.getWeaponCollideRect()):
                removeEnemy(enemy)
                score += 10
                -- Spawn 2 more
                spawnRandomEnemy(knight)
                spawnRandomEnemy(knight)

    ray.EndDrawing()
ray.CloseWindow()

func Character.new():
    my o = [Character
        base: BaseCharacter.new(),
        weapon: WeaponTex,
        weaponCollideRect: [Rect x: 0, y: 0, width: 0, height: 0],
        health: 100.0,
    ]
    o.base.texture = CharIdleTex
    o.base.idle = CharIdleTex
    o.base.run = CharRunTex
    o.base.width = float(o.base.texture.width / o.base.maxFrames)
    o.base.height = float(o.base.texture.height)
    return o

type Character object:
    my base
    my weapon
    my weaponCollideRect
    my health

    func tick(deltaTime):
        if !self.base.getAlive(): return

        if ray.IsKeyDown(ray.KEY_A): self.base.velocity.x -= 1.0
        if ray.IsKeyDown(ray.KEY_D): self.base.velocity.x += 1.0
        if ray.IsKeyDown(ray.KEY_W): self.base.velocity.y -= 1.0
        if ray.IsKeyDown(ray.KEY_S): self.base.velocity.y += 1.0
        self.base.tick(deltaTime)

    func render():
        self.base.render()
        -- Draw the sword
        my origin = [Vec2 x: 0, y: 0]
        my offset = [Vec2 x: 0, y: 0]
        my rotation = 0.0
        if self.base.rightLeft > 0:
            origin = [Vec2 x: 0, y: float(self.weapon.height) * self.base.scale]
            offset = [Vec2 x: 35, y: 55]
            self.weaponCollideRect = [Rect
                x: self.base.worldPos.x + offset.x,
                y: self.base.worldPos.y + offset.y - float(self.weapon.height) * self.base.scale,
                width: float(self.weapon.width) * self.base.scale,
                height: float(self.weapon.height) * self.base.scale,
            ]
            rotation = ray.IsMouseButtonDown(ray.MOUSE_LEFT_BUTTON) ? 35.0 else 0.0
        else:
            origin = [Vec2 x: float(self.weapon.width) * self.base.scale, y: float(self.weapon.height) * self.base.scale]
            offset = [Vec2 x: 25, y: 55]
            self.weaponCollideRect = [Rect
                x: self.base.worldPos.x + offset.x - float(self.weapon.width) * self.base.scale,
                y: self.base.worldPos.y + offset.y - float(self.weapon.height) * self.base.scale,
                width: float(self.weapon.width) * self.base.scale,
                height: float(self.weapon.height) * self.base.scale,
            ]
            rotation = ray.IsMouseButtonDown(ray.MOUSE_LEFT_BUTTON) ? -35.0 else 0.0
        my source = [Rect x: 0, y: 0,
            width: float(self.weapon.width * self.base.rightLeft),
            height: float(self.weapon.height),
        ]
        my screenPos = Vec2.sub(self.base.worldPos, viewPos)
        my dest = [Rect
            x: screenPos.x + offset.x,
            y: screenPos.y + offset.y,
            width: float(self.weapon.width) * self.base.scale,
            height: float(self.weapon.height) * self.base.scale,
        ]
        ray.DrawTexturePro(self.weapon, source, dest, origin, rotation, ray.WHITE)

    func takeDamage(damage):
        self.health -= damage
        if self.health <= 0.0:
            self.base.setAlive(false)

    func getHealth(): return self.health
    func getWeaponCollideRect(): return self.weaponCollideRect


func BaseCharacter.new():
    return [BaseCharacter
        worldPos: [Vec2 x: 0, y: 0],
        velocity: [Vec2 x: 0, y: 0],
        worldPosLastFrame: [Vec2 x: 0, y: 0],
        frame: 0,
        width: 0.0,
        height: 0.0,
        alive: true,
        speed: 4.0,
        scale: 4.0,
        updateTime: 1.0/12.0,
        runningTime: 0.0,
        maxFrames: 6,
        rightLeft: 1,
        texture: none,
        idle: none,
        run: none,
    ]

type BaseCharacter object:
    my worldPos
    my velocity
    my alive
    my width
    my height
    my speed
    my scale

    -- animation variables
    my runningTime
    my frame
    my maxFrames
    my updateTime

    -- 1 : facing right, -1 : facing left
    my rightLeft

    my worldPosLastFrame

    my texture
    my idle
    my run

    func getWorldPos():
        return self.worldPos

    func setAlive(isAlive):
        self.alive = isAlive

    func getAlive():
        return self.alive

    func undoMovement():
        self.worldPos = self.worldPosLastFrame

    func tick(deltaTime):
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

    func render():
        if !self.alive: return
        my source = [Rect x: float(self.frame) * self.width, y: 0.0, width: float(self.rightLeft) * self.width, height: self.height]

        my screenPos = Vec2.sub(self.worldPos, viewPos)
        my dest = [Rect x: screenPos.x, y: screenPos.y,
            width: self.scale * self.width, height: self.scale * self.height]
        ray.DrawTexturePro(self.texture, source, dest, [Vec2 x: 0, y: 0], 0, ray.WHITE)

    func getCollideRect():
        return [Rect
            x: self.worldPos.x,
            y: self.worldPos.y,
            width: self.width * self.scale,
            height: self.height * self.scale,
        ]

func Prop.new(pos, tex):
    return [Prop worldPos: pos, texture: tex, scale: 4.0]

type Prop object:
    my worldPos
    my texture
    my scale

    func render():
        my screenPos = Vec2.sub(self.worldPos, viewPos)
        ray.DrawTextureEx(self.texture, screenPos, 0.0, self.scale, ray.WHITE)

    func getCollideRect():
        return [Rect
            x: self.worldPos.x,
            y: self.worldPos.y,
            width: float(self.texture.width) * self.scale,
            height: float(self.texture.height) * self.scale,
        ]

func Enemy.new(pos, idleTex, runTex):
    my o = [Enemy
        base: BaseCharacter.new(),
        damagePerSec: 10.0,
        radius: 25.0,
    ]
    o.base.worldPos = pos
    o.base.texture = idleTex
    o.base.idle = idleTex
    o.base.run = runTex
    o.base.width = float(o.base.texture.width / o.base.maxFrames)
    o.base.height = float(o.base.texture.height)
    o.base.speed = 3.5
    return o

type Enemy object:
    my base
    my target
    my damagePerSec
    my radius

    func tick(deltaTime):
        if !self.base.getAlive(): return

        -- get toTarget
        self.base.velocity = Vec2.sub(self.target.base.getWorldPos(), self.base.getWorldPos())
        if self.base.velocity.len() < self.radius: self.base.velocity = [Vec2 x: 0, y: 0]
        self.base.tick(deltaTime)

        if ray.CheckCollisionRecs(self.target.base.getCollideRect(), self.base.getCollideRect()):
            self.target.takeDamage(self.damagePerSec * deltaTime)

    func setTarget(char):
        self.target = char

    func getScreenPos():
        return Vec2.sub(self.base.worldPos, self.target.base.getWorldPos())

func spawnRandomEnemy(target):
    my x = float(ray.GetRandomValue(int(boundsMinX), int(boundsMaxX)))
    my y = float(ray.GetRandomValue(int(boundsMinY), int(boundsMaxY)))
    my creature = ray.GetRandomValue(0, 1)
    my enemy = none
    if creature == 0:
        enemy = Enemy.new([Vec2 x: x, y: y], GoblinIdleTex, GoblinRunTex)
    else:
        enemy = Enemy.new([Vec2 x: x, y: y], SlimeIdleTex, SlimeRunTex)
    enemy.setTarget(target)
    enemies.append(enemy)

func removeEnemy(enemy):
    for enemies -> it, i:
        if it == enemy:
            enemies.remove(i)
            break

func InitGame():
    knight = Character.new()
    knight.base.worldPos.x = float(ray.GetRandomValue(int(boundsMinX), int(boundsMaxX)))
    knight.base.worldPos.y = float(ray.GetRandomValue(int(boundsMinY), int(boundsMaxY)))

    score = 0

    enemies = []
    for 0..10:
        spawnRandomEnemy(knight)
