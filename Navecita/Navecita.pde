import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

void setup(){
  size(600,600);
  background(1);
  inicializarListas();
}
int navex = 300,navey = 510;
int vidas = 3,puntos = 0;
int mov = 0;
char lado = 'l';
int ammo = 90;
int contadorRegen = 0;
boolean pause = false;
/*class Arma{
  int ammo;
  
}*/
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
    fill(240);
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
//Definimos asteroides y lista de asteroides
List<Disparo> disparos;
List<Asteroide> asteroides;
Asteroide as1;
Asteroide as2;
Asteroide as3;
Asteroide as4;
Asteroide as5;

void inicializarListas(){
  asteroides = new ArrayList<Asteroide>();
  
  as1 = new Asteroide();
  as2 = new Asteroide();
  as3 = new Asteroide();
  as4 = new Asteroide();
  as5 = new Asteroide();
  
  agregarAsteroides();
  
  disparos = new ArrayList<Disparo>();
  
}

void agregarAsteroides(){
    if(asteroides.size() >= 5)
      return;
   
    asteroides.add(as1);
    asteroides.add(as2);
    asteroides.add(as3);
    asteroides.add(as4);
    asteroides.add(as5);
}
void reset(){ 
   
   inicializarListas();
   navex = 300;
   navey = 510;
   vidas = 3;
   ammo = 90;
   contadorRegen = 0;
   puntos = 0;
   keyCode = 2;
}
void dibujarEscenario(){
  
  fill(240);
  rect(10,540,100,50);
  
  rect(490,540,100,50);
  
  //Vidas
  fill(1);
  text("Vidas: ",11,555);
  text(vidas,50,555);
  
  //Puntos
  text("Puntos: ",11,580);
  text(puntos,60,580);
  
  //Gun
  text("Pistola",491,555);
  for(int x = 1;x<=ammo;x++)
    text("|",x+491,580);
  
  fill(240);  
  textSize(30);
  
  if(vidas > 0){
    if(pause == false)
    text("SPACE INVADERS",150,580);
  else if(vidas > 0)
    text("PAUSE",250,580);
  }
  
 
      

  textSize(12);
  
}


void gameOver(){
    
    /*fill(1);
    rect(111,540,389,200);*/
    fill(255);    
    textSize(30);
    text("PERDISTE",250,580);
    textSize(12);
    
    for(int i=0;i<asteroides.size();i++){
   asteroides.get(i).dibujar('0');
    }  
    
    for(int i=0;i<disparos.size();i++)
    if(disparos.get(i).dibujar('0') == true){
      disparos.remove(i);
    }
    
      triangle(navex,navey,navex-30,navey+30,navex+30,navey+30);

    
    if(keyCode == ENTER)
      reset();
}
void draw(){
  background(1);
  dibujarEscenario();
  textSize(12);
   
  
  
  if(vidas == 0){    
      gameOver();  
      return;    
  }
   
      
  
  triangle(navex,navey,navex-30,navey+30,navex+30,navey+30);
  
  if(pause == true){
    
   if(keyCode == ENTER){
     pause = false;
     keyCode = 2;
   }
     
     for(int i=0;i<asteroides.size();i++){
   asteroides.get(i).dibujar('0');
    }  
    
    for(int i=0;i<disparos.size();i++)
    if(disparos.get(i).dibujar('0') == true){
      disparos.remove(i);
    }
    
  }else{
    
   for(int i=0;i<asteroides.size();i++){
   asteroides.get(i).dibujar('1');
  }
  
  for(int i=0;i<disparos.size();i++)
    if(disparos.get(i).dibujar('1') == true){
      disparos.remove(i);
    }
    
    
  if(keyPressed == true){
    if(keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT){
      if(keyCode == UP){        
        mov = UP;
      }    
      else if(keyCode == DOWN){       
        mov = DOWN;
      }    
      else if(keyCode == LEFT){      
        mov = LEFT;
      }    
      else if(keyCode == RIGHT){       
        mov = RIGHT;
      }
    }
  }else if(keyCode == 'A'){
    Disparo d;
    keyCode   = 0;
    
    if(ammo > 0){
     if(lado == 'l'){
      d = new Disparo(navex-30,navey+30);
      lado = 'd';       
    }      
    else{
      d = new Disparo(navex+30,navey+30);
      lado = 'l';
    }
    
    disparos.add(d);    
    ammo -= 2;
    if(ammo < 0)
      ammo = 0;
    }
    contadorRegen = 0;
  }else if(keyCode == ENTER){
    pause = true; 
    keyCode = 2; 
  }
  
  if(mov == UP){
        if(navey-3 >= 0)
        navey -= 3;
        mov = UP;
      }    
      else if(mov == DOWN){
        if(navey+33 <= 540)
        navey += 3;
        mov = DOWN;
      }    
      else if(mov == LEFT){
        if(navex-33 >= 0)
        navex -= 3;
        mov = LEFT;
      }    
      else if(mov == RIGHT){
        if(navex+33 <= 600)
        navex += 3;
        mov = RIGHT;
      }  
 
  
  //Detectando colisiones
  for(int i=0;i<asteroides.size();i++){
    //Validando colision con nave
    int x = asteroides.get(i).getX();
    int y = asteroides.get(i).getY();
    
    if(x >= navex-30 && x <= navex+30 && y >= navey && y <= navey+30){
      vidas--;
      
     if(vidas > 0){
       asteroides.get(i).setX((int)random(600));
       asteroides.get(i).setY((int)random(20));
     }
     
      
    }
    //Valindando Colision con Disparos
    for(int j=0;j<disparos.size();j++){
      int xD = disparos.get(j).getX();
      int yD = disparos.get(j).getY();
      
      if(xD >= x && xD <= x+10 && yD >= y && yD <= y+10){
        asteroides.get(i).setX((int)random(600));
        asteroides.get(i).setY((int)random(20));
        disparos.remove(j);
        puntos += 10;
        if((puntos%100) == 0)
          vidas++;
      }
    }
  }
  
   if(contadorRegen == 90 && ammo < 90){
    ammo += 15;
    contadorRegen = 0;
    if(ammo > 90)
      ammo = 90;
  }else if(contadorRegen < 90)
    contadorRegen++;
    
  }  
 
   
}
  
  
