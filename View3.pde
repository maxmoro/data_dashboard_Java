class View3  //<>//
{
  private Controller controller;
  private HashMap<String, OrgData> myData;
  private OrgData datum = null;
  private float x,y,chartWidth,chartHeight;
  
   private OrgData data;
   private DataSource dataSource;
   protected HashMap<String, Boxes> boxes;
   private PImage img;
   
  public View3(Controller _controller, DataSource dataSource,float x, float y,float chartWidth, float chartHeight)
  {
    controller = _controller;
    this.dataSource=dataSource;
    this.x = x;
    this.y = y;
    this.chartWidth=chartWidth;
    this.chartHeight=chartHeight;
    
    myData = dataSource.getData();
    setSelected(dataSource.getFirstMgr());
  }
  
 
  
  public void printInfo(){
     if (datum != null){
       //IMAGE
       image(img, x, y,chartWidth * .30, img.height/img.width*(chartWidth*.30));
       
       //NAME
       fill(0);
       printText(datum.name,  chartWidth *.65 , chartHeight*.13, x+chartWidth * .35,  y,"L");
       
       //ROLE
       textSize(30);
       printText(datum.role,  chartWidth *.65 , chartHeight*.1, x+chartWidth * .35,   y+chartHeight*.12,"L");
       //text(datum.role, x+chartWidth * .35,  y+chartHeight*.15);
       
       //BUDGET
       String text="Total Budget" ;
       printText(text,  chartWidth *.7 , chartHeight*.075, x+chartWidth * .35,  y+chartHeight*.23,"L");
       text= "$" + nfc((int)datum.budget);
       printText(text,  chartWidth *.35 , chartHeight*.075, x+chartWidth * .35,  y+chartHeight*.23,"R");
       printText("(" + (round(abs(datum.budget/ datum.budget * 100)*10)/10) + "%)" , chartWidth *.08 , chartHeight*.055, x+chartWidth * .72,  y+chartHeight*.23,"R");
       //EXPENSES
       text="Total Expenses" ;
       printText(text,  chartWidth *.7 , chartHeight*.075, x+chartWidth * .35,  y+chartHeight*.325,"L");
       text= "$" + nfc((int)datum.expenses);
       printText(text,  chartWidth *.35 , chartHeight*.075, x+chartWidth * .35,  y+chartHeight*.325,"R");
       printText("(" + (round(abs(datum.expenses/ datum.budget * 100)*10)/10) + "%)" , chartWidth *.08 , chartHeight*.055, x+chartWidth * .72,  y+chartHeight*.33,"R");
       //Below / Above
       text="Below Budget: " ;
       fill(0,150,0);
       if(datum.value<0) {
         fill(150,0,0);
         text="Above Budget: "  ;
       }
       float percBudget = datum.value / datum.budget * 100;
       printText(text,  chartWidth *.7 , chartHeight*.075, x+chartWidth * .35,  y+chartHeight*.41,"L");
       text= "$" + nfc((int)abs(datum.value));
       printText(text,  chartWidth *.35 , chartHeight*.075, x+chartWidth * .35,  y+chartHeight*.41,"R");
       printText("(" + (round(abs(percBudget)*10)/10) + "%)" , chartWidth *.08 , chartHeight*.055, x+chartWidth * .72,  y+chartHeight*.42,"R");
       //Gauge
       
       String text2 = "Below";
       if(percBudget<0) text2="Above";
       float budgetPercAbsMaxRound = ceil(dataSource.getBudgetPercAbsMax() *100)*1.0;
       text = "(" + (round(abs(percBudget)*10)/10) + "% " + text2 + " budget)";
       
       gaugePerc(chartWidth *.6 , chartHeight*.18, x+chartWidth * .35,  y+chartHeight*.6,-budgetPercAbsMaxRound,+budgetPercAbsMaxRound,percBudget,text);
    }
    
  }
 
  private void gaugePerc(float w, float h, float x, float y, float negPerc, float posPerc, float value,String text ){
      float negX = x;
      float negW = (abs(negPerc) / (abs(negPerc)+posPerc)) * w;
      float posX = x + negW;
      float posW = (abs(posPerc) / (abs(negPerc)+posPerc)) * w;
      //BOX
      fill(0,150,0,50);
      //rect(negX, y,  negW,h);
      triangle(negX,y,negX,y+h,negX+negW,y+h);
        
      fill(150,0,0,50);
      //rect(posX, y,  posW,h);
      triangle(posX,y+h,posX+posW,y,posX+posW,y+h);
      
      //ARROW
      float posValue =posX - ((value / (abs(negPerc)+posPerc)) * w);
      float posValueY = y+(-abs(posValue-posX) * h/posW);
      fill(150,0,0);
      if(value>0) fill(0,150,0);
      drawArrow(posValue,posValueY,w*.03,h,0,1);
      if(value<0) printText(text , w*.4, h, posValue - w*.43 , y-h/2,"R");
      if(value>=0) printText(text ,w*.4, h, posValue +w*.03, y-h/2,"L");
       
      //ticks
      fill(100);
      pushMatrix();
        translate(negX+w*.015,y+h*.99);
        rotate(radians(270));
        printText(round(negPerc) + "%" , h*.99, w*.5 , 0 ,0,"L");
        translate(0,negW*2-w*.04);
        printText("+" + round(posPerc) + "%" , h*.99, w*.5 , 0 ,0,"L");
      popMatrix();
      
  } //<>//
  
  public void setSelected(String id){
    datum = myData.get(id);
    img = loadImage(datum.id + ".jpg");
  }

  
  public void draw()
  {
    
     printInfo();
     
  }
 
}
