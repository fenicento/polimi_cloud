import java.lang.reflect.Field;
import punktiert.math.Vec;
import punktiert.physics.*;
import peasy.*;

PeasyCam cam;
MPhysics physics;
JSONArray values;
ArrayList<Keyword> keywords= new ArrayList<Keyword>();
ArrayList<Focus> foci=new ArrayList<Focus>();
ArrayList<Focus> ingfoci=new ArrayList<Focus>();
ArrayList<Focus> arcfoci=new ArrayList<Focus>();
ArrayList<Focus> comparing;
int counter=1;
Focus ing;
Focus arc;
Focus des;
int state=0;
PFont font;
float ra=450;
String[] roman = {
  "I", "II", "III", "IV", "V"
};


void setup() {
  size(1920, 1080, OPENGL);
  smooth(8);


  font = loadFont("Lato-32.vlw");
  textFont(font, 15);
  cam = new PeasyCam(this, 950);
  cam.lookAt(width/2, height/2, 0);
  physics = new MPhysics(new Vec(0, 0), new Vec(width, height));
  physics.setfriction(0.4f);

  ing = new Focus("ing", width/2, 100);
  arc = new Focus("arc", width/10, height-100);
  des = new Focus("des", 9*width/10, height-100);

  foci.add(ing);
  foci.add(arc);
  foci.add(des);

  for (int i=0; i<5; i++) {
    float octx=ra*2*cos(-TWO_PI/8*i);
    float octy=ra*sin(-TWO_PI/8*i);
    ingfoci.add(new Focus("ing"+convertToRoman(i), width/2+octx, height/2+octy));
  }

  for (int i=5; i<7; i++) {
    float octx=ra*2*cos(-TWO_PI/8*i);
    float octy=ra*sin(-TWO_PI/8*i);
    arcfoci.add(new Focus("arc"+convertToRoman(i-5), width/2+octx, height/2+octy));
  }

  for (VParticle p : foci) {
    physics.addParticle(p);
  }

  loadKeywords();
}

void draw() {

  background(0);
  
  if(counter>10) {
    counter=0;
   addSeparation();
    
  }
  
  else if(counter>0) counter++;
  
  //println(counter);
  
  physics.update();
  hint(DISABLE_DEPTH_TEST);
  stroke(255, 10);
  for (VSpring s : physics.springs) {
    line(s.a.x, s.a.y, s.b.x, s.b.y);
  }
  hint(ENABLE_DEPTH_TEST);

  for (int i = 1; i < keywords.size() - 1; i++) {
    Keyword p = keywords.get(i);
    textAlign(LEFT);
    textFont(font, 12);
    if (p.onScreen) drawTriangle(p);
    //if (p.onScreen) drawCircle(p);
  }
  textAlign(CENTER);
  textFont(font, 32);
  drawText();
  
}


void loadKeywords() {
  values=loadJSONArray("total500.json");
  for (int i = 0; i < values.size(); i++) {
    Vec pos=new Vec(random(width), random(height));
    float rad=5;
    float mas=5;
    JSONObject kw = values.getJSONObject(i);
    Keyword k = new Keyword(pos, mas, rad, kw);
    k.addBehavior(new BCollision(.1f));

    if (k.ing>0)
      physics.addSpring(new VSpringRange(ing, k, 60, 90, (k.ing/k.tot)*.1f));
    if (k.arc>0)
      physics.addSpring(new VSpringRange(arc, k, 60, 90, (k.arc/k.tot)*.1f));
    if (k.des>0)
      physics.addSpring(new VSpringRange(des, k, 60, 90, (k.des/k.tot)*.1f));
    keywords.add(k);
    physics.addParticle((VParticle)k);
  }
}


void drawCircle(Keyword p) {

  if (p.onScreen) {
    float x=p.x;
    float y=p.y; 
    float m=p.getRadius()*2;
    float r=map(y, 30, height, 255, 0);
    float g=map(x, 0, width, 140, 0)+y/10;
    float b=map(width-x, width, 0, 0, 140)+y/10;
    color col = color(r, g, b); 
    fill(col, 160);
    //stroke(col, 230);
    noStroke();
    ellipse(x,y,m,m);
    
    fill(255);
    float[] rotations = cam.getRotations();
    hint(DISABLE_DEPTH_TEST);
    pushMatrix();
    translate(x, y);
    rotateX(rotations[0]);
    rotateY(rotations[1]);
    rotateZ(rotations[2]);
    if (m>11) text(p.name, m+4, m/2);
    popMatrix();
    hint(ENABLE_DEPTH_TEST);
  }
  
}


void drawTriangle(Keyword p) {

  if (p.onScreen) {
    float x=p.x;
    float y=p.y; 
    float m=p.getRadius()*2;

    float randang=m/y*100;
    float r=map(y, 30, height, 255, 0);
    float g=map(x, 0, width, 140, 0)+y/10;
    float b=map(width-x, width, 0, 0, 140)+y/10;
    color col = color(r, g, b); 
    fill(col, 60);
    stroke(col, 80);
    pushMatrix();
    translate(x, y);
    rotate(randang);
    beginShape(TRIANGLES);

    vertex(0, -m, 0);
    vertex(-0.866*m, 0.5*m, 0);
    vertex(0.866*m, 0.5*m, 0);
    endShape(CLOSE);

    fill(col, 60);
    stroke(col, 80);
    beginShape(TRIANGLES);

    vertex(0, -m, 0);
    vertex(0.866*m, 0.5*m, 0);
    //vertex(x+0.8*m,y+0.8*m,0);
    fill(col, 30);
    stroke(col, 40);
    vertex(0, 0, m);

    endShape(CLOSE);

    fill(col, 60);
    stroke(col, 80);
    beginShape(TRIANGLES);

    //vertex(x,y-m,0);
    vertex(-0.866*m, 0.5*m, 0);
    vertex(0.866*m, 0.5*m, 0);

    fill(col, 30);
    stroke(col, 40);
    vertex(0, 0, m);

    endShape(CLOSE);

    fill(col, 60);
    stroke(col, 80);
    beginShape(TRIANGLES);

    vertex(0, -m, 0);
    //vertex(x-0.8*m,y+0.8*m,0);
    vertex(-0.866*m, 0.5*m, 0);

    fill(col, 30);
    stroke(col, 40);
    vertex(0, 0, m);

    endShape(CLOSE);
    fill(255);

    popMatrix();

    float[] rotations = cam.getRotations();
    hint(DISABLE_DEPTH_TEST);
    pushMatrix();
    translate(x, y);
    rotateX(rotations[0]);
    rotateY(rotations[1]);
    rotateZ(rotations[2]);
    if (m>11) text(p.name, m+4, m/2);
    popMatrix();
    hint(ENABLE_DEPTH_TEST);
  }
}

void explode() {

  counter=1;
  state=1;

  physics.clearSprings();

  for (Focus f : ingfoci) {
    physics.addParticle(f);
  }

  for (Focus f : arcfoci) {
    physics.addParticle(f);
  }


  for (Keyword k : keywords) {

    for (Focus f : ingfoci) {  
      if (k.getField(f.name)>0) {
        physics.addSpring(new VSpringRange(f, k, 10, 90, (k.getField(f.name)/k.tot)*.1f));
        
      }
    }

    for (Focus f : arcfoci) {  
      if (k.getField(f.name)>0) {
        physics.addSpring(new VSpringRange(f, k, 10, 90, (k.getField(f.name)/k.tot)*.1f));
        
      }
    }

    des.unlock();
    des.x=width/2+ra*2*cos(-TWO_PI/8*7);
    des.y=height/2+ra*sin(-TWO_PI/8*7);
    des.lock();

    if (k.des>0) {
      physics.addSpring(new VSpringRange(des, k, 10, 90, (k.des/k.tot)*.1f));
      //println("added spring for "+k.name+", "+des);
    }
  }
}

String convertToRoman(int nu) {
  return roman[nu];
}


void keyReleased() {
  reset();
  if (key == ' ') {
    if (state==0) explode();
    else implode();
  }
  else if (key == 'c') {
    compare(new String[] {
      "ingI", "ingII","arcI","arcII","des"
    }
    );
  }
}

void drawText() {
  
  fill(255);
  noStroke();

  if (state==1) {
    for (int i=0; i<5; i++) {
      float x=width/2+ra*2.1*cos(-TWO_PI/8*i);
      float y=height/2+ra*1.1*sin(-TWO_PI/8*i);
      text(ingfoci.get(i).name, x, y);
    }

    for (int i=5; i<7; i++) {
      float x=width/2+ra*2.1*cos(-TWO_PI/8*i);
      float y=height/2+ra*1.1*sin(-TWO_PI/8*i);
      text(arcfoci.get(i-5).name, x, y);
    }

    text("des", width/2+ra*2.1*cos(-TWO_PI/8*7), height/2+ra*1.1*sin(-TWO_PI/8*7));
  }
  else if(state==0){
    text("des", des.x, des.y+30);
    text("arc", arc.x, arc.y+30);
    text("ing", ing.x, ing.y-30);
  }
  
  else if(state==2) {
    for (int i=0; i<comparing.size(); i++) {
      float x=width/2+ra*1.7*cos(-TWO_PI/comparing.size()*i-HALF_PI);
      float y=height/2+ra*1.1*sin(-TWO_PI/comparing.size()*i-HALF_PI);
      text(comparing.get(i).name, x, y);
    }
  }
}

void implode() {
  counter=1;
  state=0;
  physics.clearSprings(); 
  for (Keyword k : keywords) {
    if (k.ing>0)
      physics.addSpring(new VSpringRange(ing, k, 10, 90, (k.ing/k.tot)*.1f));
    if (k.arc>0)
      physics.addSpring(new VSpringRange(arc, k, 10, 90, (k.arc/k.tot)*.1f));
    if (k.des>0)
      physics.addSpring(new VSpringRange(des, k, 10, 90, (k.des/k.tot)*.1f));
  }
  des.x = 9*width/10;
  des.y = height-100;
}

void compare(String[] items) {
  
  state=2;
  counter=1;
  physics.clearSprings(); 
  comparing = new ArrayList<Focus>();

  //find foci
  for (int i = 0; i<items.length; i++) {
    //ing
    for (Focus fo : ingfoci) {
      if (fo.name.equals(items[i])) {
        comparing.add(fo);
      }
    }
    //arc
    for (Focus fo : arcfoci) {
      if (fo.name.equals(items[i])) {
        comparing.add(fo);
      }
    }
    //des
      if (items[i].equals("des")) comparing.add(des);
  }

  

  //position foci
  for (int i = 0; i<comparing.size(); i++) {
    println(comparing.get(i).name);
    println(comparing.size()+" "+i);
    float x=width/2+ra*1.5*cos(-TWO_PI/comparing.size()*i-HALF_PI);
    float y=height/2+ra*sin(-TWO_PI/comparing.size()*i-HALF_PI);
    comparing.get(i).x=x;
    comparing.get(i).y=y;
  }

  //assign nodes to foci
  for (Keyword ke : keywords) {
    boolean found=false;
    for (Focus fo : comparing) {
      if (ke.getField(fo.name)>0) {
          println(ke.name+" "+fo.name+": "+ke.getField(fo.name));
        physics.addSpring(new VSpring(ke, fo, 60, (ke.getField(fo.name)/ke.tot)*.8f));
        found=true;
      }
    }
    if (!found) ke.onScreen=false;
  }
}


void addSeparation() {
 
  physics.relaxSprings();
  //physics.clearSprings();
  for (Keyword ke : keywords) {
   
   ke.addBehavior(ke.separation); 
 } 
}

void reset() {
  for (Keyword ke : keywords) {
    ke.onScreen=true;
    ke.removeBehavior(ke.separation); 
  }
  for (int i=0; i<5; i++) {
    float octx=ra*2*cos(-TWO_PI/8*i);
    float octy=ra*sin(-TWO_PI/8*i);
    ingfoci.get(i).x=width/2+octx;
    ingfoci.get(i).y=height/2+octy;
  }

  for (int i=5; i<7; i++) {
    float octx=ra*2*cos(-TWO_PI/8*i);
    float octy=ra*sin(-TWO_PI/8*i);
    arcfoci.get(i-5).x=width/2+octx;
    arcfoci.get(i-5).y=height/2+octy;
  }
}
