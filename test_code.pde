ArrayList<GDP> gdp_arraylist = new ArrayList<GDP>();;

void setup(){
  
  size(500,500,P3D);
  background(0);
  
  //gdp_arraylist = new ArrayList<GDP>();
  
  loadData();
  
}// end setup




void loadData(){
  
  String[] lines = loadStrings("data/gdp.csv"); // files must be in the data folder
  
  for(int i = 0; i<lines.length; i++){
     gdp_arraylist.add(new GDP(lines[i]));
  }// end for loop
  
}// end loadData



void draw(){
  
 background(0);
 drawLineGraph();
 
}// end draw




void drawLineGraph(){
  
  float borderY = height *.10;
  float borderX = width *.10;
  
  int max_index = most_gdp(gdp_arraylist); // find most gdp
  int low_index = least_gdp(gdp_arraylist); // find lowest gdp
  
  float dataRange = gdp_arraylist.get(max_index).gdp_amount; // place it in dataRange
  float startRange = gdp_arraylist.get(low_index).gdp_amount;
  
  stroke(255);
  line(borderX, borderY, borderX, height - borderY); // draw Y axis
  line(borderX, height - borderY, width-borderX , height - borderY); // drw X axis
  
  line(borderX, height - borderY, borderX, height - borderY + (height *.02)); // draw tick y
  line(borderX, height - borderY, borderX - (height *.02), height - borderY); // draw tick x
 
  for(int i = 1; i < gdp_arraylist.size(); i++){
    
    float x1 = map(i - 1, 0 , gdp_arraylist.size()-1, borderX, width - borderX);
    float x2 = map(i,0, gdp_arraylist.size()-1, borderX, width - borderX);
    float y1 = map(gdp_arraylist.get(i - 1).gdp_amount, startRange , dataRange, height - borderY, borderY );
    float y2 = map(gdp_arraylist.get(i).gdp_amount, startRange , dataRange, height  - borderY, borderY);
    
    stroke(0, 100, 255);
    line(x1, y1, x2, y2);
    ellipse(x1,y1, 10,10);
    ellipse(x2,y2, 10,10);
    
    mouse_hover(x1,y1,x2,y2,i); // check if mouse is over

  }// end 
  
  
}// end draw line




// method to find most gdp
int most_gdp(ArrayList<GDP> arrayList){
  
  float most_gdp = arrayList.get(0).gdp_amount;
  int HighIndex = 0; 
  for(int i = 1; i < arrayList.size(); i++){
    
    if (arrayList.get(i).gdp_amount > most_gdp){ 
      most_gdp = arrayList.get(i).gdp_amount;
      HighIndex = i;
    }// end if
    
  }// end for
  
  return HighIndex;
  
}// end most_gdp



// method to find least gdp
int least_gdp(ArrayList<GDP> arrayList){
  
  float least_gdp = arrayList.get(0).gdp_amount;
  int LowIndex = 0; 
  for(int i = 1; i < arrayList.size(); i++){
    
    if (arrayList.get(i).gdp_amount < least_gdp){ 
      least_gdp = arrayList.get(i).gdp_amount;
      LowIndex = i;
    }// end if
    
  }// end for
  
  return LowIndex;
  
}// end most_gdp




// method to check if mouse over
void mouse_hover(float x1,float y1, float x2, float y2,int i){
  
  float borderY = height *.10;
  float borderX = width *.10;
  //    float x2 = map(i,0, gdp_arraylist.size()-1, borderX, width - borderX);
  float gap = map(1,0,gdp_arraylist.size(),borderX,width - borderX);
  
  println(gap);
  
  stroke(255,0,0);
  fill(255,0,0);
  
  if( (mouseX <= x1 + gap) && (mouseX >= x1 - gap)   &&  (mouseY >= borderY ) && (mouseY <= height-(borderY) ) ){
      fill(255);
      ellipse(x1,y1,10,10);
      line(x1, borderY, x1, height - borderY);
      fill(255,0,0);
      text("Year: " + gdp_arraylist.get(i-1).year, x1 + 10,y1 + 20);
      text("GDP (Mill$): " + gdp_arraylist.get(i-1).gdp_amount, x1 + 10,y1 + 35);
    
  } else if( (mouseX <= x2 + gap) && (mouseX >= x2 - gap)   &&  (mouseY >= borderY ) && (mouseY <= height-(borderY)  )){
      ellipse(x2,y2,10,10);
      line(x2, borderY, x2, height - borderY);
      fill(255);
      text("Year: " + gdp_arraylist.get(i).year, x2 + 10,y2 + 20);
      text("GDP (Mill$): " + gdp_arraylist.get(i).gdp_amount, x2 + 10,y2 + 35);
  }
  
}// end mouse method