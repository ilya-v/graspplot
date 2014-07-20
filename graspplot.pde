import processing.net.*; 
Client client; 

int t0 = -1;

int t_width_ms = 10000;

int prev_t = -1; 
int[] prev_D = new int[10];
int idx_time = 10;

int S = 128;

void start_plot() {
  stroke(0,0,0);
  fill(255, 255, 255);
  rect(0,0,width, height);
  fill(0, 0, 0);
  textSize(30);  

  for (int i = 0; i < 5; i++)
  {
    line(0, height - i*S, width, height - i*S);
    text(str(i+1), 10, height - i*S);
  }
  
  t0 = -1;
  prev_t = -1;
}

boolean connect() {
  if (client == null || !client.active())
    client = new Client(this, "127.0.0.1", 11003);  
  
  if (!client.active())
  {
    client = null;
    print(millis(), '\n');
  }

  return (client != null);  
}
 
void setup() { 
  size(600, 128 * 5);
  start_plot();  
} 
 
void draw() {   
  if (!connect())  
    return;
  
  if (client.available() <= 0)
    return;
 
  String line = client.readStringUntil('\n');
  if (line == null)
    return;
  String[] pieces = split(line, ' ');
  if (pieces == null)
    return;
  
  int D[] = new int[10];
  
  for (int i = 0; i < 10; i++)
    D[i] = int(pieces[i]);
  int t_ms = int(pieces[idx_time].trim());
  
  if (t_ms > t0 + t_width_ms)
    start_plot();
  
  if (t0 < 0)
    t0 = t_ms;
  
  int tpix = (t_ms - t0) * width / t_width_ms;
  boolean prev_stored = (prev_t >= 0);
  if (!prev_stored) {
     prev_t = tpix;
     for (int i = 0; i < 10; i++)
        prev_D[i] = D[i];
  }       
  
  stroke(0,0,0);
  for (int i = 0; i < 5; i++)
  {    
    line(prev_t, height - prev_D[i] - S *i , tpix, height - D[i] - S*i);
    prev_D[i] = D[i];
  }    
  
  stroke(255,0,0);
  for (int i = 5; i < 10; i++)
  {    
    line(prev_t, height - prev_D[i] - S*(i - 5), tpix, height - D[i] - S*(i - 5));
    prev_D[i] = D[i];
  }    
  prev_t = tpix;    

}

