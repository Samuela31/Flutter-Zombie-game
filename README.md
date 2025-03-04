# Flutter Zombie game: Let Me Live

This Flutter app is a simple game named “Let Me Live” done during my 3rd year in college as a group project assignment required for the course Mobile Application Development. Here, the player plays as a plant which has to kill zombies approaching it. See report document for more details. Assets folder has images and media files required for the game. 

Note: The images and GIFs used are not mine and belong to their respective owners. 

## About
There are 3 zombies and they are placed in a grid along with the plant. Plant can be moved by tapping on any tile in column 1 of grid, and plant will constantly fire a green fireball for attacking zombies. Zombies will spawn on last column of grid, each spawning after a certain interval of time and moving towards plant at varying speeds. Zombie 1 spawns as soon as game begins and is the slowest and moves one tile forward every 5 seconds, and plant should hit it 2 times to kill zombie. Zombie 2 spawns after 30s of game starting and moves one tile forward every 4s, plant should hit it 3 times to kill. Zombie 3 spawns after 60s of game starting and moves one tile forward every 3s, plant should hit it 5 times to kill. If plant kills all zombies successfully before any zombie reaches other end of the grid (i.e.) column 1 of grid, player wins. If any zombie reaches other end of grid, player loses. Player can also see guidelines for playing game before starting by clicking help button.

![Game Screenshot](https://github.com/Samuela31/Flutter-Zombie-game/blob/main/Output%20screenshots/game.png)
