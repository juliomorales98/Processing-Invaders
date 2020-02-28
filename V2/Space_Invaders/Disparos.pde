class Disparo{
  int x;
  int y;
  
  
  Disparo(int _x,int _y){
    x = _x;
    y = _y;
    
  }
  
  int getX(){return x;}
  int getY(){return y;}
  
  boolean dibujar(char op){ 
   rect(x,y,5,5);
   
   if(op == '1'){
      y = y-5;
   
   if(y < 0)
     return true;
   }
  
     
   return false;
  }
}
