final int GAME_START = 0,GAME_RUN = 1,GAME_WIN = 2,GAME_OVER = 3;

int gameState;

PImage startUnHover,startHover;
PImage endUnHover,endHover;

PImage shipImage,treasureImage,enemyImage,hp;
PImage backgroundImage,backgroundImage2;

int enemyPosX1[]=new int[5];
int enemyPosY1[]=new int[5];
int enemyPosX2[]=new int[5];
int enemyPosY2[]=new int[5];;
int enemyPosX3[]=new int[8];
int enemyPosY3[]=new int[8];


int backgroundPos1;//存放背景當前位置
int backgroundPos2;
int treasurePosX,treasurePosY;
int shipCurrentPosX,shipCurrentPosY;

int blood;
int spacing=70;

void setup () {
  size(640,480);
  
  startHover=loadImage("img/start1.png");//開始圖片切換
  startUnHover=loadImage("img/start2.png");
  endUnHover=loadImage("img/end1.png");//結束圖片切換
  endHover=loadImage("img/end2.png");
  treasureImage= loadImage("img/treasure.png"); //載入物品
  shipImage = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  enemyImage=loadImage("img/enemy.png");
  backgroundImage = loadImage("img/bg1.png"); //載入背景
  backgroundImage2 = loadImage("img/bg2.png");
  
  backgroundPos1=width;
  backgroundPos2=0;
  
  treasurePosX=floor(random(width-61));  //寶物隨機位置
  treasurePosY=floor(random(height-61));
  enemyPosX1[0] = 0;  //敵機初始位置
  enemyPosY1[0] = floor(random(height-61));

  for(int i=1;i<5;i++){
    enemyPosX1[i]=enemyPosX1[0]-(spacing*i);
    enemyPosY1[i]=enemyPosY1[0];
  }
 
  enemyPosX2[0] = -width;
  enemyPosY2[0] = floor(random(height-341));
  
  for(int i=1;i<5;i++){
    enemyPosX2[i]=enemyPosX2[0]-(spacing*i);
    enemyPosY2[i]=enemyPosY2[0]+(spacing*i);
  }
  
  
  
  enemyPosX3[0] = -width*2;
  enemyPosY3[0] = floor(random(height-341))+140;
  
  
  //主角初始位置
  shipCurrentPosX=width-65;
  shipCurrentPosY=height/2;
  blood=40;//initialize blood 先假定100
  
  gameState= GAME_START;//預設讀取開始畫面
   
   
}

void draw() {
 
  switch (gameState){
      case GAME_START:
      image(startUnHover,0,0);
       
      // mouse action
      if (mouseY > 370 && mouseY < 410 && mouseX > 200 && mouseX < 460){
        if (mousePressed){
          // click
          gameState = GAME_RUN;
        }else{
          // hover
          image(startHover,0,0);
          
        }
      }
      break;
    

      case GAME_RUN:
  
        //背景移動效果
        image(backgroundImage,backgroundPos1%(width*2)-width,0);
        image(backgroundImage2,backgroundPos2%(width*2)-width,0);
        
        //紅色血條
        rect(15,15,blood,25);
        fill(255,30,0);
        //物品位置
        image(hp,10,10);
        image(treasureImage,treasurePosX,treasurePosY);
        image(shipImage,shipCurrentPosX, shipCurrentPosY);

            
        //處理敵機移動  
        
        for(int i=0;i<5;i++){
        image(enemyImage,enemyPosX1[i]%(width*3),enemyPosY1[i]);//三輪飛機所以x3  
        }
        for(int i=0;i<5;i++){
        image(enemyImage,enemyPosX2[i]%(width*3),enemyPosY2[i]);//三輪飛機所以x3  
        }
        
        //速成菱形
        image(enemyImage,enemyPosX3[0]%(width*3),enemyPosY3[0]);
        image(enemyImage,enemyPosX3%(width*3)-(spacing*1),enemyPosY3+(spacing*1));
        image(enemyImage,enemyPosX3%(width*3)-(spacing*1),enemyPosY3-(spacing*1));
        image(enemyImage,enemyPosX3%(width*3)-(spacing*2),enemyPosY3+(spacing*2));
        image(enemyImage,enemyPosX3%(width*3)-(spacing*2),enemyPosY3-(spacing*2));
        image(enemyImage,enemyPosX3%(width*3)-(spacing*3),enemyPosY3+(spacing*1));
        image(enemyImage,enemyPosX3%(width*3)-(spacing*3),enemyPosY3-(spacing*1));        
        image(enemyImage,enemyPosX3%(width*3)-(spacing*4),enemyPosY3);   
        
        
        //背景,敵機自動移動
        backgroundPos1++;
        backgroundPos2++;
        enemyPosX1+=2;
        enemyPosX2+=2;
        enemyPosX3+=2;
        
        if(enemyPosX1%(width*3)==0){//這邊要小心
        enemyPosY1=floor(random(height-61));
        }
        if(enemyPosX2%(width*3)==0&&enemyPosX2!=0){//這邊要小心
        enemyPosY2=floor(random(height-341));
   
        }
        if(enemyPosX3%(width*3)==0&&enemyPosX3!=0){//這邊要小心
        enemyPosY3=floor(random(height-341))+140;
        }
        
       // println(enemyPosY);
      
      //顯示戰機,寶物當前座標
        //println(shipCurrentPosX+","+shipCurrentPosY);
        //println(treasurePosX+","+treasurePosY);
        //println(enemyPosX%width+","+enemyPosY);
        
      //吃寶物效果
        if( abs(shipCurrentPosX-treasurePosX)<30 && abs(shipCurrentPosY-treasurePosY) <30 ){//要'=='不然判斷式不成立
         if(blood+20<=200){//血量加20(10%)不破表才執行
             blood+=20;//加血10%           
            
            }
      //移動寶物位置
             treasurePosX=floor(random(width-61));
             treasurePosY=floor(random(height-61));
        }
      //撞到戰機效果
        //if( abs(shipCurrentPosX-enemyPosX%width)<30  && abs(shipCurrentPosY-enemyPosY) <30){
        // if(blood>0){//血量減40(20%)還有生命才執行
        //     blood-=40;//扣血20%
        //   if(blood<=0){
        //   gameState = GAME_OVER;
        //   }
        //   else{  
       ////移動敵機位置
        //     enemyPosX=0;
        //     enemyPosY=floor(random(height-61));
        //   }
        // }

        //}
        
        
        break;
        
        case GAME_OVER:
          image(endUnHover,0,0);
          if (mouseY > 300 && mouseY < 340 && mouseX > 200 && mouseX < 430){
        if (mousePressed){
          // click
          gameState = GAME_RUN;
          
            //寶物隨機位置
            treasurePosX=floor(random(width-61));
            treasurePosY=floor(random(height-61));
            
            //敵機初始位置
            enemyPosX1 = 0;
            enemyPosY1 = 350;
            //主角初始位置
            shipCurrentPosX=width-65;
            shipCurrentPosY=height/2;
            blood=40;
            
            backgroundPos1=width;//存放背景當前位置
            backgroundPos2=0;
          
          
        }else{
          // hover
          image(endHover,0,0);
          
        }
      }
      break;

 }// end of switch 
}
void keyPressed(){
 // To make ship move faster,I adjust the dispacement to +-3
  //上下左右 及 加減圖片尺寸
  if (keyCode == UP&shipCurrentPosY>=0) {
    shipCurrentPosY-=4;

  }
   if (keyCode == DOWN&shipCurrentPosY<=height-61) {
    shipCurrentPosY+=4;
  }
   if (keyCode == LEFT&shipCurrentPosX>=0) {
    shipCurrentPosX-=4;
  }
   if (keyCode == RIGHT&shipCurrentPosX<=width-61) {
    shipCurrentPosX+=4;
  }  
}
void keyReleased(){

}
