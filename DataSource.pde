import java.util.Map;
class DataSource { 
  private HashMap<String, OrgData> myData;
  private static final String DATA_URL = "https://raw.githubusercontent.com/maxmoro/processing/master/org_midterm.csv";
  private static final String DATA_LOCAL = "org_midterm.csv";
  private String DataLink;
  private Table table;
  private String updateDate;
  private float maxValue;
  private float budgetPercAbsMax;
  private String head;
  private String firstMgr;
  private OrgData data;
  private int totLayers;
  private int totRows ;
  private float minValue = 100000;
  
  public DataSource(int useInternet){
    if(useInternet==1) DataLink=DATA_URL; else DataLink=DATA_LOCAL;
    table = loadTable(DataLink,"header");
    int rows=0;
    float budgetPerc = 0.0;
    budgetPercAbsMax=0.0;
    myData = new HashMap<String, OrgData>();
    for (TableRow trow : table.rows()) {
      data = new OrgData();
      data.id =trow.getString("id");
      data.name=trow.getString("name") ;
      data.parentId = trow.getString("parent_id");
      data.value = trow.getFloat("value");
      data.role = trow.getString("role");
      data.expenses = trow.getFloat("expenses");
      data.budget = trow.getFloat("budget");
      myData.put(data.id,data);
      if(rows==0) {
          updateDate = trow.getString("update");
          head = data.id;
      }
      if(rows==1) firstMgr = data.id;
      budgetPerc =  data.value  /  data.budget;
      if(budgetPerc > budgetPercAbsMax) {
        budgetPercAbsMax =budgetPerc; //<>//
      }
      if(data.value > maxValue) maxValue = data.value;
      if(data.value < minValue) minValue = data.value;
      rows++;
    }
    totRows = rows;
    totLayers = getNumLayers(head);
  }
 
 public int getTotRows(){return totRows;}
 
 public HashMap<String, OrgData> getData(){return myData;}
  
 public String getUpdateDate(){return updateDate;}  
 
 public String getHead(){return head;}
 
 public String getFirstMgr(){return firstMgr;}
 
 public int getTotLayers(){return totLayers;}
  
 public float getMaxValue(){return maxValue;}
 
 public float getMinValue(){return minValue;}
 
 public float getBudgetPercAbsMax(){return budgetPercAbsMax;}
 
 
 public float getRange(){return abs(maxValue- minValue);}
  
 public int getNumChilds(String parentId){
    int num_childs=0;
    String t="";
    for(Map.Entry me : myData.entrySet()){
      data=(OrgData)me.getValue();
      if(int(data.parentId) ==  int(parentId)) {
       num_childs++;
      }
    }
    return num_childs;
  }
  
   public int getNumLayers(String parentId){
    int childs = getNumChilds(parentId);
    int layer=0;
    int childsMax=0;
    int childsCount=0;
    if(childs!=0){
      layer=1;
      for(Map.Entry me : myData.entrySet()){
        data=(OrgData)me.getValue();
        if(int(data.parentId)==int(parentId)){
          childsCount=getNumLayers(data.id);
          if(childsCount>childsMax) childsMax= childsCount;
        }
      }
      layer = layer +childsMax;
    }
    return(layer);
  }
  
}
  
