    
  void drawBox(float x, float y, float h, float w, float value,String text,float maxValue,int selected){
    int r= 0;
    int b= 0;
    int g=0;
    int col = int(map(abs(value),0,abs(maxValue),100,200));
    if(value>0) g=col;
    if(value<=0) r=col;
    fill(r,g,b);
    stroke(100);
    strokeWeight(width/1500);
    if(selected == 1) {
      strokeWeight(width/1500*8);
      stroke(200,200,0);
    }
    if(selected == 2) {
      fill(200,200,0);
    }
    rect(x,y,w,h); 
         
    pushMatrix();
      float wt=0;
      float ht=0;
      if(w>(h*.8)) {
        translate(x,y+h/2);
        wt=w;
        ht=h;
      } else {
        wt=h;
        ht=w;
        translate(x+w/2,y);
        rotate(PI/2.0);
      }
      fill(255);
      if(text != "") printText(text,wt,ht,0,0,"");
    popMatrix();
  }
  
  void printText(String text, float wt,float ht,float x, float y,String align){
    textSize(12);
    float ts=0;
    float tsw=wt*.95/textWidth(text)*12;
    float tsh=ht*.98/textAscent()*12;
    if(tsh>tsw) ts=tsw; else ts=tsh;
    if(ts>80) ts=80;
    textSize(ts);
    if(align=="") text(text,x+(wt-textWidth(text))/2,y+textAscent()/2);
    if(align=="R") text(text,x+(wt-textWidth(text)),y+textAscent()/2);
    if(align=="L") text(text,x,y+textAscent()/2);
  }
  
  
void drawArrow(float cx, float cy, float w, float h, float angle,int animation){
  //print(frameCount) ;
  float y2=0;
  if (animation ==1)  y2 =-abs(cos(float(millis())/200)*h/5);
  pushMatrix();
    translate(cx, cy+y2);
    rotate(radians(angle));
    beginShape();
      vertex(0-w/2, 0);
      vertex(0+w/2, 0);
      vertex(0+w/2, h-w);
      vertex(0+w, h-w);
      vertex(0, h);
      vertex(0-w, h-w);
      vertex(0-w/2, h-w);
      vertex(0-w/2, 0);
    endShape();
  popMatrix();
}
