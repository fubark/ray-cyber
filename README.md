# ray-cyber
raylib bindings for [Cyber](https://cyberscript.dev)!

Import and use in your script with just a URL.

# Instructions
- [Install Cyber](https://github.com/fubark/cyber#install)
- Create a new cyber script `game.cys`:
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
- Run the game!
```sh
cyber game.cys
```

# Run more examples.
TODO