class estrella {

  Body body;
  float w;
  float h;
  float gra;
  int col=0;

  estrella(float gra_,float x, float y) {
    this.gra=gra_;
    w = random(8,16);
    h = w;
    makeBody(new Vec2(x,y),w,h);
    body.setUserData(this);
  }
  
   void makeBody(Vec2 center, float w_, float h_) {

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
    
    body.setLinearVelocity(new Vec2(random(-5,5),random(-5,-5)));
    body.setAngularVelocity(random(-1,1));
  }
  
   void applyForce(Vec2 v) {
    body.applyForce(v, body.getWorldCenter());
  }


  void killBody() {
    box2d.destroyBody(body);
  }
  
   void attract(float x, float y) {
    Vec2 worldTarget = box2d.coordPixelsToWorld(x,y);   
    Vec2 bodyVec = body.getWorldCenter();
    worldTarget.subLocal(bodyVec);
    worldTarget.normalize();
    worldTarget.mulLocal(gra);
    body.applyForce(worldTarget, bodyVec);
  }

  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);  
    if (pos.y > height+w/2) {
      killBody();
      return true;
    }
    return false;
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    //rotate(-a);
    fill(col);
    stroke(0);
    ellipse(0,0,w,h);
    //imageMode(CENTER);
    image(asteroide,0,0,w,h);
    popMatrix();
  }
}
