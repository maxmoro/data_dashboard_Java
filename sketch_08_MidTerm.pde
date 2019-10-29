Controller controller;
int useInternet = 0; //set this to 0 to use local file, 1 to use internet data
// photos from http://unsample.net/

void settings()
{
   //size(1024,800);
  fullScreen();
  
}

void setup(){
  controller = new Controller(useInternet);
  
}

void draw(){
  background(255);
  controller.update();
}
/*
void mouseClicked() {
    controller.mouseClicked();
}

 */
