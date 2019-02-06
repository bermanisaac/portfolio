import com.berman.ticTacToe.*;

final int bigBorder = 3;
final int smallBorder = 15;
final int internalBorder = 15;
final int bigLength = 850;
final int smallLength = (bigLength / 3) - smallBorder * 2;
final int internalLen = (smallLength / 3) - (internalBorder * 2);
final String xPlayer = "Tree Player 2.1";
final String oPlayer = "Tree Player 2.1";
final int frames = 1000;
final int pauseTime = 500;

boolean isXTurn = true;
int xWins = 0;
int oWins = 0;
float totalGames = 0;

UTTTGame game = new UTTTGame();
//UTTTPlayer player1 = new DeepTreePlayer(game, 3, new EvalGen2(true));
UTTTPlayer player2 = new DeepTreePlayer(game, 5, new EvalGen2(true));

void setup() {
  size(856, 856);
  //fullScreen();

  background(#FFFFFF);
  ellipseMode(CORNER);
  textAlign(CENTER);
  frameRate(frames);
  noLoop();
}

void mouseReleased() {
  int move = getSquareHovered();
  if (game.isGameOver()) {
    redraw();
  } else if (isXTurn) {
    int moves = game.makeMove(move % 9, move / 9);
    redraw();
    println(moves);
    if (moves == 0) {
      runGame();
    }
  }
}

void draw() {
  drawGame();
}

void runGame() {
  if (!game.isGameOver()) {
    if (isXTurn) {
      //player1.think();
      //game.makeMove(player1.getMoveIWantToMake(), player1.getBoardIWantToPlay());
      isXTurn = false;
    } else {
      player2.think();
      game.makeMove(player2.getMoveIWantToMake(), player2.getBoardIWantToPlay());
      isXTurn = true;
    }
    redraw();
  } else {
    redraw();
    resetGame();
  }
  try {
    Thread.sleep(pauseTime / 4);
  } 
  catch(Exception e) {
  }
  if (!isXTurn && !game.isGameOver()) {
    runGame();
  }
}
void drawGame() {
  noStroke();
  fill(200);
  rect(height, 0, width - height, height);
  fill(255);
  rect(0, 0, height, height);
  strokeWeight(5);
  stroke(0);
  drawABoard(bigBorder, bigBorder, bigLength);
  strokeWeight(1);
  stroke(0);
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      drawABoard(bigBorder + i * ((smallBorder * 2) + smallLength) + smallBorder, bigBorder + j * ((smallBorder * 2) + smallLength) + smallBorder, smallLength);
    }
  }
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      for (int k = 0; k < 3; k++) {
        for (int l = 0; l < 3; l++) {
          switch(game.getGameBoards()[i][j].getGameBoard()[k][l]) {
          case '_':
            break;
          case 'X':
            drawX(bigBorder + smallBorder + internalBorder + (j * bigLength * .33333) + (l * smallLength * .33333), bigBorder + smallBorder + internalBorder + (i * bigLength * .33333) + (k * smallLength * .33333), internalLen);
            break;
          case 'O':
            drawO(bigBorder + smallBorder + internalBorder + (j * bigLength * .33333) + (l * smallLength * .33333), bigBorder + smallBorder + internalBorder + (i * bigLength * .33333) + (k * smallLength * .33333), internalLen);
            break;
          }
        }
      }
      switch(game.getGameBoard()[i][j]) {
      case 'X':
        fill(0, 0, 200, 75);
        noStroke();
        rect((j * bigLength * .33333), (i * bigLength * .33333), smallLength + (bigBorder + smallBorder) * 2, smallLength + (bigBorder + smallBorder) * 2);
        break;
      case 'O':
        fill(200, 0, 0, 75);
        noStroke();
        rect((j * bigLength * .33333), (i * bigLength * .33333), smallLength + (bigBorder + smallBorder) * 2, smallLength + (bigBorder + smallBorder) * 2);
        break;
      default:
        if (game.getNumericalGameToPlayIn() == -1 || game.getNumericalGameToPlayIn() == (i * 3) + j) {
          fill(255, 255, 0, 75);
          noStroke();
          rect((j * bigLength * .33333), (i * bigLength * .33333), smallLength + (bigBorder + smallBorder) * 2, smallLength + (bigBorder + smallBorder) * 2);
          break;
        }
      }
    }
  }
  /*
  fill(0);
   stroke(0);
   textSize(24);
   text("Games Played: " + totalGames, (width + height) / 2, bigBorder + bigLength / 6);
   fill(0, 0, 255);
   text("X: " + xPlayer, (width + height) / 2, bigBorder + bigLength / 3);
   float percent = 0;
   if (totalGames != 0) {
   percent = 100 * xWins/totalGames;
   }
   text("Wins: " + xWins + " (" + nf(percent, 2, 1) + "%)", (width + height) / 2, bigBorder + 36 + bigLength / 3);
   fill(255, 0, 0);
   text("O: " + oPlayer, (width + height) / 2, bigBorder + bigLength / 1.5);
   percent = 0;
   if (totalGames != 0) {
   percent = 100 * oWins/totalGames;
   }
   text("Wins: " + oWins + " (" + nf(percent, 2, 1) + "%)", (width + height) / 2, bigBorder + 36 + bigLength / 1.5);
   */
}

void resetGame() {
  totalGames++;
  switch(TTTGame.getWinner(game)) {
  case 1:
    xWins++;
    break;
  case 2:
    oWins++;
    break;
  }
  game.reset();
  isXTurn = true;
}

void drawABoard(int x, int y, int len) {
  line(x + len / 3, y, x + (len / 3), y + len);
  line(x + len / 1.5, y, x + (len / 1.5), y + len);
  line(x, y + len / 3, x + len, y + len / 3);
  line(x, y + len / 1.5, x + len, y + len / 1.5);
}

void drawX(float x, float y, int len) {
  stroke(0, 0, 255);
  strokeWeight(2);
  line(x, y, x + len, y + len);
  line(x + len, y, x, y + len);
}

void drawO(float x, float y, float len) {
  fill(255, 0, 0);
  noStroke();
  ellipse(x, y, len, len);
  fill(255);
  ellipse(x + 2, y + 2, len - 4, len - 4);
  stroke(1);
}

int getSquareHovered() {
  int board = 0;
  int square = 0;
  int xCoor = mouseX - bigBorder, yCoor = mouseY - bigBorder;
  int xBigSquare = xCoor / (bigLength / 3);
  int yBigSquare = yCoor / (bigLength / 3);
  board = yBigSquare * 3 + xBigSquare;
  xCoor -= smallBorder + xBigSquare * (smallBorder + smallBorder + smallLength);
  yCoor -= smallBorder + yBigSquare * (smallBorder + smallBorder + smallLength);
  int xSmallSquare = xCoor / (smallLength / 3);
  int ySmallSquare = yCoor / (smallLength / 3);
  square = ySmallSquare * 3 + xSmallSquare;
  println(board + "   " + square);
  return board * 9 + square;
}