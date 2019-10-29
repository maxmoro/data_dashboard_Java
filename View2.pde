class View2  //<>//
{
  private Controller controller;
   private Boxes box;
   private HashMap<String, OrgData> myData;
   private OrgData data;
   private DataSource dataSource;
   private float layerH;
   private float maxValue;
   private int totRows;
   private String selectedId="";
   private float selectedValue=0;
   private float[] sortedValues;
   private String[] sortedValuesId;
   private float x,y,chartWidth,chartHeight;
   protected HashMap<String, Boxes> boxes;
  
   
  public View2(Controller _controller, DataSource dataSource,float x, float y,float chartWidth, float chartHeight)
  {
    controller = _controller;
    this.dataSource=dataSource;
    this.x = x;
    this.y = y;
    this.chartWidth=chartWidth;
    this.chartHeight=chartHeight;
    
    totRows = dataSource.getTotRows();
    boxes = new HashMap<String, Boxes>();
    myData = dataSource.getData();
    setSelected(dataSource.getFirstMgr());
    getSortedValues();
    
  }
  
  private void getSortedValues(){
    sortedValues = new float[dataSource.getTotRows()];
    int i=0;
    for(Map.Entry me : myData.entrySet()){
      data=(OrgData)me.getValue();
        sortedValues[i] = data.value;
        i++;
    }
    sortedValues = reverse(sort(sortedValues)) ;
    //finding the id of the sorted values
    sortedValuesId = new String[dataSource.getTotRows()];
    for(Map.Entry me : myData.entrySet()){
      data=(OrgData)me.getValue();
      for(i=0;i< dataSource.getTotRows();i++){
         if(sortedValues[i] == data.value) sortedValuesId[i]=data.id;
      }
    }
  }
  
  public void drawChart(){
    
    drawBars(x,y,chartWidth,chartHeight);
      
    //Mouse
    data = getBoxData(mouseX,mouseY);
    if(data != null) controller.select(data);
    
  }
 
  private void drawBars(float x, float y, float chartWidth, float chartHeight){
    float colH = chartHeight / dataSource.getTotRows();
    float zeroPos=0;
    int selected=0;
    float currY = y;
    boxes = new HashMap<String, Boxes>();
    if(dataSource.getMinValue()<0) zeroPos = (abs(dataSource.getMaxValue())/dataSource.getRange() * chartWidth);
    //grid
    stroke(0);
    strokeWeight(width/2000);
    float posX;
    //chart lines
    for(float i=-floor(dataSource.getMaxValue()/100)*100;
        i < -dataSource.getMinValue();i = i + 100){
        posX= x+zeroPos + i / dataSource.getRange() * chartWidth;
        line(posX ,height*.095,posX,chartHeight+y);
    }
    //bars
    for(int i=0;i< dataSource.getTotRows();i++){
      selected=0;
      box = new Boxes();
      box.id =sortedValuesId[i];
      box.X=x+zeroPos;
      box.Y=currY;
      box.W=(-sortedValues[i] / dataSource.getRange() * chartWidth) ;
      box.H=colH;
      if(box.W<0){
        box.W=abs(box.W);
        box.X = box.X-box.W;
      }
      if(selectedValue == sortedValues[i]){
        selected = 2;
        box.H=box.H*2;
      }
        
      boxes.put(box.id, box);
      
      drawBox(box.X, box.Y, box.H, box.W, sortedValues[i],"",dataSource.getMaxValue(),selected);
      if(selected == 2) {
        //print value
        float textW = chartWidth*.10;
        posX=box.X+box.W+5;
        String align="L";
        if(selectedValue>0) {
          posX=box.X-textW;
          align="R";
        }
        if((posX+textW)>(x+chartWidth)) posX=x+chartWidth - textW;
        if(posX<x) posX=x;
        fill(0);
        printText("$" + nfc((int)abs(selectedValue)),textW,box.H,posX, box.Y+box.H*.5,align); 
        //print title
        data=myData.get(box.id);
        posX=x+zeroPos+5;
        textW=(chartWidth-zeroPos)*1.05;
        align="L";;
        if(selectedValue<0) {
          textW=box.X-X;
          posX=x+zeroPos-textW;
          align="R";
        }
        printText(data.role,textW,box.H,posX, box.Y+box.H*.5,align);
      }
      currY = currY+box.H;
    }
    
    fill(0,200,0);
    String text="below budget";
    printText( text, zeroPos,height*.015, x,height*.07,"");
    fill(200,0,0);
    text="above budget";
    printText( text, chartWidth-zeroPos,height*.015, x+zeroPos,height*.07,"");
    stroke(124);
    strokeWeight(width/1000);
    line(x,height*.095,x+chartWidth,height*.095);
    line(x+zeroPos,height*.095,x+zeroPos,chartHeight);
    
  }
  
  public Boxes getBox(float x, float y){
    Boxes box;
    for(Map.Entry me : boxes.entrySet()){
      box=(Boxes)me.getValue();
      if ((x  >= box.X) && (x < (box.X+box.W)) && (y >= box.Y) && (y < (box.Y+box.H))){
        return(box);
      }
    }
    return (null);
  }
  
  
  public OrgData getBoxData(float x, float y){
    box= getBox(x,  y);
    if(box == null) return(null);
    OrgData datum;
    datum= myData.get(box.id);
    return(datum);
  }
  
  
  public void setSelected(String id){
    selectedId = id;
    selectedValue = myData.get(id).value;
   
  }

  
  public void draw()
  {
    
     drawChart();
     
  }
  /*
  public OrgData getBoxData(float x, float y){
    box= getBox(x,  y);
    if(box == null) return(null);
    OrgData datum;
    datum= myData.get(box.id);
    return(datum);
  }
  */
  
 
}
