
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;


Box2DProcessing box2d;
Box box;
Spring spring;

float x;
float y;
boolean aparecio = false;
int contador;

ArrayList<estrella> estrellas;
ArrayList<planeta> planetas;
float noa=6;
float nop=5;
float posxna=100;
float posyna=width/2;
PImage asteroide;
PImage planeta;
PImage planeta1;
PImage planeta2;
PImage planeta3;
PImage planeta4;
PImage nave;
PImage fondo1;
int estado=0;
int puntuacion=0;



void setup() {
  size(1200,650);
  smooth();
  
  asteroide=loadImage("asteroide.png");
  planeta=loadImage("marte.png");
  planeta1=loadImage("jupiter.png");
  planeta2=loadImage("urano.png");
  planeta3=loadImage("mercurio.png");
  planeta4=loadImage("negro.png");
  nave=loadImage("nave.png");
  fondo1=loadImage("fondo1.jpg");
  fondo1.resize(1200,650);

 
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  box2d.listenForCollisions();
  box2d.setGravity(0, -9.8);

  estrellas = new ArrayList<estrella>();
  planetas = new ArrayList<planeta>();
  
  box = new Box(width/2,100);  
  spring = new Spring();
}

  void mouseReleased() {
  spring.destroy();
}

void mousePressed() {
  if (box.contains(mouseX, mouseY)) {
    spring.bind(mouseX,mouseY,box);
  }
}

void draw() {
  
  
   
   switch(estado){
    case 0:
    background(0);
    pushMatrix();
      image(fondo1,0,0);
      textSize(200);
      text("Newplanet", 100, 250);
      fill(190,0,216);
      textSize(25);
      text("Preciona Cualquier Tecla Una Vez Para Continuar", 250, 375);
      fill(190,0,216);
      popMatrix();
    break;
    case 1:
    background(0);
     String s = "Instrucciones                                                                      Estas en busca de un nuevo lugar para poder evitar en este basto universo, pero para poder llegar necesitas atravesar lugares muy peligrosos. Para mover tu nave debes sujetarla con el mouse, y así poder evitar chocar contra los asteroides, recuerda que los planetas no te son peligrosos para chocar, pero si cambian la trayectoria de los asteroides, recuerda ser precavido y no chocar. ¡Suerte!   ";
      fill(191,255,158);
      text(s, 200, 200, 700, 400);
       text("Preciona Cualquier Tecla Una Vez Para Continuar", 250, 50);
    break;
    case 2:
    background(0);
    box2d.step(); 
    puntuacion++;
    println(puntuacion);
    // box.add(box);

  spring.update(mouseX,mouseY);

    //estrellas
  if (random(noa) < 0.1) {
    estrella e = new estrella(random(1,10),random(width),-100);
    estrellas.add(e);
    if(noa>1){noa-=0.1;}
    //println(noa);
  }
  
  for (estrella e: estrellas) {
    e.display();
      for(planeta p: planetas){ 
          e.attract(p.posicion().x,p.posicion().y);
      } 
    }
  
  for(planeta p: planetas){   
          p.display();
      } 
  
  for (int i = estrellas.size()-1; i >= 0; i--) {
    estrella e = estrellas.get(i);
    if (e.done()) {
      estrellas.remove(i);
    }
  }
   //planetas
  if (random(nop) < 0.1) {
    planeta p = new planeta(random(width),-100);
    planetas.add(p);
    if(nop>5){nop-=0.1;}
   // println(nop);
  }
  
  for (int i = planetas.size()-1; i >= 0; i--) {
    planeta p = planetas.get(i);
    if (p.done()) {
      planetas.remove(i);
    }
  }
  box.display();
  spring.display();
 
    break;
    case 3:
      background(0);
    if(random(15)>0.99){
     aparecio = true;
     x = random(width);
     y = random(height);
    }
  
    if(aparecio == true){
    ellipse(x,y,5,5);
    contador++;
    }
  
    if(contador>100){
    aparecio = false;
    contador = 0;
    }
      
      textSize(200);
      text("Game Over", 50, 250);
      fill(255);
      textSize(35);
      text("Score:", 450, 375);
      text(puntuacion, 600, 375);
      text("Presiona R Para Reiniciar si es que te Pego un Asteroide", 180, 450); 
    break;
  }
}

void keyPressed(){
  if (estado <=1) {
     estado+=1; 
  }
  
  if(estado==3){
    if(key == 'r'){
      estado=2;    
      redraw();
    }
  }

}
  

void beginContact(Contact cp) {

  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();

  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1==null || o2==null)
     return;
     
  if (o1.getClass() == Box.class) {
    estrella p = (estrella) o2;
    estrellas.clear();
    planetas.clear();
    posxna=100;
    posyna=width/2;
    //box.killBody();
    estado+=1; 
  } 

    else if (o2.getClass() == Box.class) {
    estrella p = (estrella) o1;
    estrellas.clear();
    planetas.clear();
    estado+=1; 
  } 
  }


void endContact(Contact cp) {
}
