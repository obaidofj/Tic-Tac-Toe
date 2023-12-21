import 'dart:io';

class TicTacToe {
  late List<String> board;
  late String currentPlayer;
  late bool isGameDone;

  TicTacToe() {
    board = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
    currentPlayer = 'X'; 
    isGameDone = false;
  }

  void displayBoard() {
    print(' ${board[0]} | ${board[1]} | ${board[2]} ');
    print('-----------');
    print(' ${board[3]} | ${board[4]} | ${board[5]} ');
    print('-----------');
    print(' ${board[6]} | ${board[7]} | ${board[8]} ');
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  bool isMoveValid(int position) {
     if (position < 1 || position > 9) {
      return false;
    }

    return ['1', '2', '3', '4', '5', '6', '7', '8', '9']
        .contains(board[position - 1]);
  }

  bool checkWin() {
    
    for (int i = 0; i < 9; i += 3) {
      if (board[i] != ' ' &&
          board[i] == board[i + 1] &&
          board[i] == board[i + 2]) {
        return true;
      }
    }

    
    for (int i = 0; i < 3; i++) {
      if (board[i] != ' ' &&
          board[i] == board[i + 3] &&
          board[i] == board[i + 6]) {
        return true;
      }
    }

    
    if ((board[0] != ' ' && board[0] == board[4] && board[0] == board[8]) ||
        (board[2] != ' ' && board[2] == board[4] && board[2] == board[6])) {
      return true;
    }

    return false;
  }

  bool checkDraw() {
    return !['1', '2', '3', '4', '5', '6', '7', '8', '9']
        .any((element) => board.contains(element));
  }

  void makeMove() {
    displayBoard();
    while (!isGameDone) {
      print('Player $currentPlayer\'s turn. Enter your move (1-9):');
      String? input = stdin.readLineSync();
      if (input != null) {
        int? move = int.tryParse(input);
        
        if (move != null && isMoveValid(move)) {
          board[move - 1] = currentPlayer;
          if (checkWin()) {
            displayBoard();
            print('Player $currentPlayer wins!');
            isGameDone = true;
          } else if (checkDraw()) {
            displayBoard();
            print('It\'s a draw!');
            isGameDone = true;
          } else {
            switchPlayer();
            displayBoard();
          }
        } else {
          print('Invalid move. Please enter a valid position.');
        }
      } else {
        print('Invalid input. Please enter a valid position.');
      }
    }
  }

  void startGame() {
    while (true) {
      // board = List.filled(9, ' '); 
      isGameDone = false;
      makeMove();
      print('Do you want to play again? (y/n)');
      String? playAgain = stdin.readLineSync()?.toLowerCase();
      if (playAgain != null && playAgain != 'y') {
        print('Thank you for playing !');
        break;
      }
    }
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.startGame();
}


