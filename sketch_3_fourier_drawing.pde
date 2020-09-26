final int WINDOWX=1800, WINDOWY=800;
final int STEP_SIZE = 2;

int t = 0;
ArrayList<Point> points;
FloatList oscilloscope;
boolean START = false;

void settings() {
  size(WINDOWX, WINDOWY);
}

void setup() {
  points= new ArrayList<Point>();
  points.add(new Point(2*70,0));
  oscilloscope = new FloatList();
}
 
void draw() {
  int i;
  float lt,x,y;
  background(0);
  
  if(START == true){
    t = t+1;
    //draw axis
    noFill();
    strokeWeight(4);
    stroke(255);
    line(0,WINDOWY/2,WINDOWX,WINDOWY/2);
  
    noFill();
    stroke(255);
    //set initial position
    x=WINDOWX/5;
    y=WINDOWY/2;
    for(i=0;i<points.size();i++){
      //draw circle
      noFill();
      Point pt = points.get(i);
      pt.angle((float)(i+1) * (float)t / 30.0);
      circle(x,y,pt.a*2.0);
      stroke(0,0,255);
      line(x,y,x+pt.pos.x,y+pt.pos.y);
      //draw point
      fill(255);
      stroke(255);
      x = x+pt.pos.x;
      y = y+pt.pos.y;
      circle(x,y,10);
    }
    oscilloscope.append(y); //store data
    if(oscilloscope.size()>(WINDOWX/5*3)/STEP_SIZE){
      oscilloscope.remove(0);
    }
    stroke(0,255,0);
    strokeWeight(1);
    line(x,y,WINDOWX/3 + oscilloscope.size()*STEP_SIZE,y);
  
    stroke(255,0,255);
    strokeWeight(4);
    for(i=0;i<oscilloscope.size()-1;i++){
      line(WINDOWX/3+i*STEP_SIZE,oscilloscope.get(i), WINDOWX/3+(i+1)*STEP_SIZE,oscilloscope.get(i+1));
    }
  }
}

class Point{
  PVector pos;
  float theta, a;

  Point(float a,float theta){
    pos = new PVector(a * cos(theta), -a * sin(theta));
    this.theta=theta;
    this.a=a;
  }
  void angle(float theta){
    pos.set(a * cos(theta), -a * sin(theta));
    this.theta = theta;
  }
}

// Keyboard 
// s: Start drawing
// a: Add new wave
void keyPressed(){
  if(key == 's'){
    START = true;
  }else if(key == 'a'){
    float n = (float)points.size()+1.0;
    points.add(new Point(pow((-1),(n-1))*2/n*70,0));
  }
}
