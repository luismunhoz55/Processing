int cols, rows;
float[][] grid;
int rez = 10;

void setup() {
  size(600, 400);
  
  cols = 1 + width / rez;
  rows = 1 + height / rez;
  
  grid = new float[cols][rows];
  
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      grid[i][j] = random(-1 ,1);
    }    
  }
  
  //PVector pt = calcPointA(0, 0, 0, 0.2);
  //PVector pt = calcPointB(0, 0, 1, 0.2);
  PVector pt = calcPointB(0, 0, 1, 0.2);
  
  print(pt.x + "\n");
  print(pt.y);
  
}

void draw() {
  background(0);
  
  // for(int i = 0; i < cols; i++) {
  //  for(int j = 0; j < rows; j++) {
      
  //    int num = round(grid[i][j]);
       
  //    strokeWeight(2);
  //    stroke(255 * num); 
  //    point(i * rez, j * rez);
       
  //  }    
  //}
  
  for(int i = 0; i < cols - 1; i++) {
    for(int j = 0; j < rows - 1; j++) {
      
      float qA, qB, qC, qD;
      
      qA = grid[i    ][j    ];
      qB = grid[i + 1][j    ];
      qC = grid[i + 1][j + 1];
      qD = grid[i    ][j + 1];
      
      int x = i * rez;
      int y = j * rez;
      
      PVector ptA = new PVector(x + rez * 0.5, y);
      PVector ptB = new PVector(x + rez, y + rez * 0.5);
      PVector ptC = new PVector(x + rez * 0.5, y + rez);
      PVector ptD = new PVector(x, y + rez * 0.5);
      
      int[] points = {getPoint(qA), getPoint(qB), getPoint(qC), getPoint(qD)};
      
      int binarie = calculateBin(points);
          
      switch(binarie){
        case 0:
          break;
        case 1: 
          line(ptC, ptD);
          break;
        case 2:
          line(ptB, ptC);
          break;
        case 3:
          line(ptB, ptD);
          break;
        case 4:
          line(ptA, ptB);
          break;
        case 5:
          line(ptA, ptD);
          line(ptB, ptC);
          break;
        case 6:
          line(ptA, ptC);
          break;
        case 7:
          line(ptA, ptD);
          break;
        case 8:
          line(ptA, ptD);
          break;
        case 9:
          line(ptA, ptC);
          break;
        case 10:
          line(ptA, ptB);
          line(ptC, ptD);
          break;
        case 11:
          line(ptA, ptB);
          break;
        case 12:
          line(ptB, ptD);
          break;
        case 13:
          line(ptB, ptC);
          break;
        case 14:
          line(ptC, ptD);
          break;
      }
          
    }
  }
  
}

void calcPoints(float a, float b, float c, float d) {
  
    float newQA, newQB, newQC, newQD;
    
    newQA = getPosNum(a);
    newQB = getPosNum(b);
    newQC = getPosNum(c);
    newQD = getPosNum(d);
    
    
  
}

PVector calcPointB(int i, int j,float a, float b){
  
    int x = i * rez;
    int y = j * rez;
    
    float newQA, newQB;
    
    newQA = getPosNum(a);
    newQB = getPosNum(b);
    
    float scale = 0;
    
   //PVector ptB = new PVector(x + rez, y + rez * 0.5);
    
    if(newQA == 0 && newQB == 0) return new PVector(0, 0);
    
    if(newQA == 0 && newQB > 0 || newQB > newQA){
       scale = calcScale(newQB);
       
       return new PVector(x + rez, y + 0.5 * rez + scale * rez);
    } else if (newQB == 0 && newQA > 0 || newQA > newQB){
      scale = calcScale(newQA);
      
      return new PVector(x + rez, y + scale * rez);
    }
    
     return new PVector(0, 0);
    
}

PVector calcPointA(int i, int j,float a, float b){
  
    int x = i * rez;
    int y = j * rez;
    
    float newQA, newQB;
    
    newQA = getPosNum(a);
    newQB = getPosNum(b);
    
    float scale = 0;
    
    if(newQA == 0 && newQB == 0) return new PVector(0, 0);
    
    if(newQA == 0 && newQB > 0 || newQB > newQA){
       scale = calcScale(newQB);
       
       return new PVector(x + 0.5 * rez + scale * rez, y);
    } else if (newQB == 0 && newQA > 0 || newQA > newQB){
      scale = calcScale(newQA);
      
      return new PVector(x + rez * scale, y);
    }
    
     return new PVector(0, 0);
    
}

PVector calcPointC(int i, int j,float a, float b){
  
    int x = i * rez;
    int y = j * rez;
    
    float newQA, newQB;
    
    newQA = getPosNum(a);
    newQB = getPosNum(b);
    
    float scale = 0;

    //PVector ptC = new PVector(x + rez * 0.5, y + rez);
    
    if(newQA == 0 && newQB == 0) return new PVector(0, 0);
    
    if(newQA == 0 && newQB > 0 || newQB > newQA){
       scale = calcScale(newQB);
       
       return new PVector(x + scale * rez + 0.5 * rez, y + scale);
    } else if (newQB == 0 && newQA > 0 || newQA > newQB){
      scale = calcScale(newQA);
      
      return new PVector(x + scale * rez, y + scale);
    }
    
     return new PVector(0, 0);
    
}

int calculateBin (int[] array){
   return 8 * array[0] + 4 * array[1] + 2 * array[2] + 1 * array[3]; 
}

void line(PVector a, PVector b){
  stroke(255);
  strokeWeight(1);
  line(a.x, a.y, b.x, b.y); 
}

int getPoint(float num){
  if(num <= 0) return 0;
  
  return 1;
}

float calcScale(float pt) {
  return map(pt, 0, 1, 0, 0.5);
}

float getPosNum(float num) {
   if(num <= 0) {
     return 0;
   }
   
   return num;
}
