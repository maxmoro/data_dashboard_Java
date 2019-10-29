import java.util.Map;
class Model{ 
  private Controller controller;
  private DataSource dataSource;
  
  
  public Model(Controller _controller, int useInternet){
    dataSource = new DataSource(useInternet);
  }
 
  public DataSource getData(){
    return(dataSource);
  }
  
  
}
  
