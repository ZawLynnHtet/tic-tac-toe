
class Player {
  static const x = "x";
  static const o = "o";
  static const empty = "";
}

class Game {
  static const boardlength = 9;
  static const boardSize = 100.0;

  List<String>? board;

  static List<String>? initGameBoard() => List.generate(boardlength, (index) => Player.empty);

  bool winnerCheck(String player, int index, List<int> scoresList,
  int gridSize) {
    int row = index ~/3;
    int col = index % 3;
    int score = player == 'x'? 1:-1;

    scoresList[row]+= score;
    scoresList[gridSize + col]+= score;

    if(row == col) scoresList[2*gridSize] += score;
    if(gridSize -1 -col == row) scoresList[2*gridSize + 1] += score;

    if(scoresList.contains(3) || scoresList.contains(-3)){
      return true;
    }
    return false;
  }
}