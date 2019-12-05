public class Power_Up {
  float powerX;
  float powerY;
  String power;
 
  Power_Up(float powerUpX, float powerUpY, String powerUp) {
    powerX = powerUpX;
    powerY = powerUpY;
    power = powerUp;
  }
 
  void drawPowerUp() {
    fill(40, 40, 163);
    textSize(25);
    rect(powerX, powerY, width*0.15, height*0.075);
    if (power == "Size") {
      fill(255);
      text("Size Up!", pX, pY+40);
      println("sizeUp");
    }
    if (power == "Speed") {
      fill(255);
      text("More Speed!", pX, pY+40);
      println("Speed");
    }
    if (power == "Size Down") {
      fill(255);
      text("Size Down!", pX, pY+40);
      println("size Down");
    }
    if (power == "Bounce") {
      fill(255);
      text("Bounce!", pX, pY+40);
      println("Jump Around");
    }
  }
}
