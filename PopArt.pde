
class PopArt {
  float x;
  float y;
  float width;
  float height;
  int imgCount = 2;
  PImage[] imgs = new PImage[imgCount]; // [front image, back image]
  int imgIndex = 0; // 0 : front image
  int imgAddIndex = 0;
  boolean isChanging = false;

//  int fadeInDelayIndex = 0;
//  int fadeInDelay = 0;

//  float interval = 2.0;
  NonLinearFunc func;

  int index = 0;
//  int fadeInIndex = 0;
//  int fadeInCount;
  float fadeInAlpha = 0.0;
//  int fadeOutIndex = 0;
//  int fadeOutCount;
  float fadeOutAlpha = 0.0;
  
  
  private float srcX, srcY, srcWidth, srcHeight;
  private float trgX, trgY, trgWidth, trgHeight;
  
  PopArt(float x, float y, float width, float height) {
    trgX = srcX = this.x = x;
    trgY = srcY = this.y = y;
    trgWidth = srcWidth = this.width = width;
    trgHeight = srcHeight = this.height = height;
  }
  
  void resetFrame(float x, float y, float width, float height) {
    // empty frame
    trgX = x;
    trgY = y;
    trgWidth = width;
    trgHeight = height;
    
    srcX = this.x;
    srcY = this.y;
    srcWidth = this.width;
    srcHeight = this.height;
  }
  
  void setTransFunc(NonLinearFunc func) {
//      this.fadeInDelay = fadeInDelay;
      this.func = func;
//      fadeInCount = fadeOutCount = func.count;
  }

  void addImage(PImage img) {
    
    imgs[imgAddIndex] = createImage((int)trgWidth, (int)trgHeight, ARGB);
    
    if(trgWidth / trgHeight > float(img.width) / float(img.height)) {
      float calHeight = img.width * (trgHeight / trgWidth);
      float marginHeight = (img.height - calHeight) / 2.0;
      imgs[imgAddIndex].copy(img, 0, int(marginHeight), img.width, int(calHeight), 0, 0, (int)trgWidth, (int)trgHeight);
      
//      println(float(img.width) / float(img.height) + ", " + (img.width / calHeight) + "," + (trgWidth / trgHeight));
      
    } else if(trgWidth / trgHeight < float(img.width) / float(img.height)) {
      float calWidth = img.height * (trgWidth / trgHeight);
      float marginWidth = (img.width - calWidth) / 2.0;
      imgs[imgAddIndex].copy(img, int(marginWidth), 0, int(calWidth), img.height, 0, 0, (int)trgWidth, (int)trgHeight);
      
//      println(float(img.width) / float(img.height) + ", " + (calWidth / img.height) + "," + (trgWidth / trgHeight));
      
    } else {
      imgs[imgAddIndex].copy(img, 0, 0, img.width, img.height, 0, 0, (int)trgWidth, (int)trgHeight);
    }
    imgAddIndex = (imgAddIndex + 1) % imgCount;
  }

  void update() {
    if (isChanging) {
      x = map(func.getValue(index), func.getValue(0), func.getValue(func.count), srcX, trgX);
      y = map(func.getValue(index), func.getValue(0), func.getValue(func.count), srcY, trgY);
      width = map(func.getValue(index), func.getValue(0), func.getValue(func.count), srcWidth, trgWidth);
      height = map(func.getValue(index), func.getValue(0), func.getValue(func.count), srcHeight, trgHeight);
      
      fadeOutAlpha = func.getValue(func.count - index - 1);
      fadeInAlpha = func.getValue(index);
      
//      if (fadeOutIndex < fadeOutCount) {        
//        fadeOutAlpha = fadeOut(fadeOutIndex, func);
//        fadeOutIndex++;
//      } 
//      else {
//        fadeOutAlpha = 0.0;
//      }
//
//      if (fadeInDelayIndex < fadeInDelay) {
//        fadeInAlpha = 0.0;
//        fadeInDelayIndex++;
//      } 
//      else {
//        if (fadeInIndex < fadeInCount) {
//          fadeInAlpha = fadeIn(fadeInIndex, func);
//          fadeInIndex++;
//        } 
//        else {
//          fadeInIndex = 0;
//
//          fadeOutIndex = 0;
//          fadeInDelayIndex = 0;
//
//          isChanging = false; // change status to show
//          
//          imgIndex = (imgIndex + 1) % imgCount;
//        }
//      }
      
      index++;
      if (index > func.count - 1) {
        isChanging = false;
        index = 0;
        imgIndex = (imgIndex + 1) % imgCount;
      }
    }
  }

  void display() {

    fill(255);
    stroke(0);
    strokeWeight(2);
    rect(x, y, width, height);

    if (isChanging) {
//      println("changing");
      tint(255, fadeOutAlpha); // alpha value
//      image(imgs[imgIndex], x, y);
      image(imgs[imgIndex].get(0, 0, (int)width, (int)height), x, y);
//      textureMode(IMAGE);
//      beginShape();
//      texture(imgs[imgIndex]);
//      vertex(x, y, 0, 0);
//      vertex(x + width, y, width, 0);
//      vertex(x + width, y + height, width, height);
//      vertex(x, y + height, 0, height);
//      endShape();

      tint(255, fadeInAlpha);
//      image(imgs[(imgIndex + 1) % imgCount], x, y);
      image(imgs[(imgIndex + 1) % imgCount].get(0, 0, (int)width, (int)height), x, y);
    } 
    else {
      //noTint();
      image(imgs[imgIndex], x, y);
      
    }
  }

  void transition() {
    if (!isChanging) {
      isChanging = true;
    }
  }

  float fadeOut(int index, NonLinearFunc func) {
    return func.getValue(func.count - index - 1);
  }

  float fadeIn(int index, NonLinearFunc func) {
    return func.getValue(index);
  }
}
