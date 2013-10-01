class Focus extends VParticle{
  
 String name;
 int col;
 String id;

Focus(String id, String n, float x, float y, int col) {
 
 super(x,y);
 this.lock();
 BSeparate separation = new BSeparate(110, 3.5f, 40f);
 this.name=n;
 this.col=col;
 this.id=id;
 this.setRadius(100);
 this.setWeight(2);
 this.addBehavior(new BCollision(4f));
 this.addBehavior(separation);
 this.lock();
 
} 
  
  void draw() {
    
    if(vip_k.getField(this.id)>0) {
      stroke(255,250);
      strokeWeight(2);
      
       line(this.x,this.y,-1,vip_k.x,vip_k.y,-1);
       Vec ball=this.interpolateTo(vip_k, .6);
       
       if (vip_k.radius<11) {
         textFont(font, 12);
         textAlign(LEFT);
         fill(255);
         noStroke();
         text(vip_k.name, vip_k.x+vip_k.radius+8, vip_k.y+vip_k.radius/2);
       }
       fill(0);
       noStroke();
       textAlign(CENTER);
       ellipse(ball.x,ball.y,30,30);
       textFont(font, 14);
       fill(255);
       text(String.valueOf(int(vip_k.getField(this.id))),ball.x,ball.y,30f,14f);
    
    }
    
    ellipseMode(CENTER);
    //println(this.id);
    //println(this.name);
    //println(this.x+" "+this.y);
   fill(255,220);
    ellipse(x,y,100,100);
    fill(0);
    rectMode(CENTER);
    
    if(this.name.length()<=12){
    textFont(font, 12);
    text(this.name.toUpperCase(),x,y,90,12);
    }
    else if(this.name.length()<=24) {
    textFont(font, 10);
    text(this.name.toUpperCase(),x,y,90,22);
    }
    else if(this.name.length()<=36) {
    textFont(font, 10);
    text(this.name.toUpperCase(),x,y,90,36);
    }
    else {
    textFont(font, 10);
    text(this.name.toUpperCase(),x,y,90,48);
    }
    
  }
  
  
  
  
  
}
