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

var .screenWidth = 600
var .screenHeight = 400
var .score = 0

dyn .CharIdleTex = false
dyn .CharRunTex = false
dyn .WeaponTex = false
dyn .GoblinIdleTex = false
dyn .GoblinRunTex = false
dyn .SlimeIdleTex = false
dyn .SlimeRunTex = false

var .viewPos = Vec2{x=0, y=0}
var .mapScale = 4.0
var .boundsMinX = 45.0 * mapScale
var .boundsMinY = 45.0 * mapScale
var .boundsMaxX = 700.0 * mapScale
var .boundsMaxY = 700.0 * mapScale
dyn .knight = false
dyn .enemies = {_}

-- Assumes script path is the second arg.
var basePath = os.dirName(os.realPath(os.args()[1])).?

rl.InitWindow(screenWidth, screenHeight, 'Clash Game')
rl.SetTargetFPS(60)

var rockTex = rl.LoadTexture("$(basePath)/nature_tileset/Rock.png")
var logTex = rl.LoadTexture("$(basePath)/nature_tileset/Log.png")

var mapTex = rl.LoadTexture("$(basePath)/nature_tileset/OpenWorldMap24x24.png")

CharIdleTex = rl.LoadTexture("$(basePath)/characters/knight_idle_spritesheet.png")
CharRunTex = rl.LoadTexture("$(basePath)/characters/knight_run_spritesheet.png")

WeaponTex = rl.LoadTexture("$(basePath)/characters/weapon_sword.png")

GoblinIdleTex = rl.LoadTexture("$(basePath)/characters/goblin_idle_spritesheet.png")
GoblinRunTex = rl.LoadTexture("$(basePath)/characters/goblin_run_spritesheet.png")

SlimeIdleTex = rl.LoadTexture("$(basePath)/characters/slime_idle_spritesheet.png")
SlimeRunTex = rl.LoadTexture("$(basePath)/characters/slime_run_spritesheet.png")

var props = {
    Prop.new(Vec2{x=600, y=300}, rockTex),
    Prop.new(Vec2{x=400, y=500}, logTex),
}

InitGame()
while !rl.WindowShouldClose():
    rl.BeginDrawing()
    rl.ClearBackground(rl.WHITE)

    var knightPos = knight.base.getWorldPos()
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

func Character.new() Character:
    var o = Character{
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

type Character(base, weapon, weaponCollideRect, health dyn):
    func tick(self, deltaTime dyn):
        if !self.base.getAlive(): return

        if rl.IsKeyDown(rl.KEY_A): self.base.velocity.x -= 1.0
        if rl.IsKeyDown(rl.KEY_D): self.base.velocity.x += 1.0
        if rl.IsKeyDown(rl.KEY_W): self.base.velocity.y -= 1.0
        if rl.IsKeyDown(rl.KEY_S): self.base.velocity.y += 1.0
        self.base.tick(deltaTime)

    func render(self):
        self.base.render()
        -- Draw the sword
        var origin = Vec2{x=0, y=0}
        var offset = Vec2{x=0, y=0}
        var rotation = 0.0
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
        var source = Rect{x=0, y=0,
            width = float(self.weapon.width * self.base.rightLeft),
            height = float(self.weapon.height),
        }
        var screenPos = Vec2.sub(self.base.worldPos, viewPos)
        var dest = Rect{
            x = screenPos.x + offset.x,
            y = screenPos.y + offset.y,
            width = float(self.weapon.width) * self.base.scale,
            height = float(self.weapon.height) * self.base.scale,
        }
        rl.DrawTexturePro(self.weapon, source, dest, origin, rotation, rl.WHITE)

    func takeDamage(self, damage dyn):
        self.health -= damage
        if self.health <= 0.0:
            self.base.setAlive(false)

    func getHealth(self) dyn: return self.health
    func getWeaponCollideRect(self) dyn: return self.weaponCollideRect


func BaseCharacter.new() BaseCharacter:
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

type BaseCharacter(
    worldPos, velocity, alive,
    width, height, speed, scale,

    -- animation variables
    runningTime, frame, maxFrames, updateTime,

    -- 1 : facing right, -1 : facing left
    rightLeft,

    worldPosLastFrame,
    texture, idle, run dyn):

    func getWorldPos(self) dyn:
        return self.worldPos

    func setAlive(self, isAlive bool):
        self.alive = isAlive

    func getAlive(self) bool:
        return self.alive

    func undoMovement(self):
        self.worldPos = self.worldPosLastFrame

    func tick(self, deltaTime dyn):
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

    func render(self):
        if !self.alive: return
        var source = Rect{x=float(self.frame) * self.width, y=0.0, width=float(self.rightLeft) * self.width, height=self.height}

        var screenPos = Vec2.sub(self.worldPos, viewPos)
        var dest = Rect{x=screenPos.x, y=screenPos.y,
            width = self.scale * self.width, height = self.scale * self.height}
        rl.DrawTexturePro(self.texture, source, dest, Vec2{x=0, y=0}, 0, rl.WHITE)

    func getCollideRect(self) Rect:
        return Rect{
            x = self.worldPos.x,
            y = self.worldPos.y,
            width = self.width * self.scale,
            height = self.height * self.scale,
        }

func Prop.new(pos, tex dyn) Prop:
    return Prop{worldPos=pos, texture=tex, scale=4.0}

type Prop(worldPos, texture, scale dyn):
    func render(self):
        var screenPos = Vec2.sub(self.worldPos, viewPos)
        rl.DrawTextureEx(self.texture, screenPos, 0.0, self.scale, rl.WHITE)

    func getCollideRect(self) Rect:
        return Rect{
            x = self.worldPos.x,
            y = self.worldPos.y,
            width = float(self.texture.width) * self.scale,
            height = float(self.texture.height) * self.scale,
        }

func Enemy.new(pos, idleTex, runTex dyn) Enemy:
    var o = Enemy{
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

type Enemy(base, target, damagePerSec, radius dyn):
    func tick(self, deltaTime dyn):
        if !self.base.getAlive(): return

        -- get toTarget
        self.base.velocity = Vec2.sub(self.target.base.getWorldPos(), self.base.getWorldPos())
        if self.base.velocity.len() < self.radius: self.base.velocity = Vec2{x=0, y=0}
        self.base.tick(deltaTime)

        if rl.CheckCollisionRecs(self.target.base.getCollideRect(), self.base.getCollideRect()):
            self.target.takeDamage(self.damagePerSec * deltaTime)

    func setTarget(self, char dyn):
        self.target = char

    func getScreenPos(self) Vec2:
        return Vec2.sub(self.base.worldPos, self.target.base.getWorldPos())

func spawnRandomEnemy(target dyn):
    var x = float(rl.GetRandomValue(int(boundsMinX), int(boundsMaxX)))
    var y = float(rl.GetRandomValue(int(boundsMinY), int(boundsMaxY)))
    var creature = rl.GetRandomValue(0, 1)
    dyn enemy = false
    if creature == 0:
        enemy = Enemy.new(Vec2{x=x, y=y}, GoblinIdleTex, GoblinRunTex)
    else:
        enemy = Enemy.new(Vec2{x=x, y=y}, SlimeIdleTex, SlimeRunTex)
    enemy.setTarget(target)
    enemies.append(enemy)

func removeEnemy(enemy Enemy):
    for enemies -> it, i:
        if it == enemy:
            enemies.remove(i)
            break

func InitGame():
    knight = Character.new()
    knight.base.worldPos.x = float(rl.GetRandomValue(int(boundsMinX), int(boundsMaxX)))
    knight.base.worldPos.y = float(rl.GetRandomValue(int(boundsMinY), int(boundsMaxY)))

    score = 0

    enemies = {_}
    for 0..10:
        spawnRandomEnemy(knight)
