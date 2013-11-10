import java.util.*;

// Como CH2
int windowWidth = 720;
int windowHeight = 480;
int marginTop = 16;
int marginBottom = 6;
int marginLeft = 2;
int marginRight = 2;
int spacing = 8;
int frameWidthVarying = 85;
int frameHeightVarying = 70;

//// Happy Squre
//int windowWidth = 1280;
//int windowHeight = 720;
//int marginTop = 0;
//int marginBottom = 0;
//int marginLeft = 0;
//int marginRight = 0;
//int spacing = 12;
//int frameWidthVarying = 150;
//int frameHeightVarying = 100;

boolean isRecording = false; // for video
int transitionIndex = 0;
int transitionCount = 3; // # of transition

int imgCount = 87;
int imgIndex = 1;
PImage imgs[] = new PImage[imgCount];
NonLinearFunc func;
int funcCount;

int popArtCount;
Vector popArtVector;

ComicFrame comicFrame;
Frame[] frames;

Frame[] savedFrames;
int[] savedFrameIndexes;
int[] savedIndexes;

boolean isFull = false;

TimerCallback callback = new BaseTimerCallback(1000*30, true) {
  void execute() {
    if(isRecording) {
      if (transitionIndex < transitionCount) {
        
        println(transitionIndex + "," + transitionCount);
        frames = comicFrame.getFrame();
    
        Iterator iter = popArtVector.iterator();
        int i = 0;
        while (iter.hasNext()) {
          PopArt popArt = (PopArt)iter.next();
          
          int index;
          int frameIndex;
          if (transitionIndex == transitionCount - 1) {
            index = savedIndexes[i];
            popArt.resetFrame(savedFrames[i].x, savedFrames[i].y, savedFrames[i].width, savedFrames[i].height);
          } else {
            boolean isSame = true;
            while(isSame) {
              frameIndex = floor(random(0, frames.length-0.01));
              
              isSame = false;
              for(int j = 0; j < i; j++) {
                if(savedFrameIndexes[j] == frameIndex) {
                  isSame = true;
                  break;
                }
              }
              if (!isSame) {
                savedFrameIndexes[i] = frameIndex;
                break;
              }
            }
            
            Frame tempFrame = frames[savedFrameIndexes[i]];
        
            if (i == popArtCount - 1) {
              if ((transitionIndex % 3) == 1) {
//              if (!isFull) {
//                if (floor(random(3 - 0.01)) == 0) {
//                  isFull = true;
                  tempFrame.x = comicFrame.marginLeft + comicFrame.spacing;
                  tempFrame.y = comicFrame.marginTop + comicFrame.spacing;
                  tempFrame.width = windowWidth - (comicFrame.marginLeft + comicFrame.marginRight + 2 * comicFrame.spacing);
                  tempFrame.height = windowHeight - (comicFrame.marginTop + comicFrame.marginBottom + 2 * comicFrame.spacing);
//                }
//              } else {
//                isFull = false;
              }
            }
            popArt.resetFrame(tempFrame.x, tempFrame.y, tempFrame.width, tempFrame.height);

    //      int index = round(random(0, imgCount-1));
            index = (popArt.getImgIndex() + 1) % imgCount;
          }
          popArt.addImage(imgs[index], index);
          popArt.transition();
          
          i++;
        }
        
        transitionIndex++;
      } else {
        this.stop();
      }
    } else {
      frames = comicFrame.getFrame();
  
      Iterator iter = popArtVector.iterator();
      int i = 0;
      while (iter.hasNext()) {
        PopArt popArt = (PopArt)iter.next();
        boolean isSame = true;
        while(isSame) {
          int index = round(random(0, frames.length-1));
          
          isSame = false;
          for(int j = 0; j < i; j++) {
            if(savedFrameIndexes[j] == index) {
              isSame = true;
              break;
            }
          }
          if (!isSame) {
            savedFrameIndexes[i] = index;
            break;
          }
        }
        
        Frame tempFrame = frames[savedFrameIndexes[i]];
        
        if (i == popArtCount - 1) {
          if (!isFull) {
            if (floor(random(3 - 0.01)) == 0) {
              isFull = true;
              tempFrame.x = comicFrame.marginLeft + comicFrame.spacing;
              tempFrame.y = comicFrame.marginTop + comicFrame.spacing;
              tempFrame.width = windowWidth - (comicFrame.marginLeft + comicFrame.marginRight + 2 * comicFrame.spacing);
              tempFrame.height = windowHeight - (comicFrame.marginTop + comicFrame.marginBottom + 2 * comicFrame.spacing);
            }
          } else {
            isFull = false;
          }
        }
        popArt.resetFrame(tempFrame.x, tempFrame.y, tempFrame.width, tempFrame.height);

//        int index = round(random(0, imgCount-1));
        int index = (popArt.getImgIndex() + 1) % imgCount;
        popArt.addImage(imgs[index], index);
        popArt.transition();
        
        i++;
      }
    }
  }
};

boolean isSave = false;
int saveIndex = 0;
int saveCount = 5000;

boolean sketchFullScreen() {
  if(isRecording) {
    return false;
  }
  
  return true;
}

void setup() {
  frameRate(30);
  if(isRecording) {
    size(windowWidth, windowHeight, P2D);
  } else {
    size(displayWidth, displayHeight, P2D);
  }
  smooth();
  
  for(int i = 0; i < imgCount; i++) {
    imgs[i] = loadImage("PFD_" + windowWidth + "x"+ windowHeight + "_" + (i + imgIndex + 100 + "").substring(1) + ".jpg");
    if (imgs[i] == null)  {
      exit();
    }
  }
  
  func = new NonLinearFunc(0.0, 0.0, 255.0, 255.0, 1.0);
  funcCount = func.make(0.5); // alpha value
  
  comicFrame = new ComicFrame(windowWidth, windowHeight, marginTop, marginBottom, marginLeft, marginRight, frameWidthVarying, frameHeightVarying);
  frames = comicFrame.getFrame();
  
  savedFrames = new Frame[frames.length];
  savedFrameIndexes = new int[frames.length];
  for (int i = 0; i < savedFrameIndexes.length; i++) {
    savedFrameIndexes[i] = i;
    savedFrames[i] = new Frame(frames[i].x, frames[i].y, frames[i].width, frames[i].height);
  }

  popArtCount = frames.length;
  popArtVector = new Vector();
  
  savedIndexes = new int[popArtCount];
  
  for(int i = 0; i < popArtCount; i++) {
//    Frame f = new Frame(frames[i].x, frames[i].y, frames[i].width, frames[i].height);
//    f.setTransFunc(func);
  
    PopArt popArt = new PopArt(frames[i].x, frames[i].y, frames[i].width, frames[i].height);
    popArt.setTransFunc(func);
    
//    int index = round(random(0, imgCount-1));
    boolean isSame = true;
    while(isSame) {
      int index = round(random(0, imgCount-1));
      
      isSame = false;
      for(int j = 0; j < i; j++) {
        if(savedIndexes[j] == index) {
          isSame = true;
          break;
        }
      }
      if (!isSame) {
        savedIndexes[i] = index;
        break;
      }
    }
    
    popArt.addImage(imgs[savedIndexes[i]], savedIndexes[i]);
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
  
  if (isRecording) {
    if (isSave) {
      saveFrame("frames/" +  String.valueOf(10000 + saveIndex).substring(1));
      saveIndex++;
    }
  }
}

void keyPressed() {
  if (isRecording) {
    if (key == 's' || key == 'S') {
      if (isSave) {
        isSave = false;
        println("Save End");
      } else {
        isSave = true;
        println("Save Start");
      }
    }
  }
}
