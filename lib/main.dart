import 'package:flutter/material.dart';
import 'theme/color.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String value = "x";
  Game game = Game();
  bool gameOver = false;
  int turn = 0;
  String result = '';
  List<int> scoresList = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("images/tictactoe.jpg"))
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$value turn".toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: GridView.count(
                crossAxisCount: Game.boardlength ~/ 3,
                padding: const EdgeInsets.all(16.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(Game.boardlength, (index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    onTap: gameOver
                        ? null
                        : () {
                            if (game.board![index] == '') {
                              setState(() {
                                game.board![index] = value;
                                turn++;
                                gameOver =
                                    game.winnerCheck(value, index, scoresList, 3);
                                if (gameOver) {
                                  result = "$value is the winner";
                                } else if (!gameOver && turn == 9) {
                                  result = "Draw";
                                }
                                if (value == 'x') {
                                  value = 'o';
                                } else {
                                  value = 'x';
                                }
                              });
                            }
                          },
                    child: Container(
                      width: Game.boardSize,
                      height: Game.boardSize,
                      decoration: BoxDecoration(
                          color: MainColor.secondaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                              color: game.board![index] == "x"
                                  ? const Color.fromARGB(255, 78, 158, 224)
                                  : Colors.pink,
                              fontSize: 64.0),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              result,
              style: const TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    game.board = Game.initGameBoard();
                    value = 'x';
                    gameOver = false;
                    turn = 0;
                    result = '';
                    scoresList = [0, 0, 0, 0, 0, 0, 0, 0, 0];
                  });
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: MainColor.secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                icon: const Icon(
                  Icons.replay,
                ),
                label: const Text(
                  "Repeat the Game",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ))
          ],
        ),
      ),
    );
  }
}
