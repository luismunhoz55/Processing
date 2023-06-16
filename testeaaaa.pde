// Defining the global variables
int r = 0, g = 0, b = 0;

Cell[][] grid;
int cols, rows, 
res = 1; // The resolution to the grid, 1 is the best

float chance = 0.5; // This is what give the randomness to the algorithm

void setup() {
 size(1280,720);
 
 // Size of the grid
  cols = width / res;
  rows = height / res;
  
  grid = new Cell[cols][rows];
  
  //Populating the grid
  for(int i=0; i<cols; i++){
    for(int j=0; j<rows; j++){
      grid[i][j] = new Cell();
    }
  }
  
  int a = floor(random(grid.length));
  int b = floor(random(grid[0].length));
  
  // Creating a random cell with color, to start the algorithm
  grid[a][b] = new Cell(floor(random(255)), floor(random(255)), floor(random(255)));
 
}

void draw() {
 background(0);
 
  // Draw Grid
   for(int i = 0; i < cols; i++){
    for(int j = 0; j < rows; j++){
      Cell cell = grid[i][j];
      
      // Painting the grid
      int r = cell.red;
      int g = cell.green;
      int b = cell.blue;
       
      fill(r,g,b);
      noStroke();
      rect(i * res, j * res, res, res);
    }
  }
  
  // Creating the next grid
  Cell[][] next = new Cell[cols][rows];
  
  // Populating it
  for(int i=0; i<cols; i++){
    for(int j=0; j<rows; j++){
      next[i][j] = new Cell();
    }
  }
  
  // Iterating for all the cells
  for(int i = 1; i < cols-1; i++){
    for(int j = 1; j < rows-1; j++){
      
      // If the cell is already colorful, leave it as it is
      if(grid[i][j].active){
        next[i][j] = grid[i][j];
      }
      else{
      
        Cell neighbor = new Cell();
        
        // Iterating for all the neighbors of the cell
        for(int x=-1; x<2; x++){
          for(int y=-1; y<2; y++){
            
            // If some neighbor is active, there is some chance to the cell become active and mutate the color
            if(grid[i + x][y + j].active && grid[i + x][y + j] != grid[i][j]){
              
              float index = random(1);
              if(index > chance){
                neighbor = grid[i + x][y + j];
                break;
              }
            }
          
          }
        }
        
        // If the conditions are met, the Cell becomes alive
        if(neighbor.active){
         next[i][j] = new Cell(neighbor.red, neighbor.green, neighbor.blue); 
        }else{
         next[i][j] = grid[i][j]; 
        }
        
      }
      
    }
  }
  
  // The grid becomes the new grid
  grid = next;
  
  //If it's finished, save the picture and stop the loop
  if(check()) {
   save("background.png");
   noLoop();
  }
  
}

void mousePressed(){
  
  // Create a colorful cell at mouse position
  createCell(mouseX, mouseY);
  
}

void createCell(int x, int y){
  int i = x / res;
  int j = y / res;
  
  grid[i][j] = new Cell(randomColor(), randomColor(), randomColor());
}

int randomColor(){
   return floor(random(255));
}

// Checks if the entire grid is a colorful Cell
boolean check(){
  
  for(int i = 1; i < cols-1; i++){
    for(int j = 1; j < rows-1; j++){
      
      boolean test = grid[i][j].active;
      if(!test){
       return false; 
      }
      
    }
  }
  
  return true;
}
