import java.util.*;

int windowWidth = 720;
int windowHeight = 480;

int imgCount = 87;
int imgIndex = 1;
PImage imgs[] = new PImage[imgCount];
NonLinearFunc func;
int transitionCount;

int popArtCount;
Vector popArtVector;

ComicFrame comicFrame;
Frame[] frames;

TimerCallback callback = new BaseTimerCallback(1000*8, true) {
  void execute() {
    frames = comicFrame.getFrame();

    Iterator iter = popArtVector.iterator();
    int i = 0;
    while (iter.hasNext()) {
      PopArt popArt = (PopArt)iter.next();
      popArt.resetFrame(frames[i].x, frames[i].y, frames[i].width, frames[i].height);
      int index = round(random(0, imgCount-1));
      popArt.addImage(imgs[index]);
      popArt.transition();
      
      i++;
    }
  }
};

boolean isSave = false;
int saveIndex = 0;
int saveCount = 5000;

void setup() {
  frameRate(30);
  size(windowWidth, windowHeight, P2D);
//  smooth();
  
  for(int i = 0; i < imgCount; i++) {
    imgs[i] = loadImage("PFD_720x480_" + (i + imgIndex + 100 + "").substring(1) + ".jpg");
    if (imgs[i] == null)  {
      exit();
    }
//    imgs[i].resize(80, 80);
  }
  
  func = new NonLinearFunc(0.0, 0.0, 255.0, 255.0, 0.15);
  transitionCount = func.make(2.0); // alpha value
  
  comicFrame = new ComicFrame(width, height, 16, 6, 2, 2, 50, 50);
  frames = comicFrame.getFrame();

  popArtCount = frames.length;
  popArtVector = new Vector();
  
  for(int i = 0; i < popArtCount; i++) {
//    Frame f = new Frame(frames[i].x, frames[i].y, frames[i].width, frames[i].height);
//    f.setTransFunc(func);
  
    PopArt popArt = new PopArt(frames[i].x, frames[i].y, frames[i].width, frames[i].height);
    popArt.setTransFunc(func);
    int index = round(random(0, imgCount-1));
    popArt.addImage(imgs[index]);
  //  popArt.addImage(imgs[(index + 1) % imgCount]);
    popArtVector.add(popArt);
  }
  
  callback.start();
}

void draw() {
  background(255);
  
  Iterator iter = popArtVector.iterator();
  int i = 0;
  while (iter.hasNext()) {
    PopArt popArt = (PopArt)iter.next();
    popArt.update();
    popArt.display();
    
    i++;
  }
  callback.run();
  
  if (isSave) {
    if (saveIndex < saveCount / 2 + 1) {
      saveFrame("frames/" +  String.valueOf(10000 + saveIndex).substring(1));
      saveFrame("frames/" +  String.valueOf(10000 + saveCount - saveIndex).substring(1));
      saveIndex++;
    }
  }
}

void mouseClicked() {
//  isSave = true;
}

//boolean isToggle = false;
//
//void mousePressed() {
//  if (callback.isRunning()) {
//    callback.pause();
//  } else {
//    callback.resume();
//  }
////  f.reset(random(100), random(100), random(50, 150), random(50, 150));
//}
//
//void keyPressed() {
//  if (callback.isRunning()) {
//    callback.stop();
//  } else {
//    callback.start(false);
//  }
//}
