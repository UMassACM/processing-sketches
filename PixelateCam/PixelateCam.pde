import processing.video.*;

final int MIN_PIXSIZE = 4;

Capture cap;

int pixSize = 4;
int pixW, pixH, numPixW, numPixH;

color[][] pix;

boolean sizeChanged = false;

void setup()
{
  // set up window and drawing mode
  size(640, 480, P2D);
  background(0);
  noStroke();

  // initialize video capture
  cap = new Capture(this, width, height, 30);

  // set pixel grid dimensions and create pixel arrays
  pixW = width / pixSize;
  pixH = height / pixSize;
  numPixW = width / MIN_PIXSIZE;
  numPixH = height / MIN_PIXSIZE;
  pix = new color[numPixW][numPixH];
}

void captureEvent(Capture cap) {
  // capture raw pixel info from camera
  cap.read();
  cap.loadPixels();

  // update pixel size (based on mouse position)
  updatePixSize();

  // downsample captured video by desired pixel size
  // note: could do an average instead, or anything more advanced
  // than picking a single pixel from a grid
  for (int i = 0; i < pixW; i++) {
    for (int j = 0; j < pixH; j++) {
      pix[i][j] = cap.pixels[i*pixSize + j*width*pixSize];
    }
  }
}

void draw() {
  // clear previous pixel grid when size changes
  if (sizeChanged) {
    background(0);
    sizeChanged = false;
  }

  // draw pixels according to size, leaving a 1-pixel gutter on all sides
  for (int i = 0; i < pixW; i++) {
    for (int j = 0; j < pixH; j++) {
      fill(pix[i][j]);
      int px = i*pixSize;
      int py = j*pixSize;
      rect(px+1, py+1, pixSize-2, pixSize-2);
    }
  }
}

void updatePixSize() {
  // update size according to mouse position: right -> bigger pixels
  int newSize = ((mouseX / 32) + 1) * 4;
  if (pixSize != newSize) {
    // only update on actual size change
    pixSize = newSize;
    pixW = width / pixSize;
    pixH = height / pixSize;
    // black out pixel grid (for accurate difference images)
    for (int i = 0; i < numPixW; i++) {
      for (int j = 0; j < numPixH; j++) {
        pix[i][j] = 0;
      }
    }
    // set flag for background blackout to clear old pixels
    sizeChanged = true;
  }
}
