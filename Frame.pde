class Frame {

  float x;
  float y;
  float width;
  float height;
  
  private float srcX, srcY, srcWidth, srcHeight;
  private float trgX, trgY, trgWidth, trgHeight;
//  private float stepX, stepY, stepWidth, stepHeight;
  
  private int index = 0;
  private NonLinearFunc func;
  
//  private float duration;
  
  private boolean isChanging = false;
  
  Frame(float x, float y, float width, float height) {
    trgX = srcX = this.x = x;
    trgY = srcY = this.y = y;
    trgWidth = srcWidth = this.width = width;
    trgHeight = srcHeight = this.height = height;
  }
  
//  void setDuration(float duration) {
//    this.duration = duration;
//  }
  
  void setTransFunc(NonLinearFunc func) {
    this.func = func;
  }
  
  void reset(float x, float y, float width, float height) {
    if (!isChanging) {
      isChanging = true;
      
      trgX = x;
      trgY = y;
      trgWidth = width;
      trgHeight = height;
      
      srcX = this.x;
      srcY = this.y;
      srcWidth = this.width;
      srcHeight = this.height;
      
//    stepX = (trgX - srcX) / duration;
//    stepY = (trgY - srcY) / duration;
//    stepWidth = (trgWidth - srcWidth) / duration;
//    stepHeight = (trgHeight - srcHeight) / duration;

    }
  }
  
  void update() {
    if (isChanging) {
      x = map(func.getValue(index), func.getValue(0), func.getValue(func.count), srcX, trgX);
      y = map(func.getValue(index), func.getValue(0), func.getValue(func.count), srcY, trgY);
      width = map(func.getValue(index), func.getValue(0), func.getValue(func.count), srcWidth, trgWidth);
      height = map(func.getValue(index), func.getValue(0), func.getValue(func.count), srcHeight, trgHeight);
      
//    if(abs(trgX - x) > abs(stepX)) {
//      x = x + stepX;
//    } else {
//      x = trgX;
//      srcX = x;
//    }
//    
//    if(abs(trgY - y) > abs(stepY)) {
//      y = y + stepY;
//    } else {
//      y = trgY;
//      srcY = y;
//    }
//    
//    if(abs(trgWidth - width) > abs(stepWidth)) {
//      width = width + stepWidth;
//    } else {
//      width = trgWidth;
//      srcWidth = width;
//    }
//    
//    if(abs(trgHeight - height) > abs(stepHeight)) {
//      height = height + stepHeight;
//    } else {
//      height = trgHeight;
//      srcHeight = height;
//    }
    
      index++;
      if (index > func.count - 1) {
        isChanging = false;
        index = 0;
      }
    }
  }
  
  void display() {
    stroke(0);
    strokeWeight(3);
    rect(x, y, width, height);
  }
}
