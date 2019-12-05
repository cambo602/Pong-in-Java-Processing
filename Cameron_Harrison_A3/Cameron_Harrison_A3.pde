/* ***********
 Cameron Harrison
 ICS 3U1
 Pong Part 6/7
 Pong Game 
 October 17th 2019
 *********** */

/*
TO DO LIST:
 Clean everything up (Remove bugs, generally make things look nicer)
 */


// These var's will be for moving the paddles, and the ball
int paddleOneY = 0;
int paddleOneYSpeed = 0;

int paddleTwoY = 0;
int paddleTwoYSpeed = 0;

// Changes the size of paddles if a size up/down power up is hit
int sizeChangeOne = 0;
int sizeChangeTwo = 0;

// Is set to false if the player chooses an AI rather than a second player
boolean p2On = true;

// X, Y Pos of the ball
int ballY = 0;
int ballX = 0;

// Array that chooses random speeds for the ball 
int numbers[] = {-10, -9, -8, -6, 5, 5, 6, 7, 8, 9, 10};

// Speed of ball  
float ballXSpeed = 0;
float ballYSpeed = 0;

// Stores each players goals
int p1Goals = 0;
int p2Goals = 0;

// Gamestate var (gameState 0 = main menu, 1 = the game, 2 = settings, 3 = Instructions, 4 = game over
int gameState = 0;

// Var to choose random power up
int randomPower = 0;

// Game Timers / Power up timer
int timer = 3600;
int powerTimer = 600;
int powerTimerTwo = 0;

// To only allow a certain method to run once 
boolean allowOnce = true;

// To only run timer if game is being played
boolean gameOn = false;

// Power up types for the construct class
Power_Up sizeUp;
Power_Up speed;
Power_Up sizeDown;
Power_Up beegBall;

// For random power up pos
float pX = 0;
float pY = 0;



void setup() {
  size(1000, 1000);
  background(0);
  surface.setResizable(true);
  rectMode(CORNER);
  ellipseMode(CENTER);
}

void keyPressed() {
  // Paddle Movement
  if (key == 'w') {
    paddleOneYSpeed = -6;
  }
  if (key == 's') {
    paddleOneYSpeed = 6;
  }
  if (p2On) {
    if (keyCode == 38) {
      paddleTwoYSpeed = -6;
    }
    if (keyCode == 40) {
      paddleTwoYSpeed = 6;
    }
  }
  if (gameState == 2 || gameState == 3) {
    if (key == 'b') {
      gameState = 0;
    }
  }
  // Starts moving ball, can only run once, unless a goal is scored
  if (allowOnce) {
    if (gameState == 1) {
      if (keyCode == 32) {
        int t  = round(random(0, 9));
        ballYSpeed = numbers[t];
        int r = round(random(0, 9));
        ballXSpeed = numbers[r];
        if (ballXSpeed == ballYSpeed) {
          ballXSpeed += 2;
        }
        allowOnce = false;
        gameOn = true;
      }
    }
  }
  if (gameState == 4) {
    if (key == 'r') {
      gameState = 0; 
      timer = 3600;
      p1Goals = 0;
      p2Goals = 0;
      sizeChangeOne = 0;
      sizeChangeTwo = 0;
      ballXSpeed = 0;
      ballYSpeed = 0;
      ballX = 0;
      ballY = 0;
      allowOnce = true;
      gameOn = false;
    }
  }
}

void keyReleased() {
  // Removes paddle movement when button released
  if (key == 'w') {
    paddleOneYSpeed = 0;
  }
  if (key == 's') {
    paddleOneYSpeed = 0;
  }
  if (p2On) {
    if (keyCode == 38) {
      paddleTwoYSpeed = 0;
    }
    if (keyCode == 40) {
      paddleTwoYSpeed = 0;
    }
  }
}

void paddleOne(int y, int s) {
  // Draws the first paddle
  fill(0, 255, 0);
  rect(width*0.05, (height*0.4)+y, width*0.05, (height*0.2)+s);
}

void paddleTwo(int y, int s) {
  // Draws the second paddle
  fill(255, 0, 0);
  rect(width*0.90, (height*0.4)+y, width*0.05, (height*0.2)+s);
}

void ball() {
  // Draws the ball
  fill(255, 255, 255);
  ellipse((width/2)+ballX, (height/2)+ballY, width*0.025, width*0.025);
}

// Detects button pressed
void mousePressed() {
  if (gameState == 0) {
    // For Play button
    if (mouseX > width*0.4 && mouseX < (width*0.4)+(width*0.2)) {
      if (mouseY > height*0.25 && mouseY < (height*0.2)+(height*0.1)) {
        gameState = 1;
      }
      if (mouseX > width*0.4 && mouseX < (width*0.4) + (width*0.2)) {
        if (mouseY > height*0.4 && mouseY < (height*0.4) + (height *0.1)) {
          gameState = 2;
        }
      }
      if (mouseX > width*0.4 && mouseX < (width*0.4) + (width*0.2)) {
        if (mouseY > height*0.55 && mouseY < (height*0.55) + (height *0.1)) {
          gameState = 3;
        }
      }
    }
  }
  if (gameState == 2) {
    if (timer > (30*60)) {
      if (mouseX > width*0.21 && mouseX < (width*0.21) + (width*0.2)) {
        if (mouseY > height*0.3 && mouseY < (height*0.3) + (height*0.1)) {
          timer -= (30 * 60);
        }
      }
    }
    if (mouseX > width*0.6 && mouseX < (width*0.6) + (width*0.2)) {
      if (mouseY > height*0.3 && mouseY < (height*0.3) + (height*0.1)) {
        timer += (60 * 60);
      }
    }
    if (mouseX > width*0.6 && mouseX < (width*0.6) + (width*0.2)) {
      if (mouseY > height*0.6 && mouseY < (height*0.6) + (height*0.1)) {
        p2On = true;
      }
    }
    if (mouseX > width*0.6 && mouseX < (width*0.6) + (width*0.2)) {
      if (mouseY > height*0.6 && mouseY < (height*0.6) + (height*0.1)) {
        p2On = false;
      }
    }
  }
}

// Draws instructions menu
void instructions() {
  fill(255);
  textSize(19);
  text("Use the W, and S keys (or UP, and DOWN if player 2) to score as many points as possible within the time limit  ", width*0.01, height *0.25);
  textSize(30);
  text("Press 'B' to return to main menu", width*0.25, height *0.8);
}

void gameSettings() {
  fill(255, 255, 255);
  text("Settings", width*0.45, height*0.1);
  textSize(30);
  text("Change Game Timer (Current game time is" + " " + timer/60 + " " + "seconds)", width*0.1, height *0.25);
  fill(30, 240, 20);
  rect(width*0.2, height*0.3, width*0.2, height*0.1);
  fill(255);
  text("-30 Seconds", width*0.21, height*0.36);
  fill(30, 240, 20);
  rect(width*0.6, height*0.3, width*0.2, height*0.1);
  fill(255);
  text("+60 Seconds", width*0.61, height*0.36);
  text("Select Second Player or AI", width*0.3, height *0.5);
  fill(30, 240, 20);
  rect(width*0.2, height*0.6, width*0.2, height*0.1);
  fill(255);
  text("Second Player", width*0.2, height*0.66);
  fill(30, 240, 20);
  rect(width*0.6, height*0.6, width*0.2, height*0.1);
  fill(255);
  text("BOT / AI", width*0.64, height*0.66);
  text("Press 'B' to return to main menu", width*0.25, height *0.8);
}

// draws main menu
void mainMenu() {
  // Title
  fill(255, 255, 255);
  textSize(75);
  text("Pong 2: Electric Boogaloo", width*0.01, height*0.1);
  fill(30, 240, 20);
  textSize(50);
  // Play Button
  rect(width*0.4, height*0.25, width*0.2, height*0.1);
  fill(0);
  text("Play!", width*0.445, height*0.32);
  // Settings Button
  fill(30, 240, 20);
  rect(width*0.4, height*0.4, width*0.2, height*0.1);
  fill(0);
  textSize(40);
  text("Settings", width*0.41, height*0.47);
  // Instructions Button
  fill(30, 240, 20);
  rect(width*0.4, height*0.55, width*0.2, height*0.1);
  fill(0);
  textSize(30);
  text("Instructions", width*0.4, height*0.62);
}

void draw() {
  background(0);
  if (gameState == 0) {
    mainMenu();
  }
  // For the end game to check who wins/ if a tie
  if (timer == 0 || timer < 0) {
    if (p1Goals > p2Goals) {
      textSize(100);
      text("Player 1 wins!", width*0.15, height*0.3);
      textSize(50);
      text("Press 'r' to return to the menu", width*0.15, height*0.6);
      gameState = 4;
    } 
    if (p2Goals > p1Goals) {
      textSize(100);
      text("Player 2 wins!", width*0.15, height*0.3);
      textSize(50);
      text("Press 'r' to return to the menu", width*0.15, height*0.6);
      gameState = 4;
    } 
    if (p1Goals == p2Goals) {
      textSize(100);
      fill(255);
      text("The Game is a Tie!", width*0.1, height*0.3);
      textSize(50);
      text("Press 'r' to return to the menu", width*0.15, height*0.6);
      gameState = 4;
      println("Swag");
    }
  }
  if (gameState == 2) {
    gameSettings();
  }
  if (gameState == 3) {
    instructions();
  }
  if (gameState == 1) {
    if (p2On == false) {
      if (((height*0.4)+paddleTwoY)+((height*0.2)/2) == (height/2)+ballY) {
        paddleTwoYSpeed = 0;
      }
      // For when ball is moving away from AI
      if (ballXSpeed < 0) {
        if (((height*0.4)+paddleTwoY)+((height*0.2/2)) > (height/2)+ballY) {
          paddleTwoYSpeed = -4;
        }
        // For when ball is moving towards the AI
        if (((height*0.4)+paddleTwoY)+((height*0.2)/2) < (height/2)+ballY) {
          paddleTwoYSpeed = 4;
        }
      }
      if (ballXSpeed > 0) {
        if (((height*0.4)+paddleTwoY)+((height*0.2)/2) > (height/2)+ballY) {
          paddleTwoYSpeed = -6;
        }
        if (((height*0.4)+paddleTwoY)+((height*0.2)/2) < (height/2)+ballY) {
          paddleTwoYSpeed = 6;
        }
      }
    }
    if (gameOn) {
      timer--;
      powerTimer --;
      if (timer <= 0) {
        gameOn = false;
      }
    }
    if (powerTimer == 0) {
      randomPower = round(random(1, 4));
      pX = width*random(0.3, 0.7);
      pY = height*random(0.1, 0.9);
    }
    // When the power time is reduced to 0, a power up will spawn from the public class at a random point on the screen
    if (powerTimer < 0) {
      int whatPower = 0;
      if (randomPower == 1) {
        sizeUp = new Power_Up(pX, pY, "Size");
        sizeUp.drawPowerUp();
        whatPower = 1;
      }
      if (randomPower == 2) {
        speed = new Power_Up(pX, pY, "Speed");
        speed.drawPowerUp();
        whatPower = 2;
      }
      if (randomPower == 3) {
        sizeDown = new Power_Up(pX, pY, "Size Down");
        sizeDown.drawPowerUp();
        whatPower = 3;
      }
      if (randomPower == 4) {
        beegBall = new Power_Up(pX, pY, "Bounce");
        beegBall.drawPowerUp();
        whatPower = 4;
      }
      /* if (randomPower == 1) {
       sizeUp = new Power_Up(100, 100, "Size");
       sizeUp.drawPowerUp();
       } */

      powerTimerTwo--;
      if (powerTimerTwo == 0) {
        powerTimer = 600;
        sizeChangeOne = 0;
        sizeChangeTwo = 0;
      }
      // Checks if the ball touches the power up boxes 
      if ((width/2)+ballX > pX && (width/2)+ballX < pX+( width*0.15)) {
        if ((width/2)+ballY > pY && (width/2)+ballY < pY + (height*0.075)) {
          println("touched");
          // checks what power is touched than makes the effect of the power happen
          if (whatPower == 1) {
            if (ballXSpeed > 0) {
              powerTimerTwo = 300;
              sizeChangeOne = 100;
              powerTimer = 900;
            }
          }
          if (whatPower == 1) {
            if (ballXSpeed < 0) {
              powerTimerTwo = 300;
              sizeChangeTwo = 100;
              powerTimer = 900;
            }
          }
          if (ballXSpeed > 0) {
            if (whatPower == 2) {
              ballXSpeed += 3;
              ballYSpeed += 3;
              powerTimer = 900;
            }
          }
          if (ballXSpeed < 0) {
            if (whatPower == 2) {
              ballXSpeed -= 3;
              ballYSpeed -= 3;
              powerTimer = 900;
            }
          }
          if (whatPower == 3) {
            if (ballXSpeed > 0) {
              powerTimerTwo = 300;
              sizeChangeTwo = -50;
              powerTimer = 900;
            }
          }
          if (whatPower == 3) {
            if (ballXSpeed < 0) {
              sizeChangeOne = -50;
              powerTimer = 900;
            }
          }
          if (whatPower == 4) {
            ballYSpeed = -ballYSpeed;
            powerTimer = 600;
          }
        }
      }
    }
    // Checks for paddles leaving screen, and stops it, and bounce the paddles back slighlty to stop them from geetting stuck
    if ((height*0.4) + paddleOneY <= -4) {
      paddleOneY += 6;
      paddleOneYSpeed = 0;
    }
    if (((height*0.4) + paddleOneY) + (height*0.2)+sizeChangeOne >= height) {
      paddleOneY -= 6;
      paddleOneYSpeed = 0;
    }
    if ((height*0.4) + paddleTwoY <= -4) {
      paddleTwoY += 6;
      paddleTwoYSpeed = 0;
    }
    if (((height*0.4) + paddleTwoY) + (height*0.2)+sizeChangeTwo >= height) {
      paddleTwoY -= 6;
      paddleTwoYSpeed = 0;
    }
    // Top / Bottom Detection. Reverses the Y direction to replicate a bounce
    if ((height/2)+ballY <= 0 + width*0.025) {
      ballYSpeed = -ballYSpeed;
    }
    if ((height/2)+ballY >= height - width*0.025) {
      ballYSpeed = -ballYSpeed;
    } 
    // Left / Right Detection. Resets ball to center and allows "allowOnce" to re run when space is pressed, and add a goal for the player who scored, return the players to the center and reset each players size
    if ((width/2)+ballX <= 0 + width*0.025) {
      p2Goals++;
      ballX = 0;
      ballY = 0;
      ballXSpeed = 0;
      ballYSpeed = 0;
      allowOnce = true;
      gameOn = false;
      paddleOneY = 0;
      paddleOneYSpeed = 0;
      paddleTwoY = 0;
      paddleTwoYSpeed = 0;
      sizeChangeOne = 0;
      sizeChangeTwo = 0;
    } 
    if ((width/2)+ballX >= width - width*0.025) {
      p1Goals++;
      ballX = 0;
      ballY = 0;
      ballXSpeed = 0;
      ballYSpeed = 0;
      allowOnce = true;
      gameOn = false;
      paddleOneY = 0;
      paddleOneYSpeed = 0;
      paddleTwoY = 0;
      paddleTwoYSpeed = 0;
      sizeChangeOne = 0;
      sizeChangeTwo = 0;
    } 

    // To check if ball hits either paddle, and slightly speeds up the ball, while sending it in a slighlty different direction
    // For Paddle One
    // Checks X of ball compared to X of paddle one
    if (((width/2)+ballX) <= (width*0.05)+(height*0.05) && ((width/2)+ballX) >= (width*0.05)+(height*0.05)-10 ) {
      //Check Y of ball compared to Y of paddle one 
      if ((height/2)+ballY > (height*0.4)+paddleOneY && (height/2)+ballY < ((height*0.4)+paddleOneY)+(height*0.2) + sizeChangeOne) {
        ballXSpeed = -ballXSpeed;
        if (ballXSpeed < 0) {
          ballXSpeed -= random(0.1, 0.5);
          ;
        }
        if (ballXSpeed > 0) {
          ballXSpeed += random(0.1, 0.5);
        }
        if (ballYSpeed < 0) {
          ballYSpeed -= random(0.1, 0.5);
        }
        if (ballYSpeed > 0) {
          ballYSpeed += random(0.1, 0.5);
        }
        if (ballYSpeed == 0) {
          ballYSpeed += random(-0.25, 0.25);
        }
      }
    }
    // For Paddle Two
    // Checks X of ball compared to X of paddle Two
    if (((width/2)+ballX) >= (width*0.9) && ((width/2)+ballX) <= (width*0.9)+10) {
      //Check Y of ball compared to Y of paddle one 
      if ((height/2)+ballY > (height*0.4)+paddleTwoY && (height/2)+ballY < ((height*0.4)+paddleTwoY)+(height*0.2)+sizeChangeTwo) {
        ballXSpeed = -ballXSpeed;
        if (ballXSpeed < 0) {
          ballXSpeed -= random(0.1, 0.5);
          ;
        }
        if (ballXSpeed > 0) {
          ballXSpeed += random(0.1, 0.5);
        }
        if (ballYSpeed < 0) {
          ballYSpeed -= random(0.1, 0.5);
        }
        if (ballYSpeed > 0) {
          ballYSpeed += random(0.1, 0.5);
        }
        if (ballYSpeed == 0) {
          ballYSpeed += random(-0.25, 0.25);
        }
      }
    }

    // Text For score board
    textSize(150);
    fill(255, 255, 255);
    text(p1Goals, width*0.2, height*0.15);
    text("-", width*0.483, height*0.15);
    textSize(75);
    text(timer/60, width*0.46, height*0.25);
    textSize(150);
    text(p2Goals, width*0.7, height*0.15);

    // Updates pos
    paddleOneY += paddleOneYSpeed;
    paddleTwoY += paddleTwoYSpeed;
    ballX += ballXSpeed;
    ballY += ballYSpeed;

    // draws objects
    ball();
    paddleOne(paddleOneY, sizeChangeOne);
    paddleTwo(paddleTwoY, sizeChangeTwo);
  }
}
