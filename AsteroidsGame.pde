SpaceShip bob = new SpaceShip();
Star[] rob = new Star[400];
PFont myFont;
ArrayList <Asteroid> theRocks = new ArrayList <Asteroid>();
ArrayList <Bullets> boo = new ArrayList <Bullets>();
public void setup() 
{
  size(1200,650);
  for(int i =0; i < rob.length; i++)
  {
    rob[i] = new Star();  
  }
  for(int i =0; i < 30; i++)
  {
    theRocks.add(new Asteroid()); 
  }
  myFont = createFont("Impact", 100);
}
public void draw() 
{
  if(theRocks.size() == 0)
  {
    background(0);
    textAlign(CENTER, CENTER);
    fill(255,255,0);
    textFont(myFont);
    text("The End", 600, 300);
    
  }
  else
  {
    background(0);
    for(int i = 0; i < rob.length; i++)
    {
      rob[i].draw();
    }
    for(int i = 0; i < theRocks.size(); i++)
    {
      theRocks.get(i).show();
      theRocks.get(i).move();
      if(dist(bob.getX(), bob.getY(), theRocks.get(i).getX(), theRocks.get(i).getY()) < 30)
      {
        theRocks.remove(i);
      }
    }
    for(int i = 0; i < boo.size(); i++)
    {
      boo.get(i).show();
      boo.get(i).move();
      // if(dist(boo.get(i).getX(), boo.get(i).getY(), theRocks.get(i).getX(), theRocks.get(i).getY()) < 20)
      // {
      //   boo.remove(i);
      // }
    }
    bob.show();
    bob.move();
  }

}
class SpaceShip extends Floater  
{   
  public SpaceShip()
  {
    corners = 8;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 18;
    yCorners[0] = 0;
    xCorners[1] = 18;
    yCorners[1] = -2;
    xCorners[2] = 12;
    yCorners[2] = -2;
    xCorners[3] = -8;
    yCorners[3] = -8;
    xCorners[4] = -5;
    yCorners[4] = 0;
    xCorners[5] = -8;
    yCorners[5] = 8;
    xCorners[6] = 12;
    yCorners[6] = 2;
    xCorners[7] = 18;
    yCorners[7] = 2;
    myColor = 255;
    myCenterX = 600;
    myCenterY = 325;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}   
  public void setY(int y){myCenterY = y;}   
  public int getY(){return (int)myCenterY;}   
  public void setDirectionX(double x){myDirectionX = x;}   
  public double getDirectionX(){return myDirectionX;}   
  public void setDirectionY(double y){myDirectionY = y;}   
  public double getDirectionY(){return myDirectionY;}   
  public void setPointDirection(int degrees){myPointDirection = degrees;}   
  public double getPointDirection(){return myPointDirection;} 
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
}
public void keyPressed()
{
  if(key == 'w')
  {
    bob.accelerate(0.25);
  }
  if(key == 's')
  {
    bob.accelerate(-0.25);
  }
  if(key == 'a')
  {
    bob.rotate(-5);
  }
  if(key == 'd')
  {
    bob.rotate(5);
  }
  if(key == 'h')
  {
    bob.setDirectionX(0);
    bob.setDirectionY(0);
    bob.setX((int)(Math.random()*1200));
    bob.setY((int)(Math.random()*800));
    bob.setPointDirection((int)(Math.random()*360));
  }
}
public void mousePressed()
{
  for(int i =0; i < 30; i++)
  {
    boo.add(new Bullets()); 
  }
} 
class Star 
{
  private int starX, starY;
  public Star()
  {
    starX = (int)(Math.random()*1200);
    starY = (int)(Math.random()*650);
  }
  public void draw()
  {
    noStroke();
    fill(255,255,0);
    ellipse(starX, starY, 4, 4);
  }
}
class Asteroid extends Floater
{
  private int rotspeed;
  public Asteroid()
  {
    corners = 8;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 10;
    yCorners[0] = 0;
    xCorners[1] = 7;
    yCorners[1] = 3;
    xCorners[2] = 5;
    yCorners[2] = 2;
    xCorners[3] = 1;
    yCorners[3] = 3;
    xCorners[4] = 0;
    yCorners[4] = 0;
    xCorners[5] = 2;
    yCorners[5] = -3;
    xCorners[6] = 6;
    yCorners[6] = -4;
    xCorners[7] = 9;
    yCorners[7] = -4;
    for(int i =0; i < xCorners.length; i++)
    {
      xCorners[i] = xCorners[i]*5;
    }
    for(int i =0; i < yCorners.length; i++)
    {
      yCorners[i] = yCorners[i]*5;
    }
    myColor = color(124,104,91);
    myCenterX = (int)(Math.random()*1200);
    myCenterY = (int)(Math.random()*750);
    myDirectionX = (int)(Math.random()*3-1.5);
    myDirectionY = (int)(Math.random()*3-1.5);
    if(myDirectionX == 0 && myDirectionY == 0)
    {
      myDirectionX += 1;
      myDirectionY += 1;
    }
    myPointDirection = 0;
    rotspeed = (int)(Math.random()*2)-1;
  }
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}   
  public void setY(int y){myCenterY = y;}   
  public int getY(){return (int)myCenterY;}   
  public void setDirectionX(double x){myDirectionX = x;}   
  public double getDirectionX(){return myDirectionX;}   
  public void setDirectionY(double y){myDirectionY = y;}   
  public double getDirectionY(){return myDirectionY;}   
  public void setPointDirection(int degrees){myPointDirection = degrees;}   
  public double getPointDirection(){return myPointDirection;}
  public void move()
  {
    rotate(rotspeed);
    super.move();
  }
}
class Bullets extends Floater
{
  public Bullets()
  {
    corners = 6;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 12;
    yCorners[0] = 0;
    xCorners[1] = 11;
    yCorners[1] = 1;
    xCorners[2] = -3;
    yCorners[2] = 1;
    xCorners[3] = -4;
    yCorners[3] = 0;
    xCorners[4] = -3;
    yCorners[4] = -1;
    xCorners[5] = 11;
    yCorners[5] = -1;
    myPointDirection = bob.getPointDirection();
    double dRadians = myPointDirection*(Math.PI/180);
    myColor = color(255,0,0);
    myCenterX = bob.getX();
    myCenterY = bob.getY();
    myDirectionX = 5 * Math.cos(dRadians) + bob.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + bob.getDirectionY();
  }
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}   
  public void setY(int y){myCenterY = y;}   
  public int getY(){return (int)myCenterY;}   
  public void setDirectionX(double x){myDirectionX = x;}   
  public double getDirectionX(){return myDirectionX;}   
  public void setDirectionY(double y){myDirectionY = y;}   
  public double getDirectionY(){return myDirectionY;}   
  public void setPointDirection(int degrees){myPointDirection = degrees;}   
  public double getPointDirection(){return myPointDirection;}
  public void move()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;       
  }
}