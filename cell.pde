class Cell{
 
  int red = 0, blue = 0, green = 0;
  boolean active; // Determines if the cell is alive or dead
  
  Cell(){
    active = false;
  }
  
  Cell(int r, int g, int b){
    active = true;
    
    // The colors of the cell
    this.red = r;
    this.green = g;
    this.blue = b;
    
    // The offset to chance the color just a little bit
    int offset = floor(random(-20, 20));
    int index = floor(random(3));
    
    // Change just one of the three colors
    if(index == 0) this.red += offset;
    else if(index == 1) this.green += offset;
    else this.blue += offset;
    
  }
  
}
