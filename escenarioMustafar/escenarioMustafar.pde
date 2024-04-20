import processing.sound.*;

SoundFile song;

PImage fondo;
PImage nave1;
PImage nave2;
PImage pj;

int nave1X, nave1Y; // Posición de la nave1
int nave1SpeedX = 5; // Velocidad horizontal de la nave1
int nave1SpeedY = 5; // Velocidad vertical de la nave1

int nave2X, nave2Y; // Posición de la nave2
int nave2Speed = 5; // Velocidad horizontal de la nave2
boolean nave2DireccionDerecha = true; // Dirección de movimiento de la nave2

int pjX, pjY; // Posición del personaje (pj)
float pjSpeed = 4; // Velocidad de movimiento del personaje (pj)
float pjVelX = 0; // Velocidad horizontal del personaje (pj)
float pjVelY = 0; // Velocidad vertical del personaje (pj)

boolean juegoComenzado = false; // Variable para controlar si el juego ha comenzado

void setup() {
  size(800, 600);  // Tamaño del lienzo
  
  fondo = loadImage("fondo.png");  // Carga la imagen de fondo
  fondo.resize(width, height); // Escala el fondo para que se ajuste al tamaño del lienzo
  
  nave1 = loadImage("nave1.png"); // Carga la imagen de la nave1
  nave1.resize(100, 100); 
  
  nave2 = loadImage("nave2.png"); // Carga la imagen de la nave2
  nave2.resize(100, 100); 
  
  pj = loadImage("pj.png"); // Carga la imagen del personaje (pj)
  pj.resize(200, 200); 
  
  nave1X = width / 2; // Inicializa la posición de la nave1 
  nave1Y = height / 2; // Inicializa la posición de la nave1 
  
  nave2X = width - 50; // Inicializa la posición de la nave2 
  nave2Y = 0; // Inicializa la posición de la nave2 
  
  pjX = width / 2; // Inicializa la posición del personaje (pj) 
  pjY = height - 200; // Inicializa la posición del personaje (pj)
  
  song = new SoundFile(this, "song.mp3"); 
}

void draw() {
  
  background(fondo);
  
  if (!song.isPlaying()) {
      song.play();
    }
    
    
  if (!juegoComenzado) {
    // Dibuja la frase del principio
    textAlign(CENTER, CENTER);
    textSize(32);
    fill(255);
    text("PRESIONA LA TECLA ESPACIO PARA JUGAR", width/2, height/2);
  } else {
    
    // Dibuja la nave1
    image(nave1, nave1X, nave1Y);
    
    // Mueve la nave1 y rebota en los bordes
    nave1X += nave1SpeedX;
    nave1Y += nave1SpeedY;
    if (nave1X < 0 || nave1X + nave1.width > width) {
      nave1SpeedX *= -1; // Cambia la dirección horizontal al tocar los bordes
    }
    if (nave1Y < 0 || nave1Y + nave1.height > height) {
      nave1SpeedY *= -1; // Cambia la dirección vertical al tocar los bordes
    }
    
    // Dibuja la nave2
    image(nave2, nave2X, nave2Y);
   
    // Mueve la nave2 de derecha a izquierda y viceversa
    if (nave2DireccionDerecha) {
      nave2X += nave2Speed;
      if (nave2X + nave2.width > width) {
        nave2DireccionDerecha = false; // Cambia la dirección cuando llega al borde derecho
      }
    } else {
      nave2X -= nave2Speed;
      if (nave2X < 0) {
        nave2DireccionDerecha = true; // Cambia la dirección cuando llega al borde izquierdo
      }
    }
  
    // Limita la posición del personaje dentro del lienzo
    pjX = constrain(pjX, 0, width - pj.width);
    pjY = constrain(pjY, 0, height - pj.height);
  
    // Dibuja el personaje (pj)
    image(pj, pjX, pjY);
    pjX += pjVelX;
    pjY += pjVelY;
  }
}

// Movimiento del personaje 
void keyPressed() {
  
  if (!juegoComenzado) {
      if (key == ' ') { // Verifica si la tecla presionada es la barra espaciadora
      juegoComenzado = true;
      }
  } else {
    if (key == 'a' || key == 'A') {
      pjVelX = -pjSpeed;
    } else if (key == 'd' || key == 'D') {
      pjVelX = pjSpeed;
    }
    
    if (key == 'w' || key == 'W') {
      pjVelY = -pjSpeed;
    } else if (key == 's' || key == 'S') {
      pjVelY = pjSpeed;
    }
  }
}

void keyReleased() {

  if ((key == 'a' || key == 'A') && pjVelX < 0) {
    pjVelX = 0;
  } else if ((key == 'd' || key == 'D') && pjVelX > 0) {
    pjVelX = 0;
  }
  
  if ((key == 'w' || key == 'W') && pjVelY < 0) {
    pjVelY = 0;
  } else if ((key == 's' || key == 'S') && pjVelY > 0) {
    pjVelY = 0;
  }
}
