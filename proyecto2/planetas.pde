class planeta {

  Body body;
  float w;
  float h;
  float x;
  float y;
  float tipo;


  planeta(float x_, float y_) {
    this.x=x_;
    this.y=y_;
    tipo=random(1,5);
    w = random(40,50);
    h = w;
    makeBody(new Vec2(x,y),w,h);
  }
  
   void makeBody(Vec2 center, float w_, float h_) {

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 100;
    fd.friction = 20;
    fd.restitution = 0.5;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position= box2d.coordPixelsToWorld(x,y);

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }

  void killBody() {
    box2d.destroyBody(body);
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
    pushMatrix();
    translate(pos.x,pos.y);
    fill(0);
    stroke(0);
    ellipse(0,0,w,h);
    imageMode(CENTER);
    if(tipo<2.5){
    image(planeta3,0,0,w,h);
    }else{image(planeta,0,0,w,h);}
    popMatrix();
  }
  
  Vec2 posicion(){
    return(box2d.getBodyPixelCoord(body));
  }
}
