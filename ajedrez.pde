import java.io.*;  
import java.net.*; 
import processing.net.*;
Client myClient; 


String dataIn; 
int i,j, indice1, indice2, indice;
int posiciones[][];
color color1, color2;
Peon peon1, peon2;
Caballo caballo1, caballo2;
Torre torre1, torre2;
Alfil alfil1, alfil2;
Reina reina1, reina2;
Rey rey1, rey2;
int cont;
String cad, cad1, cad2, movimiento;
String casillas [];



public void setup()
{
  size(1000, 800);
  posiciones = new int[32][3];
  casillas = new String[64];
  color1 = color(0);
  color2 = color(255);  
  peon1 = new Peon(color1, 255, 320, 320);
  caballo1 = new Caballo(color1, 255, 400, 400);
  torre1 = new Torre(color1, 255, 50, 50);
  alfil1 = new Alfil(color1, 255, 250,50);
  reina1 = new Reina(color1, 255, 350, 50);
  rey1 = new Rey(color1,255, 450, 50);
  peon2 = new Peon(color2, 255, 320, 320);
  caballo2 = new Caballo(color2, 255, 400, 400);
  torre2 = new Torre(color2, 255, 50, 50);
  alfil2 = new Alfil(color2, 255, 250,50);
  reina2 = new Reina(color2, 255, 350, 50);
  rey2 = new Rey(color2,255, 450, 50);
  cont = 0;
  cad = "";
  movimiento = "";
  myClient = new Client(this, "localhost", 6666); 
  
  for (i = 0; i <4; i++)// ordena las posiciones en el tablero inicial
  {
    for (j = 0; j < 8; j++)
    {
      posiciones[cont][0] = j+1;
      if (i<2)
      {
        posiciones [cont][1] = i+1;
        posiciones [cont][2] = cont;
      }
      else
      {
        posiciones [cont][1] = i+5;
        posiciones [cont][2] = cont+32;
      }
      cont = cont+1;
    }
  }
  cont =0;
  // otorga numeros a las casillas segun su nombre
  for (i = 0; i < 8; i++)
  {
    casillas[i*8] = "a" + (8-i);
  }
    for (i = 0; i < 8; i++)
  {
    casillas[i*8+1] = "b" + (8-i);
  }
    for (i = 0; i < 8; i++)
  {
    casillas[i*8+2] = "c" + (8-i);
  }
    for (i = 0; i < 8; i++)
  {
    casillas[i*8+3] = "d" + (8-i);
  }
    for (i = 0; i < 8; i++)
  {
    casillas[i*8+4] = "e" + (8-i);
  }
    for (i = 0; i < 8; i++)
  {
    casillas[i*8+5] = "f" + (8-i);
  }
    for (i = 0; i < 8; i++)
  {
    casillas[i*8+6] = "g" + (8-i);
  }
    for (i = 0; i < 8; i++)
  {
    casillas[i*8+7] = "h" + (8-i);
  }
}


void draw()
{
  background(127);
  fill(0);
  stroke(0);
  for(i=0 ; i<800; i= i+100)
  {
    for(j=0 ; j<800; j = j+100)
    {
      if( i % 200 + j % 200 == 100)
      {  
        fill(0);
        stroke(0);
      }
      else
      {
        fill(255);
        stroke(255);
      }
      rect(i, j, 100, 100);
    }
  }
  fill(180,0,0);
  stroke(125);
  rect(850, 50, 100, 100);
  fill(0,120,0);
  stroke(180);
  rect(850, 200, 100, 100);
  if(cont==1)
    sombra(cad.toLowerCase());
  
  
  if(cont == 3)
  {
    while(dataIn == null)
    {
      dataIn = myClient.readString();
    }
    cambiaPosiciones(dataIn);
    cont = 0;
  }
  
  if(cont == 2)
  {
    cont = 0;
    cad = cad.toLowerCase();
    myClient.write(cad);
    if(cad.compareTo("x") == 0)
      javax.swing.JOptionPane.showMessageDialog(null, "game over");
    while (movimiento == "" || movimiento == null)
    {
      movimiento = myClient.readString();
    }
    if (movimiento.compareTo("bien") == 0)
    {
      cambiaPosiciones(cad);
      cad = "";
      cont = 3;
      dataIn = null;
    }
    else
    {
      cad = "";
      javax.swing.JOptionPane.showMessageDialog(null, "not a move");
    }
    movimiento = "";
  }
  dibujaTablero();
  
}

void sombra(String cad)
{
  i = 0;
  j=-1;
  indice =0;
  while(i < 64 && j==-1)
  {
    if(cad.compareTo(casillas[i]) == 0)
      j =i;
    i=i+1;
  }
  if(i%2 == 1)
    fill(0,100,255, 175);
  else
    fill(0,100,255, 175);
  stroke(0);
  ellipse((j%8 + 1) * 100 - 50, (j/8 + 1)*100 - 20, 80, 35);
  //ellipse(posiciones[j][0]*100-50, posiciones[j][1]*100-30, 70, 30);
}

void cambiaPosiciones(String cad)
{
  if (cad.compareTo("x") == 0)
  {
    print("GameOver");
    javax.swing.JOptionPane.showMessageDialog(null, "game over");
  }
  else if(cad.compareTo("e1g1")==0 && posiciones[28][2]==60 )
  {
    posiciones[28][0]= 7;
    posiciones[28][1]= 8;
    posiciones[31][0]= 6;
    posiciones[31][1]= 8;
    
  }
  else if(cad.compareTo("e1c1")==0 && posiciones[28][2]==60 )
  {
    posiciones[28][0]= 3;
    posiciones[28][1]= 8;
    posiciones[24][0]= 4;
    posiciones[24][1]= 8;
  }
  else if(cad.compareTo("e8g8")==0 && posiciones[4][2]==4 )
  {
    posiciones[4][0]= 7;
    posiciones[4][1]= 1;
    posiciones[7][0]= 6;
    posiciones[7][1]= 1;
  }
  else if(cad.compareTo("e8c8")==0 && posiciones[4][2]==4 )
  {
    posiciones[4][0]= 3;
    posiciones[4][1]= 1;
    posiciones[0][0]= 4;
    posiciones[0][1]= 1;
  }
  else
  {
    cad1 = cad.substring(0,2);
    cad2 = cad.substring(2,4);
    i = 0;
    indice1 = -1;
    indice2 = -1;
    while(indice1 == -1)
    {
      if (cad1.compareTo(casillas[i]) == 0)
        indice1 = i;
      i++;
    }
    i=0;
    while(indice2 == -1)
    {
      if (cad2.compareTo(casillas[i]) == 0)
        indice2 = i;
      i++;
    }
    i = 0;
    while(i != 32 && posiciones[i][2] != indice2 )
    {
      i = i+1;
    }
    if(i != 32)
    {
      posiciones[i][0] = 9;
      posiciones[i][1] = 6;
      posiciones[i][2] = 100;
    }
    i = 0;
    while(posiciones[i][2]!= indice1)
    {
      i = i+1;
    }
    posiciones[i][0]= indice2%8 + 1;
    posiciones[i][1]= indice2/8 + 1;
    posiciones[i][2]= indice2;
  }
}

void dibujaTablero()
{
  for(i =8; i<16; i++)
  {
    peon1.cambiaCoordenadas(posiciones[i][0]*100-50, posiciones[i][1]*100 -50);
    peon1.display();
  }
  for(i = 16; i<24; i++)
  {
    peon2.cambiaCoordenadas(posiciones[i][0]*100-50, posiciones[i][1]*100 -50);
    peon2.display();
  }
  //torres
  torre1.cambiaCoordenadas(posiciones[0][0]*100-50, posiciones[0][1]*100 -50);
  torre1.display();
  torre1.cambiaCoordenadas(posiciones[7][0]*100-50, posiciones[7][1]*100 -50);
  torre1.display();
  torre2.cambiaCoordenadas(posiciones[24][0]*100-50, posiciones[24][1]*100 -50);
  torre2.display();
  torre2.cambiaCoordenadas(posiciones[31][0]*100-50, posiciones[31][1]*100 -50);
  torre2.display();
  caballo1.cambiaCoordenadas(posiciones[1][0]*100-50, posiciones[1][1]*100 -50);
  caballo1.display();
  caballo1.cambiaCoordenadas(posiciones[6][0]*100-50, posiciones[6][1]*100 -50);
  caballo1.display();
  caballo2.cambiaCoordenadas(posiciones[25][0]*100-50, posiciones[25][1]*100 -50);
  caballo2.display();
  caballo2.cambiaCoordenadas(posiciones[30][0]*100-50, posiciones[30][1]*100 -50);
  caballo2.display();
  alfil1.cambiaCoordenadas(posiciones[2][0]*100-50, posiciones[2][1]*100 -50);
  alfil1.display();
  alfil1.cambiaCoordenadas(posiciones[5][0]*100-50, posiciones[5][1]*100 -50);
  alfil1.display();  
  alfil2.cambiaCoordenadas(posiciones[26][0]*100-50, posiciones[26][1]*100 -50);
  alfil2.display();  
  alfil2.cambiaCoordenadas(posiciones[29][0]*100-50, posiciones[29][1]*100 -50);
  alfil2.display();
  reina1.cambiaCoordenadas(posiciones[3][0]*100-50, posiciones[3][1]*100 -50);
  reina1.display();
  reina2.cambiaCoordenadas(posiciones[27][0]*100-50, posiciones[27][1]*100 -50);
  reina2.display();
  rey1.cambiaCoordenadas(posiciones[4][0]*100-50, posiciones[4][1]*100 -50);
  rey1.display();
  rey2.cambiaCoordenadas(posiciones[28][0]*100-50, posiciones[28][1]*100 -50);
  rey2.display();
}


class Caballo
{
  int c1, c2;
  float x, y;
  Caballo(int color1, int color2, float posx, float posy)
  {
    c1 = color1;
    c2 = color2;
    x = posx;
    y = posy;
  }
  void cambiaCoordenadas(int posx, int posy)
  {
    x = posx;
    y = posy;
  }
  void display()
  {
    fill(c1);
    stroke(125);
    strokeWeight(3);
    beginShape();
    vertex(x+15,y-25);
    vertex(x+10,y-30);
    vertex(x+5,y-25);
    vertex(x-5,y-25);
    vertex(x-10,y-30);
    vertex(x-15,y-25);
    vertex(x-25,y-5);
    vertex(x-17,y+2);
    vertex(x-5,y-10);
    vertex(x-15,y+25);
    vertex(x+25,y+25);
    vertex(x+15,y-10);
    vertex(x+15,y-25);
    endShape();
    strokeWeight(1);
  }
}

class Alfil
{
  int c1, c2;
  float x, y;
  Alfil(int color1, int color2, float posx, float posy)
  {
    c1 = color1;
    c2 = color2;
    x = posx;
    y = posy;
  }
  void cambiaCoordenadas(int posx, int posy)
  {
    x = posx;
    y = posy;
  }
  void display()
  {
    fill(c1);
    stroke(125);
    strokeWeight(3);
    ellipse(x,y-15,30,30);
    ellipse(x,y-30,10,10);
    beginShape();
    vertex(x-20,y+25);
    vertex(x+20,y+25);
    vertex(x,y-15);
    vertex(x-20,y+25);
    endShape();
    noStroke();
    rect(x-6,y-20,13,30);
    strokeWeight(1);
  }
}

class Torre
{
  int c1, c2;
  float x, y;
  Torre(int color1, int color2, float posx, float posy)
  {
    c1 = color1;
    c2 = color2;
    x = posx;
    y = posy;
  }
  void cambiaCoordenadas(int posx, int posy)
  {
    x = posx;
    y = posy;
  }
  void display()
  {
    fill(c1);
    stroke(125);
    strokeWeight(3);
    beginShape();
    vertex(x-20,y+25);
    vertex(x+20,y+25);
    vertex(x+10,y-10);
    vertex(x+18,y-10);
    vertex(x+18,y-30);
    vertex(x+13,y-30);
    vertex(x+13,y-22);
    vertex(x+8,y-22);
    vertex(x+8,y-30);
    vertex(x+3,y-30);
    vertex(x+3,y-22);
    vertex(x-3,y-22);
    vertex(x-3,y-30);
    vertex(x-8,y-30);
    vertex(x-8,y-22);
    vertex(x-13,y-22);
    vertex(x-13,y-30);
    vertex(x-18,y-30);
    vertex(x-18,y-10);
    vertex(x-10,y-10);
    vertex(x-20,y+25);
    endShape();
    strokeWeight(1);
  }
}

class Reina
{
  int c1, c2;
  float x, y;
  Reina(int color1, int color2, float posx, float posy)
  {
    c1 = color1;
    c2 = color2;
    x = posx;
    y = posy;
  }
  void cambiaCoordenadas(int posx, int posy)
  {
    x = posx;
    y = posy;
  }
  void display()
  {
    fill(c1);
    stroke(125);
    strokeWeight(3);
    beginShape();
    vertex(x-20,y+35);
    vertex(x+20,y+35);
    vertex(x+10,y+20);
    vertex(x+10,y-10);
    vertex(x+18,y-25);
    vertex(x+8,y-20);
    vertex(x+5,y-20);
    vertex(x+5,y-25);
    vertex(x-5,y-25);
    vertex(x-5,y-20);
    vertex(x-8,y-20);
    vertex(x-18,y-25);
    vertex(x-10,y-10);
    vertex(x-10,y+20);
    vertex(x-20,y+35);
    endShape();
    ellipse(x,y-30, 10, 10);
    strokeWeight(1);
  }
}
class Rey
{
  int c1, c2;
  float x, y;
  Rey(int color1, int color2, float posx, float posy)
  {
    c1 = color1;
    c2 = color2;
    x = posx;
    y = posy;
  }
  void cambiaCoordenadas(int posx, int posy)
  {
    x = posx;
    y = posy;
  }
  void display()
  {
    fill(c1);
    stroke(125);
    strokeWeight(3);
    beginShape();
    vertex(x-25,y+35);
    vertex(x+25,y+35);
    vertex(x+12,y+20);
    vertex(x+12,y-10);
    vertex(x+20,y-25);
    vertex(x+7,y-25);
    vertex(x+7,y-30);
    vertex(x+3,y-30);
    vertex(x+3,y-35);
    vertex(x+5,y-35);
    vertex(x+5,y-39);
    vertex(x+3,y-39);
    vertex(x+3,y-43);
    vertex(x-3,y-43);
    vertex(x-3,y-39);
    vertex(x-5,y-39);
    vertex(x-5,y-35);
    vertex(x-3,y-35);
    vertex(x-3,y-30);
    vertex(x-7,y-30);
    vertex(x-7,y-25);
    vertex(x-20,y-25);
    vertex(x-12,y-10);
    vertex(x-12,y+20);
    vertex(x-25,y+35);
    endShape();
    strokeWeight(1);
  }
}
class Peon
{
  int c1, c2;
  float x, y;
  Peon(int color1, int color2, float posx, float posy)
  {
    c1 = color1;
    c2 = color2;
    x = posx;
    y = posy;
  }
  
  void cambiaCoordenadas(int posx, int posy)
  {
    x = posx;
    y = posy+10;
  }
  
  void display()
  {
    fill(c1);
    strokeWeight(3);
    stroke(125);
    beginShape();
    vertex(x,y-20);
    vertex(x-15,y+15);
    vertex(x+15,y+15);
    vertex(x,y-20);
    endShape();
    ellipse(x, y - 20, 20, 20);
    strokeWeight(1);
  }
  
}
// botones ##########################################################

boolean A8()
{
  boolean resp;
  resp = false;
  if (mouseX < 100 && mouseY <100)
  {
    resp = true;
  }
  return resp;
}
boolean A7()
{
  boolean resp;
  resp = false;
  if (mouseX < 100 && 100 < mouseY && mouseY < 200)
  {
    resp = true;
  }
  return resp;
}
boolean A6()
{
  boolean resp;
  resp = false;
  if (mouseX < 100 && 200 < mouseY && mouseY < 300)
  {
    resp = true;
  }
  return resp;
}
boolean A5()
{
  boolean resp;
  resp = false;
  if (mouseX < 100 && 300 < mouseY && mouseY < 400)
  {
    resp = true;
  }
  return resp;
}
boolean A4()
{
  boolean resp;
  resp = false;
  if (mouseX < 100 && 400 < mouseY && mouseY < 500)
  {
    resp = true;
  }
  return resp;
}
boolean A3()
{
  boolean resp;
  resp = false;
  if (mouseX < 100 && 500 < mouseY && mouseY < 600)
  {
    resp = true;
  }
  return resp;
}
boolean A2()
{
  boolean resp;
  resp = false;
  if (mouseX < 100 && 600 < mouseY && mouseY < 700)
  {
    resp = true;
  }
  return resp;
}
boolean A1()
{
  boolean resp;
  resp = false;
  if (mouseX < 100 && 700 < mouseY )
  {
    resp = true;
  }
  return resp;
}

boolean B8()
{
  boolean resp;
  resp = false;
  if (100 < mouseX && mouseX < 200 && mouseY <100)
  {
    resp = true;
  }
  return resp;
}
boolean B7()
{
  boolean resp;
  resp = false;
  if (100 < mouseX && mouseX < 200 && 100 < mouseY && mouseY < 200)
  {
    resp = true;
  }
  return resp;
}
boolean B6()
{
  boolean resp;
  resp = false;
  if (100 < mouseX && mouseX < 200 && 200 < mouseY && mouseY < 300)
  {
    resp = true;
  }
  return resp;
}
boolean B5()
{
  boolean resp;
  resp = false;
  if (100 < mouseX && mouseX < 200 && 300 < mouseY && mouseY < 400)
  {
    resp = true;
  }
  return resp;
}
boolean B4()
{
  boolean resp;
  resp = false;
  if (100 < mouseX && mouseX < 200 && 400 < mouseY && mouseY < 500)
  {
    resp = true;
  }
  return resp;
}
boolean B3()
{
  boolean resp;
  resp = false;
  if (100 < mouseX && mouseX < 200 && 500 < mouseY && mouseY < 600)
  {
    resp = true;
  }
  return resp;
}
boolean B2()
{
  boolean resp;
  resp = false;
  if (100 < mouseX && mouseX < 200 && 600 < mouseY && mouseY < 700)
  {
    resp = true;
  }
  return resp;
}
boolean B1()
{
  boolean resp;
  resp = false;
  if (100 < mouseX && mouseX < 200 && 700 < mouseY )
  {
    resp = true;
  }
  return resp;
}

boolean C8()
{
  boolean resp;
  resp = false;
  if (200 < mouseX && mouseX < 300 && mouseY <100)
  {
    resp = true;
  }
  return resp;
}
boolean C7()
{
  boolean resp;
  resp = false;
  if (200 < mouseX && mouseX < 300 && 100 < mouseY && mouseY < 200)
  {
    resp = true;
  }
  return resp;
}
boolean C6()
{
  boolean resp;
  resp = false;
  if (200 < mouseX && mouseX < 300 && 200 < mouseY && mouseY < 300)
  {
    resp = true;
  }
  return resp;
}
boolean C5()
{
  boolean resp;
  resp = false;
  if (200 < mouseX && mouseX < 300 && 300 < mouseY && mouseY < 400)
  {
    resp = true;
  }
  return resp;
}
boolean C4()
{
  boolean resp;
  resp = false;
  if (200 < mouseX && mouseX < 300 && 400 < mouseY && mouseY < 500)
  {
    resp = true;
  }
  return resp;
}
boolean C3()
{
  boolean resp;
  resp = false;
  if (200 < mouseX && mouseX < 300 && 500 < mouseY && mouseY < 600)
  {
    resp = true;
  }
  return resp;
}
boolean C2()
{
  boolean resp;
  resp = false;
  if (200 < mouseX && mouseX < 300 && 600 < mouseY && mouseY < 700)
  {
    resp = true;
  }
  return resp;
}
boolean C1()
{
  boolean resp;
  resp = false;
  if (200 < mouseX && mouseX < 300 && 700 < mouseY )
  {
    resp = true;
  }
  return resp;
}

boolean D8()
{
  boolean resp;
  resp = false;
  if (300 < mouseX && mouseX < 400 && mouseY <100)
  {
    resp = true;
  }
  return resp;
}
boolean D7()
{
  boolean resp;
  resp = false;
  if (300 < mouseX && mouseX < 400 && 100 < mouseY && mouseY < 200)
  {
    resp = true;
  }
  return resp;
}
boolean D6()
{
  boolean resp;
  resp = false;
  if (300 < mouseX && mouseX < 400 && 200 < mouseY && mouseY < 300)
  {
    resp = true;
  }
  return resp;
}
boolean D5()
{
  boolean resp;
  resp = false;
  if (300 < mouseX && mouseX < 400 && 300 < mouseY && mouseY < 400)
  {
    resp = true;
  }
  return resp;
}
boolean D4()
{
  boolean resp;
  resp = false;
  if (300 < mouseX && mouseX < 400 && 400 < mouseY && mouseY < 500)
  {
    resp = true;
  }
  return resp;
}
boolean D3()
{
  boolean resp;
  resp = false;
  if (300 < mouseX && mouseX < 400 && 500 < mouseY && mouseY < 600)
  {
    resp = true;
  }
  return resp;
}
boolean D2()
{
  boolean resp;
  resp = false;
  if (300 < mouseX && mouseX < 400 && 600 < mouseY && mouseY < 700)
  {
    resp = true;
  }
  return resp;
}
boolean D1()
{
  boolean resp;
  resp = false;
  if (300 < mouseX && mouseX < 400 && 700 < mouseY )
  {
    resp = true;
  }
  return resp;
}

boolean E8()
{
  boolean resp;
  resp = false;
  if (400 < mouseX && mouseX < 500 && mouseY <100)
  {
    resp = true;
  }
  return resp;
}
boolean E7()
{
  boolean resp;
  resp = false;
  if (400 < mouseX && mouseX < 500 && 100 < mouseY && mouseY < 200)
  {
    resp = true;
  }
  return resp;
}
boolean E6()
{
  boolean resp;
  resp = false;
  if (400 < mouseX && mouseX < 500 && 200 < mouseY && mouseY < 300)
  {
    resp = true;
  }
  return resp;
}
boolean E5()
{
  boolean resp;
  resp = false;
  if (400 < mouseX && mouseX < 500 && 300 < mouseY && mouseY < 400)
  {
    resp = true;
  }
  return resp;
}
boolean E4()
{
  boolean resp;
  resp = false;
  if (400 < mouseX && mouseX < 500 && 400 < mouseY && mouseY < 500)
  {
    resp = true;
  }
  return resp;
}
boolean E3()
{
  boolean resp;
  resp = false;
  if (400 < mouseX && mouseX < 500 && 500 < mouseY && mouseY < 600)
  {
    resp = true;
  }
  return resp;
}
boolean E2()
{
  boolean resp;
  resp = false;
  if (400 < mouseX && mouseX < 500 && 600 < mouseY && mouseY < 700)
  {
    resp = true;
  }
  return resp;
}
boolean E1()
{
  boolean resp;
  resp = false;
  if (400 < mouseX && mouseX < 500 && 700 < mouseY )
  {
    resp = true;
  }
  return resp;
}

boolean F8()
{
  boolean resp;
  resp = false;
  if (500 < mouseX && mouseX < 600 && mouseY <100)
  {
    resp = true;
  }
  return resp;
}
boolean F7()
{
  boolean resp;
  resp = false;
  if (500 < mouseX && mouseX < 600 && 100 < mouseY && mouseY < 200)
  {
    resp = true;
  }
  return resp;
}
boolean F6()
{
  boolean resp;
  resp = false;
  if (500 < mouseX && mouseX < 600 && 200 < mouseY && mouseY < 300)
  {
    resp = true;
  }
  return resp;
}
boolean F5()
{
  boolean resp;
  resp = false;
  if (500 < mouseX && mouseX < 600 && 300 < mouseY && mouseY < 400)
  {
    resp = true;
  }
  return resp;
}
boolean F4()
{
  boolean resp;
  resp = false;
  if (500 < mouseX && mouseX < 600 && 400 < mouseY && mouseY < 500)
  {
    resp = true;
  }
  return resp;
}
boolean F3()
{
  boolean resp;
  resp = false;
  if (500 < mouseX && mouseX < 600 && 500 < mouseY && mouseY < 600)
  {
    resp = true;
  }
  return resp;
}
boolean F2()
{
  boolean resp;
  resp = false;
  if (500 < mouseX && mouseX < 600 && 600 < mouseY && mouseY < 700)
  {
    resp = true;
  }
  return resp;
}
boolean F1()
{
  boolean resp;
  resp = false;
  if (500 < mouseX && mouseX < 600 && 700 < mouseY )
  {
    resp = true;
  }
  return resp;
}

boolean G8()
{
  boolean resp;
  resp = false;
  if (600 < mouseX && mouseX < 700 && mouseY <100)
  {
    resp = true;
  }
  return resp;
}
boolean G7()
{
  boolean resp;
  resp = false;
  if (600 < mouseX && mouseX < 700 && 100 < mouseY && mouseY < 200)
  {
    resp = true;
  }
  return resp;
}
boolean G6()
{
  boolean resp;
  resp = false;
  if (600 < mouseX && mouseX < 700 && 200 < mouseY && mouseY < 300)
  {
    resp = true;
  }
  return resp;
}
boolean G5()
{
  boolean resp;
  resp = false;
  if (600 < mouseX && mouseX < 700 && 300 < mouseY && mouseY < 400)
  {
    resp = true;
  }
  return resp;
}
boolean G4()
{
  boolean resp;
  resp = false;
  if (600 < mouseX && mouseX < 700 && 400 < mouseY && mouseY < 500)
  {
    resp = true;
  }
  return resp;
}
boolean G3()
{
  boolean resp;
  resp = false;
  if (600 < mouseX && mouseX < 700 && 500 < mouseY && mouseY < 600)
  {
    resp = true;
  }
  return resp;
}
boolean G2()
{
  boolean resp;
  resp = false;
  if (600 < mouseX && mouseX < 700 && 600 < mouseY && mouseY < 700)
  {
    resp = true;
  }
  return resp;
}
boolean G1()
{
  boolean resp;
  resp = false;
  if (600 < mouseX && mouseX < 700 && 700 < mouseY )
  {
    resp = true;
  }
  return resp;
}

boolean H8()
{
  boolean resp;
  resp = false;
  if (700 < mouseX && mouseX < 800 && mouseY <100)
  {
    resp = true;
  }
  return resp;
}
boolean H7()
{
  boolean resp;
  resp = false;
  if (700 < mouseX && mouseX < 800 && 100 < mouseY && mouseY < 200)
  {
    resp = true;
  }
  return resp;
}
boolean H6()
{
  boolean resp;
  resp = false;
  if (700 < mouseX && mouseX < 800 && 200 < mouseY && mouseY < 300)
  {
    resp = true;
  }
  return resp;
}
boolean H5()
{
  boolean resp;
  resp = false;
  if (700 < mouseX && mouseX < 800 && 300 < mouseY && mouseY < 400)
  {
    resp = true;
  }
  return resp;
}
boolean H4()
{
  boolean resp;
  resp = false;
  if (700 < mouseX && mouseX < 800 && 400 < mouseY && mouseY < 500)
  {
    resp = true;
  }
  return resp;
}
boolean H3()
{
  boolean resp;
  resp = false;
  if (700 < mouseX && mouseX < 800 && 500 < mouseY && mouseY < 600)
  {
    resp = true;
  }
  return resp;
}
boolean H2()
{
  boolean resp;
  resp = false;
  if (700 < mouseX && mouseX < 800 && 600 < mouseY && mouseY < 700)
  {
    resp = true;
  }
  return resp;
}
boolean H1()
{
  boolean resp;
  resp = false;
  if (700 < mouseX && mouseX < 800 && 700 < mouseY )
  {
    resp = true;
  }
  return resp;
}
boolean terminar()
{
  boolean resp;
  resp = false;
  if( 850 < mouseX && 950 > mouseX && 50< mouseY && 150 > mouseY)
  {
    resp = true;
  }
  
  return resp;
}
boolean verde()
{
  boolean resp;
  resp = false;
  if( 800 < mouseX && 200< mouseY)
    resp = true;
  return resp;
}
// mousePressed ##############################################
void mousePressed()
{
  cont = cont +1;
  if(A8())
  {
    cad = cad + "A8";
  }
  if(A7())
  {
    cad = cad + "A7";
  }
  if(A6())
  {
    cad = cad + "A6";
  }
  if(A5())
  {
    cad = cad + "A5";
  }
  if(A4())
  {
    cad = cad + "A4";
  }
  if(A3())
  {
    cad = cad + "A3";
  }
  if(A2())
  {
    cad = cad + "A2";
  }
  if(A1())
  {
    cad = cad + "A1";
  }
  if(B8())
  {
    cad = cad + "B8";
  }
  if(B7())
  {
    cad = cad + "B7";
  }
  if(B6())
  {
    cad = cad + "B6";
  }
  if(B5())
  {
    cad = cad + "B5";
  }
  if(B4())
  {
    cad = cad + "B4";
  }
  if(B3())
  {
    cad = cad + "B3";
  }
  if(B2())
  {
    cad = cad + "B2";
  }
  if(B1())
  {
    cad = cad + "B1";
  }
  if(C8())
  {
    cad = cad + "C8";
  }
  if(C7())
  {
    cad = cad + "C7";
  }
  if(C6())
  {
    cad = cad + "C6";
  }
  if(C5())
  {
    cad = cad + "C5";
  }
  if(C4())
  {
    cad = cad + "C4";
  }
  if(C3())
  {
    cad = cad + "C3";
  }
  if(C2())
  {
    cad = cad + "C2";
  }
  if(C1())
  {
    cad = cad + "C1";
  }
  if(D8())
  {
    cad = cad + "D8";
  }
  if(D7())
  {
    cad = cad + "D7";
  }
  if(D6())
  {
    cad = cad + "D6";
  }
  if(D5())
  {
    cad = cad + "D5";
  }
  if(D4())
  {
    cad = cad + "D4";
  }
  if(D3())
  {
    cad = cad + "D3";
  }
  if(D2())
  {
    cad = cad + "D2";
  }
  if(D1())
  {
    cad = cad + "D1";
  }
  if(E8())
  {
    cad = cad + "E8";
  }
  if(E7())
  {
    cad = cad + "E7";
  }
  if(E6())
  {
    cad = cad + "E6";
  }
  if(E5())
  {
    cad = cad + "E5";
  }
  if(E4())
  {
    cad = cad + "E4";
  }
  if(E3())
  {
    cad = cad + "E3";
  }
  if(E2())
  {
    cad = cad + "E2";
  }
  if(E1())
  {
    cad = cad + "E1";
  }
  if(F8())
  {
    cad = cad + "F8";
  }
  if(F7())
  {
    cad = cad + "F7";
  }
  if(F6())
  {
    cad = cad + "F6";
  }
  if(F5())
  {
    cad = cad + "F5";
  }
  if(F4())
  {
    cad = cad + "F4";
  }
  if(F3())
  {
    cad = cad + "F3";
  }
  if(F2())
  {
    cad = cad + "F2";
  }
  if(F1())
  {
    cad = cad + "F1";
  }
  if(G8())
  {
    cad = cad + "G8";
  }
  if(G7())
  {
    cad = cad + "G7";
  }
  if(G6())
  {
    cad = cad + "G6";
  }
  if(G5())
  {
    cad = cad + "G5";
  }
  if(G4())
  {
    cad = cad + "G4";
  }
  if(G3())
  {
    cad = cad + "G3";
  }
  if(G2())
  {
    cad = cad + "G2";
  }
  if(G1())
  {
    cad = cad + "G1";
  }
  if(H8())
  {
    cad = cad + "H8";
  }
  if(H7())
  {
    cad = cad + "H7";
  }
  if(H6())
  {
    cad = cad + "H6";
  }
  if(H5())
  {
    cad = cad + "H5";
  }
  if(H4())
  {
    cad = cad + "H4";
  }
  if(H3())
  {
    cad = cad + "H3";
  }
  if(H2())
  {
    cad = cad + "H2";
  }
  if(H1())
  {
    cad = cad + "H1";
  }
  if(terminar())
  {
    cont = 2;
    cad = "x";
  }
  if(verde())
  {
    cont = 0;
    cad = "";
    println("elija otra ficha");
  }
}
