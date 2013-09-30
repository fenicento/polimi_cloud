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
    ellipseMode(CENTER);
    //println(this.id);
    //println(this.name);
    //println(this.x+" "+this.y);
   fill(255);
    ellipse(x,y,100,100);
    fill(0);
    rectMode(CENTER);
    text(this.name.toUpperCase(),x,y,90,30);
    
  }
  
  
  
  
  
}
