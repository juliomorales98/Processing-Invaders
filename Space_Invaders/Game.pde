import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;
import ddf.minim.*;//Librería para sonidos

Minim soundengine;
AudioSample endGameSound;
AudioSample disparoSound;
AudioSample backGroundSound;
class Juego{
  
  int navex = 300,navey = 510;
  int vidas,puntos,cantidadAsteroides,ammo,mov,contadorRegen;
  char lado;
  boolean pause,gameOver;
  boolean asteroidesCompletos;
  List<Disparo> disparos;
  List<Asteroide> asteroides;
  boolean musicaPlaying;
  
  
  Juego(int dificultad,int _vidas){
    vidas = _vidas;
    puntos = 0;
    
    if(dificultad == 0)
      cantidadAsteroides = 5;
    else if(dificultad == 1)
      cantidadAsteroides = 10;
    else if(dificultad == 2)
      cantidadAsteroides = 15;
      
    ammo = 90;
    mov = 0;
    contadorRegen = 0;
    lado = 'l';
    pause = false;
    gameOver = false;
    asteroidesCompletos = false;
    musicaPlaying = false;
    
    asteroides = new ArrayList<Asteroide>();
    disparos = new ArrayList<Disparo>();
    
    
    
  }
  
  void agregarAsteroide(){
    if(!asteroidesCompletos && asteroides.size() < cantidadAsteroides){
    Asteroide as = new Asteroide();
    asteroides.add(as);
    }else
      asteroidesCompletos = true;
    
    
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
  fill(0,4,255);
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

boolean gameOver(){   
    fill(255);    
    textSize(30);
    text("PERDISTE",250,580);
    textSize(12);   
    
    dibujarDisparosAsteroides('0');    
    dibujarNave();
    
   if(keyCode == ENTER)
    return true;
    
   
   return false;
}

void dibujarDisparosAsteroides(char op){
  
  fill(109,74,38);
  for(int i=0;i<asteroides.size();i++){
   asteroides.get(i).dibujar(op);
    }  
    
    fill(250,61,61);
    for(int i=0;i<disparos.size();i++)
    if(disparos.get(i).dibujar(op) == true){
      disparos.remove(i);
    }
}

void dibujarNave(){
    fill(190,190,190);
    triangle(navex,navey,navex-30,navey+30,navex+30,navey+30);
    rect(navex-30,navey+20,5,10);
    rect(navex+25,navey+20,5,10);
    fill(12,130,242);
    triangle(navex,navey+5,navex-10,navey+15,navex+10,navey+15);
    
    
}
void setup(){
  background(0);
  size(600,600);
  
}

boolean draw(){
  background(1);
  dibujarEscenario();
  textSize(12);  
  
  if(gameOver == true){    
      if(gameOver() == true)
      return true;    
  }else{
    dibujarNave();
  if(pause == true){//Si el juego esta en pausa
    
   if(keyCode == ENTER){
     pause = false;
     keyCode = 2;
   }
   
    dibujarDisparosAsteroides('0');
  }else{//Si el Juego no está en pausa  
  
  if(!musicaPlaying){
      backGroundSound.trigger();
      musicaPlaying = true;
  }
  
  if(!asteroidesCompletos)
    agregarAsteroide();
  dibujarDisparosAsteroides('1');
 
 /*
 DETECTANDO TECLAS
 */
 
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
     
     disparoSound.trigger();
      
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
  
  /*
  MOVIMIENTO
  */
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
 
  /*
  Detectando colisiones NAVE v Asteroides
  */
  
  for(int i=0;i<asteroides.size();i++){
    //Validando colision con nave
    int x = asteroides.get(i).getX();
    int y = asteroides.get(i).getY();
    
    if(x >= navex-30 && x <= navex+30 && y >= navey && y <= navey+30){
      vidas--;
      
     if(vidas > 0){
       asteroides.get(i).setX((int)random(600));
       asteroides.get(i).setY((int)random(20));
     }else{
       gameOver = true;
       endGameSound.trigger();
       backGroundSound.stop();
       return false;
     }
       
     
      
    }
     /*
  Detectando colisiones Disparos v Asteroides
  */
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
  
  
  /*
  REGENERACION ARMA
  */
  
   if(contadorRegen == 90 && ammo < 90){
    ammo += 15;
    contadorRegen = 0;
    if(ammo > 90)
      ammo = 90;
  }else if(contadorRegen < 90)
    contadorRegen++;
    

  }
    return false;
  }      
  
  return false;

  }

}
