
class Box {

  Body body;
  float w;
  float h;
  float x;
  float y;

  // Constructor
  Box(float x_, float y_) {
    x = x_;
    y = y_;
    w = 24;
    h = 24;
    makeBody(new Vec2(x,y),w,h);
    body.setUserData(this);
  }

  void killBody() {
    //box2d.destroyBody(body);
    body.setTransform(new Vec2(width/2, height), body.getAngle());
  }

  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }

 
  void display() {
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    //rotate(a);
    fill(0);
    stroke(0);
    ellipse(0,0,w,h);
    imageMode(CENTER);
    image(nave,0,0,w,h);
    popMatrix();
    
    if(pos.y>height){
      estado=3;
      body.setLinearVelocity(new Vec2(0,0));
    }
    
    
    
 
  }



  void makeBody(Vec2 center, float w_, float h_) {
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 20;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    body.createFixture(fd);
    body.setLinearVelocity(new Vec2(0,0));
    body.setAngularVelocity(0);
  }

}
