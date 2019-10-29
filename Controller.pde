class Controller{
  private Model model;
  private View1 view1;
  private View2 view2;
  private View3 view3;
  private float view1W = 0.7;
  private float view1H = 1;
  private float view2W = 1 - view1W;
  private float view2H = 0.8;
  private float view3W = 1 - view1W;
  private float view3H = 1 - view2H;
  private Boxes box;
  
  
  //private View2 view2;
    
  public Controller(int useInternet)
  {
    model = new Model(this,useInternet);
    view1 = new View1(this,model.getData(),0,0,width * view1W, height * view1H);
    view2 = new View2(this,model.getData(),width * view1W, height*.1, width * view2W *.98, height * view2H - height*.1);
    view3 = new View3(this,model.getData(),width * view1W, height * view2H * 1.05, width * view3W  , height * view3H);
    
  }
  
  public void update()
  {
    view1.draw();
    view2.draw();
    view3.draw();
    
  }
  
  
  public void select(OrgData selData)
  {
   if(selData != null) {
      
       view1.setSelected(selData.id);
       view2.setSelected(selData.id);
       view3.setSelected(selData.id);
   }
  }
  
  /*
  public void mouseClicked(){
     datum = view1.getBoxData(mouseX,mouseY);
     if(datum == null) {
       print("try2");
       datum = view2.getBoxData(mouseX,mouseY);
     }
     if(datum != null) {
       view1.setSelected(datum.id);
       view2.setSelected(datum.id);
       view3.setSelected(datum.id);
       print(datum.name);
     } 
  }
*/
}
