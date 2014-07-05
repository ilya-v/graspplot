  

BufferedReader reader;
String line;

int qmax = 0, qmin = 10000000;
 
int D[][] = new int[1000000][5];
int Q[] = new int[1000000];
int n = 0;
 
void setup() {
  size(600, 127 * 5);
  reader = createReader("varezhka-R1.1.txt");

  try {
    for (n = 0; ; n++)  {
      line = reader.readLine();
      if (line == null)
        break;
      String[] pieces = split(line, ' ');   
      D[n][0] = height - unhex(pieces[0]);
      D[n][1] = height - unhex(pieces[1]);
      D[n][2] = height - unhex(pieces[2]);
      D[n][3] = height - unhex(pieces[3]);
      D[n][4] = height - unhex(pieces[4]);
      Q[n]    = int(pieces[5]);
      qmax = max(qmax, Q[n]);
      qmin = min(qmin, Q[n]);
    }
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }  
  

}

 
void draw() { 
    
  fill(255, 255, 255);
  rect(0,0,width, height);
  fill(0, 0, 0);
  textSize(30);
  
  int S = 127;
  for (int i = 0; i < 5; i++)
  {
    line(0, height - i*S, width, height - i*S);
    text(str(i+1), 10, height - i*S);
  }
  
  line(0, height - 1*S, width, height - 1*S);
  line(0, height - 2*S, width, height - 2*S);
  line(0, height - 3*S, width, height - 3*S);
  line(0, height - 4*S, width, height - 4*S);
  line(0, height - 5*S, width, height - 5*S);


  for (int i = 0; i < n; i++) {
    int t = ((Q[i] - qmin) * width) / (qmax - qmin);
  
    int i1 = max(0, i-1);
    int t1 = ((Q[i1] - qmin) * width) / (qmax - qmin); 
    
    line(t1, D[i1][0] - 0*S, t, D[i][0] - 0*S);
    line(t1, D[i1][1] - 1*S, t, D[i][1] - 1*S);
    line(t1, D[i1][2] - 2*S, t, D[i][2] - 2*S);
    line(t1, D[i1][3] - 3*S, t, D[i][3] - 3*S);
    line(t1, D[i1][4] - 4*S, t, D[i][4] - 4*S);

  }
  noLoop();
} 

