import 'dart:math';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/game': (context) => GameScreen(),
        '/instructions': (context) => InstructionsScreen(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.network(
            'https://images.saymedia-content.com/.image/t_share/MTc0Mzg2MzM0MjA1NDg2NDQw/top-6-plants-in-plants-vs-zombies-2.jpg',
            fit: BoxFit.cover,
          ),

          // Welcome Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 26),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/game');
                },
                child: Text('Start Game',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'Bangers')),
              ),
              SizedBox(height: 26),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/instructions');
                },
                child: Text('How to Play?',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'Bangers')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playBackgroundMusic();
  }

  Future<void> _playBackgroundMusic() async {
    try {
      int result = await _audioPlayer.play(
        'assets/bgm.mp3',
        isLocal: true,
        volume: 1.0,
      );

      print('Result from audio player: $result');

      if (result == 1) {
        print('Background music started');
      } else {
        print('Error playing background music');
      }
    } catch (e) {
      print('Exception while playing audio: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // You can return any widget or use this class to manage the audio player.
    return Container();
  }
}

class InstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/g.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'How to play?',
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'BlackOpsOne',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                '1.You will be provided with 1 plant.',
                style: TextStyle(fontSize: 22, fontFamily: 'AmaticSC'),
              ),
              SizedBox(height: 20),
              Text(
                '2.There will be 3 zombies.',
                style: TextStyle(fontSize: 22, fontFamily: 'AmaticSC'),
              ),
              SizedBox(height: 20),
              Text(
                '3.Number of hits to kill zombies-',
                style: TextStyle(fontSize: 22, fontFamily: 'AmaticSC'),
              ),
              SizedBox(height: 20),
              Text(
                'Zombie 1: 2',
                style: TextStyle(fontSize: 22, fontFamily: 'AmaticSC'),
              ),
              SizedBox(height: 20),
              Text(
                'Zombie 2: 3',
                style: TextStyle(fontSize: 22, fontFamily: 'AmaticSC'),
              ),
              SizedBox(height: 20),
              Text(
                'Zombie 3: 4',
                style: TextStyle(fontSize: 22, fontFamily: 'AmaticSC'),
              ),
              SizedBox(height: 20),
              Text(
                '4.If any zombies reach the other end, you lose.',
                style: TextStyle(fontSize: 22, fontFamily: 'AmaticSC'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/game'); // Button pressed action
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent, // Background color
                  elevation: 0, // Remove the button shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side:
                        BorderSide(color: const Color.fromARGB(0, 156, 39, 39)),
                  ),
                ),
                child: Ink.image(
                  image: NetworkImage(
                    'https://media.istockphoto.com/id/506692747/photo/artificial-grass.jpg?s=612x612&w=0&k=20&c=y5I6l-1MgmlPzf2DcEYX08dTLkUXgeo8PGa8Jv3EaOU=',
                  ),
                  fit: BoxFit.cover,
                  width: 200.0, // Set the width of the button
                  height: 50.0, // Set the height of the button
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/game');
                    },
                    child: Center(
                      child: Text(
                        'Lets go to play!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Bangers',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const gridRows = 6;
  static const gridColumns = 16;

  final Random random = Random();
  late Timer timer;
  int plantRow = 0;
  int plantColumn = 0;
  int zombieRow = 0;
  int zombieColumn = gridColumns - 1; // Start the zombie from the last column
  int ballRow = 0;
  int ballColumn = 0;
  int hit1 = 0;
  int hit2 = 0;
  int hit3 = 0;
  bool zombieVisible = true; // Flag to control the visibility of ZombieWidget
  bool zombie2Visible = true; // Flag to control the visibility of ZombieWidget
  bool zombie3Visible = true; // Flag to control the visibility of ZombieWidget

  int zombie2Row =
      -1; // To indicate that the additional zombies are initially not spawned
  int zombie2Column = -1;
  int zombie3Row = -1;
  int zombie3Column = -1;

  _GameScreenState() {
    // Generate random rows for the plant and zombie
    plantRow = random.nextInt(gridRows); // Random row for the plant in any row
    zombieRow =
        random.nextInt(gridRows); // Random row for the zombie in any row

    // Start the timer to move the Zombie
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      setState(() {
        // Move the Zombie one tile horizontally towards the plant
        if (zombieColumn > 0 && zombieVisible) {
          zombieColumn--; // Move left
        }
      });
    });

    ballRow = plantRow; // Initially set the ball's row just as the plant's row
    ballColumn = plantColumn +
        1; // Initially set the ball's column just in front of the plant

    // Start the timer to move the ball
    Timer.periodic(Duration(milliseconds: 500), (Timer t) {
      setState(() {
        if (ballColumn == gridColumns - 1) {
          ballColumn = plantColumn +
              1; // Reset the ball's column when it reaches the last column
        } else {
          ballColumn++; // Move the ball to the right
        }

        // Increment hit variables based on collisions
        if (ballColumn == zombieColumn && ballRow == zombieRow) {
          hit1++;
          if (hit1 == 2) {
            zombieVisible =
                false; // Set visibility to false when hit1 reaches 2
          }
        }
        if (ballColumn == zombie2Column && ballRow == zombie2Row) {
          hit2++;
          if (hit2 == 3) {
            zombie2Visible =
                false; // Set visibility to false when hit2 reaches 3
          }
        }
        if (ballColumn == zombie3Column && ballRow == zombie3Row) {
          hit3++;
          if (hit3 == 4) {
            zombie3Visible =
                false; // Set visibility to false when hit3 reaches 4
          }
        }
      });
    });

    // Start the timer to add more zombies
    Timer(Duration(seconds: 5), () {
      setState(() {
        // Generate new random rows for the additional zombies
        zombie2Row = random.nextInt(gridRows);
        zombie2Column =
            gridColumns - 1; // Start from the last column for the new zombie
      });
    });

    // Start the timer to move the Zombie 2
    timer = Timer.periodic(Duration(seconds: 4), (Timer t) {
      setState(() {
        // Move the Zombie one tile horizontally towards the plant
        if (zombie2Column > 0 && zombie2Visible) {
          zombie2Column--; // Move left
        }
      });
    });

    Timer(Duration(seconds: 35), () {
      setState(() {
        // Generate new random rows for the additional zombies
        zombie3Row = random.nextInt(gridRows);
        zombie3Column =
            gridColumns - 1; // Start from the last column for the new zombie
      });
    });

    // Start the timer to move the Zombie 3
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      setState(() {
        // Move the Zombie one tile horizontally towards the plant
        if (zombie3Column > 0 && zombie3Visible) {
          zombie3Column--; // Move left
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void plantCallback(int tappedRow, int tappedColumn) {
    setState(() {
      if (tappedColumn == 0) {
        // Set the plantRow and plantColumn to the tapped cell's row and column
        plantRow = tappedRow;
        plantColumn = tappedColumn;
        ballRow = plantRow;
        ballColumn = plantColumn + 1; // Reset the ball's column
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let Me Live"),
      ),
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/w.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridColumns,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final row = index ~/ gridColumns;
                  final col = index % gridColumns;

                  void onTapCallback() {
                    plantCallback(row, col);
                  }

                  Widget gridCell;
                  final backgroundImage = (row % 2 == 0 && col % 2 == 0) ||
                          (row % 2 == 1 && col % 2 == 1)
                      ? 'assets/dgrass.png' // Dark green tile
                      : 'assets/grass.png'; // Light green tile
                  if (col == plantColumn && row == plantRow) {
                    // Spawn plant
                    gridCell = PlantWidget(
                      backgroundImage: backgroundImage,
                    );
                  } else if (col == ballColumn && row == ballRow) {
                    // Spawn ball
                    gridCell = BallWidget(
                      backgroundImage: backgroundImage,
                    );
                  } else if (col == zombieColumn &&
                      row == zombieRow &&
                      zombieVisible) {
                    // Spawn zombie 1
                    gridCell = ZombieWidget(
                      backgroundImage: backgroundImage,
                    );
                  } else if (col == zombie2Column &&
                      row == zombie2Row &&
                      zombie2Visible) {
                    // Spawn zombie 2
                    gridCell = Zombie2Widget(
                      backgroundImage: backgroundImage,
                    );
                  } else if (col == zombie3Column &&
                      row == zombie3Row &&
                      zombie3Visible) {
                    // Spawn zombie 3
                    gridCell = Zombie3Widget(
                      backgroundImage: backgroundImage,
                    );
                  } else {
                    // Create a regular cell
                    gridCell = GridCellWidget(
                      backgroundImage: backgroundImage,
                      onTap: onTapCallback,
                    );
                  }

                  return gridCell;
                },
                itemCount: gridRows * gridColumns,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Start the timer to check win/lose conditions
    Timer.periodic(Duration(milliseconds: 500), (Timer t) {
      if (hit1 >= 2 && hit2 >= 3 && hit3 >= 4) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GameOverPage(
                message: 'You Win! Zombie did not reach the plant!'),
          ),
        );
      } else if (plantColumn == zombieColumn ||
          plantColumn == zombie2Column ||
          plantColumn == zombie3Column) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                GameOverPage(message: 'You Lose! Plant and Zombie collided!'),
          ),
        );
      }
    });
  }
}

class GridCellWidget extends StatelessWidget {
  final String backgroundImage;
  final void Function() onTap;

  GridCellWidget({required this.backgroundImage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class PlantWidget extends StatelessWidget {
  final String backgroundImage;

  PlantWidget({required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return PlantGame(
      backgroundImage: backgroundImage,
    );
  }
}

class ZombieWidget extends StatelessWidget {
  final String backgroundImage;

  ZombieWidget({required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return ZombieGame(
      backgroundImage: backgroundImage,
    );
  }
}

class PlantGame extends StatelessWidget {
  final String backgroundImage;

  PlantGame({required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Image.asset('assets/bulb.gif'),
    );
  }
}

class ZombieGame extends StatelessWidget {
  final String backgroundImage;

  ZombieGame({required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Image.asset('assets/book.gif'),
    );
  }
}

class BallWidget extends StatelessWidget {
  final String backgroundImage;

  BallWidget({required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return BallGame(
      backgroundImage: backgroundImage,
    );
  }
}

class BallGame extends StatelessWidget {
  final String backgroundImage;

  BallGame({required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Image.asset('assets/ball.gif'),
    );
  }
}

class Zombie2Widget extends StatelessWidget {
  final String backgroundImage;

  Zombie2Widget({required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Zombie2Game(
      backgroundImage: backgroundImage,
    );
  }
}

class Zombie2Game extends StatelessWidget {
  final String backgroundImage;

  Zombie2Game({required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Image.asset('assets/skel.gif'),
    );
  }
}

class Zombie3Widget extends StatelessWidget {
  final String backgroundImage;

  Zombie3Widget({required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Zombie3Game(
      backgroundImage: backgroundImage,
    );
  }
}

class Zombie3Game extends StatelessWidget {
  final String backgroundImage;

  Zombie3Game({required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Image.asset('assets/gloomy.gif'),
    );
  }
}

class GameOverPage extends StatelessWidget {
  final String message;

  GameOverPage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Over'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/l.jpg'), // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated text
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(seconds: 1),
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0.0, value * 50),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  'GAME OVER!!',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Set the text color
                    fontFamily: 'AmaticSC', // Use your font family
                  ),
                ),
              ),
              SizedBox(height: 50),
              // Message text
              Text(
                message,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: 'AmaticSC',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
