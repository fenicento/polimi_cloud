class Keyword extends VParticle{
  
  String name;
  float ingI;
  float ingII;
  float ingIII;
  float ingIV;
  float ingV;
  float arcI;
  float arcII;
  float des;
  float arc;
  float ing;
  float tot;
  boolean onScreen=true;
  BSeparate separation;
  
  Keyword(Vec pos, float mas, float rad, JSONObject o) {
   super(pos,mas,rad);
   this.name=o.getString("name");
   this.ingI=o.getFloat("ingI");
   this.ingII=o.getFloat("ingII");
   this.ingIII=o.getFloat("ingIII");
   this.ingIV=o.getFloat("ingIV");
   this.ingV=o.getFloat("ingV");
   this.arcI=o.getFloat("arcI");
   this.arcII=o.getFloat("arcII");
   this.des=o.getFloat("des");
   this.ing=ingI+ingII+ingIII+ingIV+ingV;
   this.arc=arcI+arcII;
   this.tot=ing+arc+des;
   this.radius=sqrt(this.tot/PI)*2;
   this.weight=1/this.radius*150;
   this.separation = new BSeparate(this.radius*1.8, 100000000f, this.radius/10);
  
 
   println(this.name+" "+this.tot);
  } 
  
  private float getField(String str) {
        try {
            Field field = Keyword.class.getDeclaredField(str);
            field.setAccessible(true);
            return (Float) field.get(this);
        } catch (NoSuchFieldException e) {
            throw new IllegalStateException("Bad field name: " + str, e);
        } catch (IllegalAccessException e) {
            throw new IllegalStateException("Failed to access field " + str + " after making it accessible", e);
        }
    } 
}
