void introduction(boolean next){
  if(next == false){
    fill(#FF0000);
    rect(0,80,1280,500);
    textSize(32);
    fill(0);
    text("Welcome to yEEEt and DefEEEt!",380,330);
    textSize(16);
    text("Press anywhere to continue!",500,570);
  }if(next ==true){
    fill(255);
    textSize(16);
    rect(0,80,1280,500);
    textAlign(CENTER, CENTER);
    fill(0);
    text("Place barracks and resource extractors to defend against deadly diseases!",640,210);
    text("Viruses and Bacteria will emerge from the left and the right. Place your cells(troops) to fight back!",640, 230);
    text("Ready? Press anywhere to start!",640,250);
    textSize(12);
    textAlign(BASELINE);
 }
}
