class View1 
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
   private float x,y,chartWidth,chartHeight;
   protected HashMap<String, Boxes> boxes;
  
   
  public View1(Controller _controller, DataSource dataSource,float x, float y,float chartWidth, float chartHeight)
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
    
    int l = dataSource.getTotLayers();
    layerH=(chartHeight*.85)/l;
    maxValue = dataSource.getMaxValue();
    createOrg(dataSource.getHead(), x+chartWidth*.025, y+chartHeight*.10, chartWidth*.95);
  }
  
  
  
  public void drawChart(){
    int l = dataSource.getTotLayers();
    layerH=(chartHeight*.85)/l;
    maxValue = dataSource.getMaxValue();
    drawBoxes();
    //TEXT
    fill(0);
    printText("Organization Chart and Expenses Levels",chartWidth*.8,chartHeight*.05,x+chartWidth*.1,y+chartHeight*.05,"");
    //printText("Double Click on a Box to Drill Down",chartWidth*.2,chartHeight*.2,x+0,y+chartHeight*.01,"");
    printText("Last Update " + dataSource.getUpdateDate(),chartWidth*.5,chartHeight*.02,x+chartWidth*.5,y+chartHeight*.98,"");
    //LEGEND
    drawBox(x+chartWidth*.05,y+chartHeight*.90,chartHeight*.05,chartWidth*.1,10,"Below Budget",maxValue,0);
    drawBox(x+chartWidth*.05,y+chartHeight*.95,chartHeight*.05,chartWidth*.1,-10,"Above Budget",maxValue,0);
    //printText("Green = Within Budget   | Red = Outside Budget",chartWidth*.5ght*.03,0,chartHeight*.98);
    //Mouse?
    data = getBoxData(mouseX,mouseY);
    if(data != null) controller.select(data);
    
  }
  
  private void drawBoxes(){
    int boxSelected=0;
    for(Map.Entry me : boxes.entrySet()){
      box=(Boxes)me.getValue();
      if(box.id == selectedId) boxSelected = 1; else boxSelected=0;
      data=(OrgData)myData.get(box.id);
      drawBox(box.X,box.Y,box.H,box.W,data.value,data.role,maxValue,boxSelected);
    }
  }
 
  private void createOrg(String parentId,float x,float y,float parentW){
    int childs = dataSource.getNumChilds(parentId);
    if(childs!=0){
      float childW = parentW/childs;
      for(Map.Entry me : myData.entrySet()){
        data=(OrgData)me.getValue();
        if(int(data.parentId)==int(parentId)){
          box = new Boxes();
          box.id =data.id;
          box.X=x;
          box.Y=y;
          box.W=childW;
          box.H=layerH;
          boxes.put(box.id, box);
          createOrg(box.id,x ,y+layerH+1,childW-1);
          x=x+childW+1;
        }
      }
    }
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
  
  public void setSelected(String id){
    selectedId = id;
  }

  
  public void draw()
  {
     drawChart();
  }
  
  public OrgData getBoxData(float x, float y){
    box= getBox(x,  y);
    if(box == null) return(null);
    OrgData datum;
    data= myData.get(box.id);
    return(data);
  }
  
  //<>//
}
