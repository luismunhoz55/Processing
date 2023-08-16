Cell[][] grid, nextGrid; // Creating the cell grid
int cols, rows;

int res = 2; // The resolution to the grid, 1 is the most detailed
float chance = 0.2; // This is what give the randomness to the algorithm
boolean startAtCenter = false; // If true, the algorithm will start at the center with only 1 point
int startingPoints = 5; // How many points will start the algorithm

void setup() {
  size(600, 600);

  // Size of the grid
  cols = width / res;
  rows = height / res;

  grid = new Cell[cols][rows];
  nextGrid = new Cell[cols][rows];

  //Populating the grid
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      grid[i][j] = new Cell();
      nextGrid[i][j] = new Cell();
    }
  }

  if (startAtCenter) {

    int a = floor(rows / 2);
    int b = floor(cols / 2);

    // Creating a random cell with color, to start the algorithm
    grid[a][b] = new Cell(randomColor(), randomColor(), randomColor());
  } else {

    for (int i=0; i < startingPoints; i++) {

      int a = floor(random(grid.length));
      int b = floor(random(grid[0].length));

      // Creating a random cell with color, to start the algorithm
      grid[a][b] = new Cell(randomColor(), randomColor(), randomColor());
    }
  }
}

void draw() {
  background(0);

  // Draw Grid
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      Cell cell = grid[i][j];

      // Painting the grid
      int r = cell.red;
      int g = cell.green;
      int b = cell.blue;

      fill(r, g, b);
      noStroke();
      rect(i * res, j * res, res, res);
    }
  }
  
   //If it's finished, save the picture and stop the loop
  if (check()) {
    save("background.png");
    noLoop();
  }

  // Creating the next grid
  Cell[][] next = nextGrid;

  // Iterating for all the cells
  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows-1; j++) {

      // If the cell is already colorful, leave it as it is
      if (grid[i][j].active) {
        next[i][j] = grid[i][j];
      } else {

        Cell neighbor = new Cell();

        // Iterating for all the neighbors of the cell
        for (int x=-1; x<2; x++) {
          for (int y=-1; y<2; y++) {

            // If some neighbor is active, there is some chance to the cell become active and mutate the color
            if (grid[i + x][y + j].active && grid[i + x][y + j] != grid[i][j]) {

              float index = random(1);
              if (index < chance) {
                neighbor = grid[i + x][y + j];
                break;
              }
            }
          }
        }

        // If the conditions are met, the Cell becomes alive
        if (neighbor.active) {
          next[i][j] = new Cell(neighbor.red, neighbor.green, neighbor.blue);
        } else {
          next[i][j] = grid[i][j];
        }
      }
    }
  }

  // The grid becomes the new grid
  grid = next;

}

void mousePressed() {
  // Create a colorful cell at mouse position
  createCell(mouseX, mouseY);
}

void createCell(int x, int y) {
  int i = x / res;
  int j = y / res;

  grid[i][j] = new Cell(randomColor(), randomColor(), randomColor());
}

int randomColor() {
  return floor(random(255));
}

// Checks if the entire grid is a colorful Cell
boolean check() {

  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows-1; j++) {

      boolean test = grid[i][j].active;
      if (!test) {
        return false;
      }
    }
  }

  return true;
}
