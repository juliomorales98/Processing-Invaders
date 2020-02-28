class Asteroide{
  int x;
  int y;
  
  Asteroide(){
   x = (int)random(600);
   y = -10;
  }
  
  int getX(){return x;}
  int getY(){return y;}
  
  
  void setX(int _x){x = _x;}
  void setY(int _y){y = _y;}
  
  void dibujar(char op){
    //fill(240);
    ellipseMode(CORNER);
    ellipse(x,y,10,10);
    
    if(op == '1'){
      if(y >= 540){
        y = (int)random(20);
        x = (int)random(600);
      }      
      else
      y = y+8;  
    }
      
  }
}
