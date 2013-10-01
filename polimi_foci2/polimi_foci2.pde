import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import de.looksgood.ani.*;
import java.lang.reflect.Field;
import punktiert.math.Vec;
import punktiert.physics.*;
import peasy.*;
import java.util.Arrays;
import java.util.Iterator;

AniSequence seq;
PeasyCam cam;
MPhysics physics;
JSONArray values;
ArrayList<Keyword> keywords= new ArrayList<Keyword>();
ArrayList<Focus> foci=new ArrayList<Focus>();
ArrayList<Focus> ingfoci=new ArrayList<Focus>();
ArrayList<Focus> arcfoci=new ArrayList<Focus>();
ArrayList<Focus> comparing;
int counter=58;
Focus ing;
Focus arc;
Focus des;
int state=0;
PFont font;
float ra=450;
Keyword vip_k;
String[] roman = {
  "I", "II", "III", "IV", "V"
};
Minim minim;
AudioPlayer player;
ArrayList<String> foci_str=new ArrayList<String>();
String vip = "mobile";

void setup() {
  size(1920, 1080, OPENGL);
  smooth(8);
  // Ani.init() must be called always first!
  Ani.init(this);
  minim = new Minim(this);
  player = minim.loadFile("swosh1.wav");
  comparing = new ArrayList<Focus>();
  font = loadFont("DIN-m30.vlw");
  textFont(font, 12);
  cam = new PeasyCam(this, 950);
  cam.lookAt(width/2, height/2, 0);
  //physics = new MPhysics(new Vec(100,10),new Vec(width-100,height-100));
  physics = new MPhysics();
  physics.setfriction(0.6f);

  ing = new Focus("ing","Engineering", width/2, height/2,#713784);
  arc = new Focus("arc","Architecture",  width/2, height/2,#98D957);
  des = new Focus("des","Design",  width/2, height/2,#F76634);

  foci.add(ing);
  foci.add(arc);
  foci.add(des);
  
 
  ingfoci.add(new Focus("ingI","Environmental and civil Engineering",  width/2, height/2,#1A175F));
  ingfoci.add(new Focus("ingII","Systems Engineering",  width/2, height/2,#342269));
  ingfoci.add(new Focus("ingIII","Industrial processes Engineering", width/2, height/2,#5b2e7a));
  ingfoci.add(new Focus("ingIV","Industrial Engineering",  width/2, height/2,#88408E));
  ingfoci.add(new Focus("ingV","Information Engineering",  width/2, height/2,#bb52a4));
  
  arcfoci.add(new Focus("arcI", "Architecture and society", width/2, height/2,#FCEE21));
  arcfoci.add(new Focus("arcII", "Civil architecture", width/2, height/2,#3BB95F));


  loadKeywords();

   foci_str.add("ingV");
   foci_str.add("des");
   compare();
}

void draw() {

  background(0);
  
  if(counter>60) {
    counter=1;
   //addSeparation();
   startAnimation();
    
  }
  
  else if(counter>0) counter++;
  
  //println(counter);
  
  physics.update();
  hint(DISABLE_DEPTH_TEST);
  stroke(255, 10);
  
  hint(ENABLE_DEPTH_TEST);

  for (int i = 1; i < keywords.size() - 1; i++) {
    Keyword p = keywords.get(i);
    textAlign(LEFT);
    textFont(font, 12);
    if (p.onScreen) drawCircle(p);
  }
  textAlign(CENTER);
  
  for(Focus f : comparing) {
    f.draw();
  }
  
}


void loadKeywords() {
  values=loadJSONArray("total500.json");
  for (int i = 0; i < values.size(); i++) {
    Vec pos=new Vec(random(width), random(height));
    float rad=5;
    float mas=5;
    JSONObject kw = values.getJSONObject(i);
    Keyword k = new Keyword(pos, mas, rad, kw);
    k.addBehavior(new BCollision());
    
    float myx=0;
    float myy=0;
   
    keywords.add(k);
    physics.addParticle((VParticle)k);
  }
    addSeparation();
  }
  
  



void drawCircle(Keyword p) {

  if (p.onScreen) {
    float x=p.x;
    float y=p.y; 
    float m=p.getRadius()*2;
    float r=0;
    float g=0;
    float b=0;
    float mtot=0;
     for( Focus s : comparing) {
       mtot+=p.getField(s.id);
     }
    
    for(Focus s : comparing) {
      r=r+red(s.col)*p.getField(s.id)/mtot;
      g=g+green(s.col)*p.getField(s.id)/mtot;
      b=b+blue(s.col)*p.getField(s.id)/mtot;
    }
    if(p.name.equalsIgnoreCase(vip) && p.radius>0) {
      vip_k=p;
      stroke(255,240);
      strokeWeight(2);
      fill(0);
      ellipse(x,y,m+7,m+7);
    }
    color col = color(r, g, b); 
    fill(col, 160);
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

String convertToRoman(int nu) {
  return roman[nu];
}


void keyReleased() {
  player.play();
  player.rewind( );
  if(key=='a') {
    String[] from = new String[]{
    "ing",
"arc",
"des",
"ingI",
"ingII",
"ingIII",
"ingIV",
"ingV",
"arcI",
"arcII"};
float r= random(0,from.length-1);

    if(!foci_str.contains(from[int(r)])) foci_str.add(from[int(r)]);
  }
  else if (key =='x') foci_str.remove(0);
  //if(!foci_str.contains("ingII")) foci_str.add("ingII");
  compare();
}



void compare() {
  
  state=2;
  counter=58;
  ArrayList foci_copy=new ArrayList<String>(foci_str);
  Iterator itr = comparing.iterator();
      while(itr.hasNext()) {
         Focus element = (Focus)itr.next();
         if (!foci_copy.contains(element.id)) 
         {
           physics.removeParticle(element);
           itr.remove();
         }
         else foci_copy.remove(element.id);
      }

  
  //find foci
  for (int i = 0; i<foci_copy.size(); i++) {
     //fac
    for (Focus fo : foci) {
      if (fo.id.equals(foci_copy.get(i))) {
        comparing.add(fo);
      }
    }
    
    //ing
    for (Focus fo : ingfoci) {
      if (fo.id.equals(foci_copy.get(i))) {
        comparing.add(fo);
      }
    }
    //arc
    for (Focus fo : arcfoci) {
      if (fo.id.equals(foci_copy.get(i))) {
        comparing.add(fo);
      }
    }
  }
  
  //position foci
  for (int i = 0; i<comparing.size(); i++) {
    float nx=width/2+ra*cos(-TWO_PI/comparing.size()*i);
    float ny=height/2+ra*sin(-TWO_PI/comparing.size()*i);
    Ani.to(comparing.get(i), 0.3, "x", nx,Ani.QUART_OUT);
    Ani.to(comparing.get(i), 0.3, "y", ny,Ani.QUART_OUT);
    //comparing.get(i).x=nx;
    //comparing.get(i).y=ny;
    physics.addParticle(comparing.get(i));
  }

  //assign nodes to foci
  for (Keyword ke : keywords) {
    ke.behaviors.clear();
    ke.addBehavior(new BCollision());
    float rad=0;
    boolean found=false;
    for (Focus fo : comparing) {
      if (ke.getField(fo.id)>0) {
        rad+=ke.getField(fo.id);
        found=true;
      }
    }
    
    if (!found) {
     Ani.to(ke, 0.3, "radius", 0,Ani.QUART_OUT);
      //ke.onScreen=false;
    }
    else {
      if(!ke.onScreen) ke.onScreen=true;
      Ani.to(ke, 1.0, "radius", sqrt(rad),Ani.QUART_OUT);
    }
  }
  addSeparation();
}

//adds separation
void addSeparation() {
  for (Keyword ke : keywords) {
   ke.addBehavior(ke.separation); 
 } 
}

void startAnimation() {
  
  for(Keyword k : keywords) {
    float myx=0;
    float myy=0;
    float mtot=0;
     for( Focus s : comparing) {
       mtot+=k.getField(s.id);
     }
    for( Focus s : comparing) {
     
      if(k.getField(s.id)>0) {
      float ox=s.x*(k.getField(s.id)/mtot);
      float oy=s.y*(k.getField(s.id)/mtot);
      myx=myx+ox;
      myy=myy+oy;
     
      }
    }
    if(myx==0 || myy==0) {
      //k.onScreen=false;
      //println(k.name);
    }
    else {
      //println(myx+" "+myy);
      if(k.behaviors.size()>12) k.behaviors.remove(2);
      k.addBehavior(new BSeek(new Vec(myx+random(-200,200),myy+random(-200,200)),4));
  }
}
}