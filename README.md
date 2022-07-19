# jl-laptop

a laptop script

# HOW TO INSTALL

## General

Go to your qb-core/server/player.lua and add this metadata

```lua
    PlayerData.metadata['laptop'] = PlayerData.metadata['laptop'] or {
        background = 'default',
        darkfont = false,
    }
```

## BOOSTING

Headover to your qb-core/shared/vehicles and add this to all your following vehicles

```lua
["tier"] = "D" -- Can either be D, C, B, A, A+, S, S+
```

Go to your qb-core/server/player.lua and add this metadata

```lua
    PlayerData.metadata['carboostrep'] = PlayerData.metadata['carboostrep'] or 0
```

Shield: [![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]

This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg
