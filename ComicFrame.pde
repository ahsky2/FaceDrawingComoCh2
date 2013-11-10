class ComicFrame {
  
  int marginTop; // = 16;
  int marginBottom; // = 6;
  int marginLeft; // = 2;
  int marginRight; // = 2;
  
  int spacing = 8;
  
  float defaultWidth;
  float defaultHeight;
  
  float widthVarying = 50;
  float heightVarying = 50;
  
  float[] randomWidths = new float[6];
  float[] randomHeights = new float[4];
  Frame[] frames = new Frame[12];
  
  float tempX, tempY, tempWidth, tempHeight;

  ComicFrame (int width, int height, int marginTop, int marginBottom, int marginLeft, int marginRight, int widthVarying, int heightVarying) {
    this.marginTop = marginTop;
    this.marginBottom = marginBottom;
    this.marginLeft = marginLeft;
    this.marginRight = marginRight;
    
    this.widthVarying = widthVarying;
    this.heightVarying = heightVarying;

    defaultWidth = (width - (marginRight + marginLeft + 5 * spacing)) / 4;
    defaultHeight = (height - (marginTop + marginBottom + 4 * spacing)) / 3;
    
    println(defaultWidth + "," + defaultHeight);
  }
  
  void setFrame() {
    for(int i = 0; i < randomWidths.length; i++) {
      randomWidths[i] = random(-widthVarying, widthVarying);
    }
    
    for(int i = 0; i < randomHeights.length; i++) {
      randomHeights[i] = random(-heightVarying, heightVarying);
    }
    
    // frame 0
    tempX = marginRight + spacing;
    tempY = marginTop + spacing;
    tempWidth = defaultWidth + randomWidths[0];
    tempHeight = defaultHeight + randomHeights[0];
    frames[0] = new Frame(tempX, tempY, tempWidth, tempHeight);
    
    // frame 1
    tempX = tempX + tempWidth + spacing;
    tempWidth = defaultWidth - randomWidths[0];
    frames[1] = new Frame(tempX, tempY, tempWidth, tempHeight);
    
    // frame 2
    tempX = marginRight + spacing;
    tempY = tempY + tempHeight + spacing;
    tempWidth = defaultWidth + randomWidths[1];
    tempHeight = defaultHeight - (randomHeights[0] + randomHeights[1]);
    frames[2] = new Frame(tempX, tempY, tempWidth, tempHeight);
    
    // frame 3
    tempX = tempX + tempWidth + spacing;
    tempWidth = defaultWidth - randomWidths[1];
    frames[3] = new Frame(tempX, tempY, tempWidth, tempHeight);
    
    // frame 4
    tempX = marginRight + spacing;
    tempY = tempY + tempHeight + spacing;
    tempWidth = defaultWidth + randomWidths[2];
    tempHeight = defaultHeight + randomHeights[1];
    frames[4] = new Frame(tempX, tempY, tempWidth, tempHeight);
    
    // frame 5
    tempX = tempX + tempWidth + spacing;
    tempWidth = defaultWidth - randomWidths[2];
    frames[5] = new Frame(tempX, tempY, tempWidth, tempHeight);
    
    // frame 6
    tempX = marginRight + 2 * defaultWidth + 3 * spacing;
    tempY = marginTop + spacing;
    tempWidth = defaultWidth + randomWidths[3];
    tempHeight = defaultHeight + randomHeights[2];
    frames[6] = new Frame(tempX, tempY, tempWidth, tempHeight);
    
    // frame 7
    tempX = tempX + tempWidth + spacing;
    tempWidth = defaultWidth - randomWidths[3];
    frames[7] = new Frame(tempX, tempY, tempWidth, tempHeight);
    
    // frame 8
    tempX = marginRight + 2 * defaultWidth + 3 * spacing;
    tempY = tempY + tempHeight + spacing;
    tempWidth = defaultWidth + randomWidths[4];
    tempHeight = defaultHeight - (randomHeights[2] + randomHeights[3]);
    frames[8] = new Frame(tempX, tempY, tempWidth, tempHeight);
    
    // frame 9
    tempX = tempX + tempWidth + spacing;
    tempWidth = defaultWidth - randomWidths[4];
    frames[9] = new Frame(tempX, tempY, tempWidth, tempHeight);
    
    // frame 10
    tempX = marginRight + 2 * defaultWidth + 3 * spacing;
    tempY = tempY + tempHeight + spacing;
    tempWidth = defaultWidth + randomWidths[5];
    tempHeight = defaultHeight + randomHeights[3];
    frames[10] = new Frame(tempX, tempY, tempWidth, tempHeight);
    
    // frame 11
    tempX = tempX + tempWidth + spacing;
    tempWidth = defaultWidth - randomWidths[5];
    frames[11] = new Frame(tempX, tempY, tempWidth, tempHeight);
  }
  
  Frame[] getFrame() {
    setFrame();
    return frames;
  }
}
