int gridspacing = 20;
boolean turn = true; //true is human, false is AI
int itemdragged = 0;
boolean dragitem = false;
ArrayList<PVector> oxfield = new ArrayList<PVector>();
ArrayList<PVector> glufield = new ArrayList<PVector>();
ArrayList<PVector> oxgencoor = new ArrayList<PVector>();
ArrayList<oxGen> boi1 = new ArrayList<oxGen>();
ArrayList<PVector> glucoor = new ArrayList<PVector>();
ArrayList<gluGen> boi2 = new ArrayList<gluGen>();
ArrayList<PVector> barrackcoor = new ArrayList<PVector>();
ArrayList<barracks> boi3 = new ArrayList<barracks>();
ArrayList<PVector> heartcoor = new ArrayList<PVector>();
ArrayList<PVector> lungcoor = new ArrayList<PVector>();
ArrayList<PVector> livercoor = new ArrayList<PVector>();
ArrayList<Phagocytes> cellP = new ArrayList<Phagocytes>();
ArrayList<Dendritic> cellD = new ArrayList<Dendritic>();
ArrayList<BCell> cellB = new ArrayList<BCell>();
ArrayList<KillerTCell> cellT = new ArrayList<KillerTCell>();
ArrayList<String> specialization = new ArrayList<String>();
ArrayList<PVector> Pcoor = new ArrayList<PVector>();
ArrayList<PVector> Dcoor = new ArrayList<PVector>();
ArrayList<PVector> Bcoor = new ArrayList<PVector>();
ArrayList<PVector> Tcoor = new ArrayList<PVector>();

ArrayList<PVector> Bactcoor = new ArrayList<PVector>();
ArrayList<bacteria> Bact = new ArrayList<bacteria>();
ArrayList<PVector> Vircoor = new ArrayList<PVector>();
ArrayList<virus> Vir = new ArrayList<virus>();

int[] Celltypes = {0,0,0,0};
int[] bacteriaData = {0,0,0,0};
int[] virusData = {0,0,0,0};
PImage backgroundImage, Toiletimg;
PImage Iconoxy, Iconglu;
PImage Heartimg, Liverimg, Lungsimg;
PImage sta, str, tb, ec, cc, ha, flu, eb;
PImage picon,dicon,bicon,ticon;
int oxygen;
int glucose;
int ap;
boolean placetaken;
boolean finishedturn;
boolean barmenushow = false;
boolean upgradeshow = false;
boolean disableturn = false;
String thisspecialization;
boolean introduction;
boolean next = false;
int selbarrack = 0;
int selox = 0;
int selglu = 0;
int selectStructure;
Heart heart = new Heart(500,500);
Liver liver = new Liver(500,500);
Lungs lungs = new Lungs(500,500);
barracks thisbarrack;

void setup() {
  size(1280, 700);
  backgroundImage = loadImage("Background.jpg");
  Iconoxy = loadImage("Oxygenicon.png");
  Iconglu = loadImage("Glucoseicon.png");
  Heartimg = loadImage("Heart.png");
  Liverimg = loadImage("Liver.png");
  Lungsimg = loadImage("Lungs.png");
  Toiletimg = loadImage("Toilet.png");
  sta = loadImage("sta.png");
  str = loadImage("str.png");
  tb = loadImage("tb.png");
  ec = loadImage("ec.png");
  cc = loadImage("cc.png");
  ha = loadImage("ha.png");
  flu = loadImage("flu.png");
  eb = loadImage("eb.png");
  picon = loadImage("P.png");
  dicon = loadImage("D.png");
  bicon = loadImage("B.png");
  ticon = loadImage("T.png");
  introduction = true;
  frameRate(60);
  glucose = 100;
  oxygen = 100;
  gridsetup();
  evilsetup();
}

void draw() {
  if(introduction){
    introduction(next);
  }else{
    image(backgroundImage, 0, 0); 
    strokeWeight(1);
    fill(#7C0B0B);
    rect(0,0,1280,80);
    rect(0,580,1280,120);
    line(0,80,width,80);
    line(0,580,width,580);
    //background(255);
    //drawgrid();
    deletebox();
    oxybar(oxygen, predoxygen(boi3), 1000);
    glubar(glucose, predglucose(boi3), 1000);
    man1(Celltypes[0],100);
    man2(Celltypes[1],100);
    man3(Celltypes[2],100);
    man4(Celltypes[3],100);
    //man5(Celltypes[0],100);
    showorgans();
    showbois();
    showcells();
    showevil();
    highlightsquare();
    if(oxygen + predoxygen(boi3) < 0 || glucose + predglucose(boi3) < 0){
      disableturn = true;
    }else{
      disableturn = false;
    }
    if(!disableturn){
      if(turn){
        showmenu();
        showbarrackmenu();
        showupgrademenu();
        dragboi(dragitem,itemdragged);
        strokeWeight(1);
        stroke(0);
        fill(255);
        rect(1170,10,100,60,10,10,10,10);
        fill(0);
        text("HUMAN", 1200,50);
        afterTurn(finishedturn, boi1, boi2, heart, lungs, liver);
        generateCells(finishedturn, boi3);
        if(finishedturn){
          finishedturn = false;
          println(lungs.health + " . " + heart.health + " . " + liver.health);
        }
      }else{
        strokeWeight(1);
        stroke(0);
        fill(255);
        rect(1170,10,100,60,10,10,10,10);
        fill(0);
        text("AI", 1200,50);
        for (int i=0; i<Bactcoor.size(); i++) {
          attackOrganBacteria(Bact.get(i), heartcoor, Bactcoor.get(i), heart);
          attackOrganBacteria(Bact.get(i), heartcoor, Bactcoor.get(i), lungs);
          attackOrganBacteria(Bact.get(i), heartcoor, Bactcoor.get(i), liver);
        }
        for (int i=0; i<Vircoor.size(); i++) {
          attackOrganVirus(Vir.get(i), i, heartcoor, Vircoor.get(i), heart);
          attackOrganVirus(Vir.get(i), i, lungcoor, Vircoor.get(i), lungs);
          attackOrganVirus(Vir.get(i), i, livercoor, Vircoor.get(i), liver);
        }
        wave();
        for (int i=0; i<Pcoor.size(); i++) {
          Pcoor.set(i, movementCell(cellP.get(i), Pcoor.get(i)));
          for (int j=0; j<Bactcoor.size(); j++) {
            if (abs(Bactcoor.get(j).x - Pcoor.get(i).x) < 40 && abs(Bactcoor.get(j).y - Pcoor.get(i).y) < 40 ) {
              cellP.get(i).attackBacteria(Bact.get(j));
            }
            if (Bact.get(j).health <= 0) {
              Bact.remove(j);
              Bactcoor.remove(j);
            }
          }
          for (int j=0; j<Vircoor.size(); j++) {
            if (abs(Vircoor.get(j).x - Pcoor.get(i).x) < 40 && abs(Vircoor.get(j).y - Pcoor.get(i).y) < 40 ) {
              cellP.get(i).attackVirus(Vir.get(j));
            }
            if (Vir.get(j).health <= 0) {
              Vir.remove(j);
              Vircoor.remove(j);
            }
          }
        }
        damageovertime();
        //for(int i = 0; i < Pcoor.size(); i++){
        //   Pcoor.set(i,movementCell(cellP.get(i),Pcoor.get(i)));       
        //}
        //for(int i = 0; i < Dcoor.size(); i++){
        //   Dcoor.set(i,movementCell(cellD.get(i),Dcoor.get(i)));       
        //}
        //for(int i = 0; i < Bcoor.size(); i++){
        //   Bcoor.set(i,movementCell(cellB.get(i),Bcoor.get(i)));       
        //}
        //for(int i = 0; i < Tcoor.size(); i++){
        //   Tcoor.set(i,movementCell(cellT.get(i),Tcoor.get(i)));       
        //}
        allattacks();
        killall();
        
      }
    }
    strokeWeight(1);
    stroke(0);
    
    
  }
}

void killall(){
  int index = 0;
  for(PVector copycoor : new ArrayList<PVector>(Bactcoor)){
    if (Bact.get(index).health <= 0) {
      Bactcoor.remove(copycoor);
    }
    index+=1;
  }
  for(bacteria copybact : new ArrayList<bacteria>(Bact)){
    if (copybact.health <= 0) {
      Bact.remove(copybact);
    }
  }
  index = 0;
  for(PVector copyvir : new ArrayList<PVector>(Vircoor)){
    if (Vir.get(index).health <= 0) {
      Vircoor.remove(copyvir);
    }
    index+=1;
  }
  for(virus copyvir : new ArrayList<virus>(Vir)) {
    if (copyvir.health <= 0) {
      Vir.remove(copyvir);
      Vircoor.remove(copyvir);
    }
    index+=1;
  }
}

void allattacks(){
  for (int i=0; i<Pcoor.size(); i++) {
    Pcoor.set(i, movementCell(cellP.get(i), Pcoor.get(i)));
    for (int j=0; j<Bactcoor.size(); j++) {
      if (abs(Bactcoor.get(j).x - Pcoor.get(i).x) < 40 && abs(Bactcoor.get(j).y - Pcoor.get(i).y) < 40 ) {
        cellP.get(i).attackBacteria(Bact.get(j));
      }
    }
    for (int j=0; j<Vircoor.size(); j++) {
      if (abs(Vircoor.get(j).x - Pcoor.get(i).x) < 40 && abs(Vircoor.get(j).y - Pcoor.get(i).y) < 40 ) {
        cellP.get(i).attackVirus(Vir.get(j));
      }
    }
  }

  for (int i = 0; i < Dcoor.size(); i++) {
    Dcoor.set(i, movementCell(cellD.get(i), Dcoor.get(i)));
    for (int j=0; j<Bactcoor.size(); j++) {
      if (abs(Bactcoor.get(j).x - Dcoor.get(i).x) < 40 && abs(Bactcoor.get(j).y - Dcoor.get(i).y) < 40 ) {
        cellD.get(i).attackBacteria(Bact.get(j));
      }
    }
    for (int j=0; j<Vircoor.size(); j++) {
      if (abs(Vircoor.get(j).x - Dcoor.get(i).x) < 40 && abs(Vircoor.get(j).y - Dcoor.get(i).y) < 40 ) {
        cellD.get(i).attackVirus(Vir.get(j));
      }
    }
  }
  for (int i = 0; i < Bcoor.size(); i++) {
    Bcoor.set(i, movementCell(cellB.get(i), Bcoor.get(i)));     
    for (int j=0; j<Bactcoor.size(); j++) {
      if (abs(Bactcoor.get(j).x - Bcoor.get(i).x) < 40 && abs(Bactcoor.get(j).y - Bcoor.get(i).y) < 40 ) {
        cellB.get(i).markBacteria(Bact.get(j));
      }
    }
    for (int j=0; j<Vircoor.size(); j++) {
      if (abs(Vircoor.get(j).x - Bcoor.get(i).x) < 40 && abs(Vircoor.get(j).y - Bcoor.get(i).y) < 40 ) {
        cellB.get(i).markVirus(Vir.get(j));
      }
    }
  }

  for (int i = 0; i < Tcoor.size(); i++) {
    Tcoor.set(i, movementCell(cellT.get(i), Tcoor.get(i)));       
    for (int j=0; j<Bactcoor.size(); j++) {
      if (abs(Bactcoor.get(j).x - Tcoor.get(i).x) < 40 && abs(Bactcoor.get(j).y - Tcoor.get(i).y) < 40 ) {
        cellT.get(i).attackBacteria(Bact.get(j));
      }
    }
    for (int j=0; j<Vircoor.size(); j++) {
      if (abs(Vircoor.get(j).x - Tcoor.get(i).x) < 40 && abs(Vircoor.get(j).y - Tcoor.get(i).y) < 40 ) {
        cellT.get(i).attackVirus(Vir.get(j));
      }
    }
  }
}

void damageovertime(){
  for(bacteria thisbact: Bact){
    thisbact.turndamage(false);
  }
  for (virus thisvir: Vir){
    thisvir.turndamage(false);
  }
  //for (Phagocytes p: cellP){
    
  //}
  //for(Dendritic d: cellD){
  //}
  //for(BCell b: cellB){
  //}
  //for(KillerTCell t: cellT){
  //}
}

void showbois(){
  for (PVector position : oxgencoor) {
    displayboi1(position.x,position.y);
  }
  for (PVector position : glucoor) {
    displayboi2(position.x,position.y);
  }
  for (PVector position : barrackcoor) {
    displayboi3(position.x,position.y);
  }
}

void showcells(){
  for (PVector position : Pcoor) {
    displaycell0(position.x,position.y);
  }
  for (PVector position : Dcoor) {
    displaycell1(position.x,position.y);
  }
  for (PVector position : Bcoor) {
    displaycell2(position.x,position.y);
  }
  for (PVector position : Tcoor) {
    displaycell3(position.x,position.y);
  }
}

void showevil(){
  int index = 0;
  if(Vir.size() != 0){
    for (PVector position : Vircoor) {
      displayvirus(position.x,position.y, Vir.get(index).name);
      index+=1;
    }
  }
  if(Bact.size() != 0){
    index = 0;
    for (PVector position : Bactcoor) {
      displaybact(position.x,position.y, Bact.get(index).name);
      index+=1;
    }
  }
}

void gridsetup(){
  heartgrid();
  lunggrid();
  livergrid();
  oxfieldgrid();
  glufieldgrid();
}

void createresourceareas(){
}

void showbarrackmenu(){
  if(barmenushow){
    strokeWeight(1);
    stroke(0);
    fill(255);
    rect(420,590,400,100,10,10,10,10);
    for(int i = 0; i < 4; i++){
      if(boi3.get(selbarrack).stat == i){
        fill(0,0,255,120);
      }else{
        fill(255);
      }
      if(mouseX > (430 + i*70) && mouseX < (490 + i*70) && mouseY > 600 && mouseY < 680){
        fill(128);
      }
      rect(i*70 + 430, 600, 60,80,10,10,10,10);
    }
  }
}

void showmenu(){
  strokeWeight(1);
  stroke(0);
  fill(255);
  rect(10,590,400,100,10,10,10,10);
  for(int i = 0; i < 3; i++){
    fill(255);
    if(mouseX > (20 + i*70) && mouseX < (80 + i*70) && mouseY > 600 && mouseY < 680){
      fill(128);
    }
    rect(i*70 + 20, 600, 60,80,10,10,10,10);
    if(i == 0){
      displayboi1(i*70 + 50,640);
    }else if(i == 1){
      displayboi2(i*70 + 50,640);
    }else if(i==2){
      displayboi3(i*70 + 50,640);
    }
  }
}

void showupgrademenu(){
  if(upgradeshow){
    strokeWeight(1);
    stroke(0);
    fill(255);
    rect(420,590,100,100,10,10,10,10);
    if(mouseX > 430 && mouseX < 490 && mouseY > 600 && mouseY < 680){
      fill(128);
    }
    rect(430, 600, 60,80,10,10,10,10);
    
    textAlign(CENTER, CENTER);
    fill(0);
    if(selectStructure == 0){
      text(boi1.get(selox).level,460,640);
    }else if(selectStructure == 1){
      text(boi2.get(selglu).level,460,640);
    }
    textAlign(BASELINE);
    
  }
}

void dragboi(boolean drag, int item){
  if(!(mouseY > 580 && mouseX > 420)){
    if(drag){
      if(item == 1){
        displayboi1(mouseX,mouseY);
      }else if(item == 2){
        displayboi2(mouseX,mouseY);
      }else if(item == 3){
        displayboi3(mouseX,mouseY);
      }else if(item == 10){
        displaycell0(mouseX,mouseY);
      }else if(item == 11){
        displaycell1(mouseX,mouseY);
      }else if(item == 12){
        displaycell2(mouseX,mouseY);
      }if(item == 13){
        displaycell3(mouseX,mouseY);
      }
    }
  }else{
    dragitem = false;
  }
}

void mouseClicked(){
  if(introduction){
    if(next){
      introduction = false;
    }else{
      next = true;
    }
  }else{
    if(!(barmenushow && mouseY < 690 && mouseY > 590 && mouseX > 420 && mouseX < 820)){
      barmenushow = false;
    }
    if(!(upgradeshow && mouseY < 690 && mouseY > 590 && mouseX > 420 && mouseX < 820)){
      upgradeshow = false;
    }
    if(mouseX < 1270 && mouseX > 1170 && mouseY > 10 && mouseY < 70){
      if(turn){
        turn = false;
      }else{
        turn = true;
      }
      finishedturn = true;
    }
    
    if(turn){
      if(mouseX > 20 && mouseX < 80 && mouseY > 600 && mouseY < 680){
        dragitem = true;
        itemdragged = 1;
      }
      if(mouseX > 90 && mouseX < 150 && mouseY > 600 && mouseY < 680){
        dragitem = true;
        itemdragged = 2;
      }
      if(mouseX > 160 && mouseX < 220 && mouseY > 600 && mouseY < 680){
        dragitem = true;
        itemdragged = 3;
      }
      if(mouseX > 400 && mouseX < 422 && mouseY > 29 && mouseY < 51){
        dragitem = true;
        itemdragged = 10;
      }
      if(mouseX > 500 && mouseX < 522 && mouseY > 29 && mouseY < 51){
        dragitem = true;
        itemdragged = 11;
      }
      if(mouseX > 600 && mouseX < 622 && mouseY > 29 && mouseY < 51){
        dragitem = true;
        itemdragged = 12;
      }
      if(mouseX > 700 && mouseX < 722 && mouseY > 29 && mouseY < 51){
        dragitem = true;
        itemdragged = 13;
      }
      
      //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
      if(mouseX > 1200 && mouseX < 1260 && mouseY > 600 && mouseY < 680){
        deleteStructure(selectStructure);
      }
      //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
      
      if(barmenushow){
        if(mouseX > 430 && mouseX < 490 && mouseY > 600 && mouseY < 680){
          barracks thisbar = boi3.get(selbarrack);
          thisbar.tuneStat(0);
          boi3.set(selbarrack, thisbar);
        }
        if(mouseX > 500 && mouseX < 560 && mouseY > 600 && mouseY < 680){
          barracks thisbar = boi3.get(selbarrack);
          thisbar.tuneStat(1);
          boi3.set(selbarrack, thisbar);
        }
        if(mouseX > 570 && mouseX < 630 && mouseY > 600 && mouseY < 680){
          barracks thisbar = boi3.get(selbarrack);
          thisbar.tuneStat(2);
          boi3.set(selbarrack, thisbar);
        }
        if(mouseX > 640 && mouseX < 700 && mouseY > 600 && mouseY < 680){
          barracks thisbar = boi3.get(selbarrack);
          thisbar.tuneStat(3);
          boi3.set(selbarrack, thisbar);
        }
        //if(boi3.get(selbarrack).stat == 1){
          
        //}
      }
      
      if(upgradeshow){
        if(mouseX > 430 && mouseX < 490 && mouseY > 600 && mouseY < 680){
          if(selectStructure == 0){
            if(oxygen > boi1.get(selox).genAmount){
              oxGen thisox = boi1.get(selox);
              levelUpOxy(thisox);
              boi1.set(selox, thisox);
            }
          }else if(selectStructure == 1){
            if(glucose > boi2.get(selglu).genAmount){
              gluGen thisglu = boi2.get(selglu);
              levelUpGlu(thisglu);
              boi2.set(selglu, thisglu);
            }
          }  
        }
      }
      int index = 0;
      for (PVector oxpos : oxgencoor) {
        if(mouseX > (oxpos.x - gridspacing/2) && mouseX < (oxpos.x + gridspacing/2) && mouseY > (oxpos.y - gridspacing/2) && mouseY < (oxpos.y + gridspacing/2)){
          upgradeshow = true;
          selectStructure = 0;
          selox = index;
        }
        index = index + 1;
      }
      index = 0;
      for (PVector glupos : glucoor) {
        if(mouseX > (glupos.x - gridspacing/2) && mouseX < (glupos.x + gridspacing/2) && mouseY > (glupos.y - gridspacing/2) && mouseY < (glupos.y + gridspacing/2)){
          upgradeshow = true;
          selectStructure = 1;
          selglu = index;
        }
        index = index + 1;
      }
      index = 0;
      for (PVector barrackpos : barrackcoor) {
        if(mouseX > (barrackpos.x - gridspacing/2) && mouseX < (barrackpos.x + gridspacing/2) && mouseY > (barrackpos.y - gridspacing/2) && mouseY < (barrackpos.y + gridspacing/2)){
          barmenushow = true;
          selectStructure = 2;
          selbarrack = index;
        }
        index = index + 1;
      }
      
      //ADDS BOIS
      if(mouseY < 580 && mouseY > 80){
        if(dragitem == true){
          placetaken = false;
          PVector placed = new PVector(mouseX - mouseX % gridspacing + gridspacing/2, mouseY - mouseY % gridspacing + gridspacing/2);
          if(oxgencoor.indexOf(placed) != -1){
            placetaken = true;
          }
          if(glucoor.indexOf(placed) != -1){
            placetaken = true;
          }
          if(barrackcoor.indexOf(placed) != -1){
            placetaken = true;
          }
          if(lungcoor.indexOf(placed) != -1){
            placetaken = true;
          }
          if(livercoor.indexOf(placed) != -1){
            placetaken = true;
          }
          if(heartcoor.indexOf(placed) != -1){
            placetaken = true;
          }
          if(Pcoor.indexOf(placed) != -1){
            placetaken = true;
          }
          if(Dcoor.indexOf(placed) != -1){
            placetaken = true;
          }
          if(Bcoor.indexOf(placed) != -1){
            placetaken = true;
          }
          if(Tcoor.indexOf(placed) != -1){
            placetaken = true;
          }
          if(!placetaken){
            if(itemdragged == 1){
              if(oxfield.indexOf(placed) >= 0){
                if(oxygen >= oxgencost){
                  oxgencoor.add(placed);
                  oxGen newoxgen = buyOxgen();
                  boi1.add(newoxgen);
                }
              }
            }else if(itemdragged == 2){
              if(glufield.indexOf(placed) >= 0){
                if(glucose >= glugencost){
                  glucoor.add(placed);
                  gluGen newglu = buyGlucose();
                  boi2.add(newglu);
                }
              }
            }else if(itemdragged == 3){
              if(glucose >= barcost && oxygen >= barcost){
                barrackcoor.add(placed);
                barracks newbar = buyBarracks();
                boi3.add(newbar);
                barmenushow = true;
                selbarrack = boi3.size()-1;
                thisbarrack = newbar;
              }
            }else if(itemdragged == 10){
              if(Celltypes[0] > 0 && oxygen >= 5 && glucose >= 5){
                Pcoor.add(placed);
                Phagocytes newglu = new Phagocytes(3,10,1,1,false);
                cellP.add(newglu);
                Celltypes[0]-=1;
              }
            }else if(itemdragged == 11){
              if(Celltypes[1] > 0 && oxygen >= 5 && glucose >= 5){
                Dcoor.add(placed);
                Dendritic newglu = new Dendritic(3,10,1,1,false);
                cellD.add(newglu);
                Celltypes[1]-=1;
              }
            }else if(itemdragged == 12){
              if(Celltypes[2] > 0 && oxygen >= 5 && glucose >= 5){
                Bcoor.add(placed);
                BCell newglu = new BCell(3,10,1,1,false);
                cellB.add(newglu);
                Celltypes[2]-=1;
              }
            }else if(itemdragged == 13){
              if(Celltypes[3] > 0 && oxygen >= 5 && glucose >= 5){
                Tcoor.add(placed);
                KillerTCell newglu = new KillerTCell(3,10,1,1,false,thisspecialization);
                specialization.add(thisspecialization );
                cellT.add(newglu);
                Celltypes[3]-=1;
              }
            }
          }
          dragitem = false;
        }
      }
    }
  }
}
