/*import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;*/
import ddf.minim.*;

Juego game;
boolean menuPrincipal = true;
boolean menuConfiguracion = false;
boolean gameOn = false;
int posY = 300;
int opcion = 1;
int vidas = 3;
String[] dificultades = {"Facil","Medio","Dificil"};
int opcionDificultad = 0;
AudioSample cambiarIndexSound;
AudioSample enterSound;

void setup(){
  size(600,600);
  background(1);
  //inicializarListas();
  soundengine = new Minim(this);
  endGameSound = soundengine.loadSample("End_Game.mp3",1024);
  disparoSound = soundengine.loadSample("Disparo.mp3",1024);
  backGroundSound = soundengine.loadSample("Spark_Mandrill.mp3",1024);
  cambiarIndexSound = soundengine.loadSample("Cambiar_Index.mp3",1024);  
  enterSound = soundengine.loadSample("Enter.mp3",1024);
}

void dibujarTitulo(){
  textSize(50);
  text("Space Invaders",100,100);
  textSize(12);
}
void dibujarMenuPrincipal(){
  textSize(20);
  text("Jugar",250,300);
  text("Configuración",250,320);
  text("Salir",250,340);
  textSize(12);
}
void dibujarMenuConfiguracion(){
  textSize(20);
  text("Dificultad",150,300);
    text(dificultades[opcionDificultad],400,300);
  text("Vidas",150,320);
    text(vidas,400,320);
  text("Salir",150,340);
  textSize(12);
}

void seleccionarOpcion(char opMenu){
  textSize(20);
  
  
  if(opMenu == '1'){//SI es el menú principal
    text(">",230,posY);
  if(keyPressed){
   
     if(keyCode == DOWN && posY < 340){
       posY += 20;
       opcion ++;
        cambiarIndexSound.trigger();      
     }else if(keyCode == UP && posY > 300){
       posY -= 20;
       opcion --;
       cambiarIndexSound.trigger();      

     }
     
         
     keyCode = 2;
    }
    
    
  }
  
  if(opMenu == '2'){
    text(">",130,posY);
  if(keyPressed){
   
     if(keyCode == DOWN && posY < 340){
       posY += 20;
       opcion ++;
       keyCode = 2;
       cambiarIndexSound.trigger();      

     }else if(keyCode == UP && posY > 300){
       posY -= 20;
       opcion --;
       keyCode = 2;
       cambiarIndexSound.trigger();
     }  
     
    }
    
    if(opcion == 1){
      
      text("<",380,300);
      text(">",460,300);
       if(keyPressed){
        if(keyCode == LEFT && opcionDificultad > 0){
          opcionDificultad --;
          keyCode = 2;
          cambiarIndexSound.trigger();
        }else if(keyCode == RIGHT && opcionDificultad < 2){
          opcionDificultad ++;
          keyCode = 2;
          cambiarIndexSound.trigger();
        }
        
        
      }
    }else if(opcion == 2){
      //text("3",400,320);
      text("<",380,320);
      text(">",420,320);
      
      if(keyPressed){
        if(keyCode == LEFT && vidas > 1){
          vidas --;
          keyCode = 2;
          cambiarIndexSound.trigger();
        }else if(keyCode == RIGHT && vidas < 9){
          vidas ++;
          keyCode = 2;
          cambiarIndexSound.trigger();
        }
        
        
      }
    }
  }
  
  if(keyCode == ENTER){
      if(opMenu == '1'){
        if(opcion == 1){
         gameOn = true;
         menuPrincipal = false;
         menuConfiguracion = false;
         game = new Juego(opcionDificultad,vidas);
         enterSound.trigger();
         delay(1000);
       }else if(opcion == 2){
         gameOn = false;
         menuPrincipal = false;
         menuConfiguracion = true;
         opcion = 1;
         posY = 300;
         enterSound.trigger();
         delay(1000);
       }else if(opcion == 3)
         exit();
         
          
      }else if(opMenu == '2' && opcion == 3){
       menuPrincipal = true;
       menuConfiguracion = false;
       opcion = 1;
       posY = 300;
       enterSound.trigger();
       delay(1000);
      }
     keyCode = 2;  
   }  
}
void draw(){
  background(1);
  fill(255);
  
  
  
  if(gameOn){
    if(game.draw() == true){
      gameOn = false;
      menuPrincipal = true;
      keyCode = 2;
    }
        
        
    return;
  }else{
    dibujarTitulo();
  
    if(menuPrincipal){
      dibujarMenuPrincipal();
      seleccionarOpcion('1');
    }else if(menuConfiguracion){
      dibujarMenuConfiguracion();
      seleccionarOpcion('2');
    }
  
  } 
  
  
}
