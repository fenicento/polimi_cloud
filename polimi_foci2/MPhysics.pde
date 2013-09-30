class MPhysics extends VPhysics{
  
 MPhysics(Vec w, Vec h) {
  
  super(w,h);
  
 } 
 
 MPhysics() {
  
  super();
  
 } 
 
 void clearSprings() {
  
  this.springs.clear();
  this.springMap.clear();
   
 }
  
 void relaxSprings() {
    
   for(VSpring s : this.springs) {
    s.setStrength(0); 
   }
 } 
 
 
  
}
