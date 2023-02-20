# ray-cyber
[raylib](https://github.com/raysan5/raylib) bindings for [Cyber](https://cyberscript.dev)!

Start using by importing the URL from your script.

# Instructions.
1. [Install Cyber](https://github.com/fubark/cyber#install)
2. Create a new cyber script `game.cys`:
```text
import ray 'https://github.com/fubark/ray-cyber'

ray.InitWindow(800, 600, 'Hello')
ray.SetTargetFPS(60)

-- Main game loop
while !ray.WindowShouldClose():
    -- Do game update...
    ray.BeginDrawing()
    ray.ClearBackground(ray.RAYWHITE)
    ray.DrawText('Congrats! You created your first window!', 190, 200, 20, ray.LIGHTGRAY)
    ray.EndDrawing()

ray.CloseWindow()
```
3. Run the game!
```sh
cyber game.cys
```

# More examples.
```sh
git clone https://github.com/fubark/ray-cyber
cd ray-cyber
```
## Snake
```sh
cyber examples/snake.cys
```
![snake](./images/classic_snake.png)

## Asteroids
cyber examples/asteroids.cys

https://user-images.githubusercontent.com/94020660/219881427-1244fd8d-29da-4a72-87bb-fcef46de650a.mp4

## Clash
cyber examples/clash.cys

https://user-images.githubusercontent.com/94020660/219976051-ea658da6-e46b-4bbf-b191-f73151efa309.mp4
