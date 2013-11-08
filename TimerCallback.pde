interface TimerCallback
{
  void start();
  void start(boolean isWaiting);
  void stop();
  void pause();
  void resume();
  void run();
  boolean isRunning();
  void execute();
}

abstract class BaseTimerCallback implements TimerCallback
{
  private int prev;
  private int saveInterval;
  private int interval;
  private boolean repeatable;
  private boolean isRunning = false;
  private int count = 0;
  
  BaseTimerCallback(int interval, boolean repeatable) {
    this.interval = interval;
    this.repeatable = repeatable;
  }
  
  void start() {
    start(true);
  }
  
  void start(boolean isWaiting) {
    if (!isRunning) {
      
      if (!isWaiting) {
//        println("execute");
        execute();
      }
      
      int milli = millis();
      prev = milli;
//      println("start(" + (interval - (milli - prev)) + ")");
      
      isRunning = true;
      
    } else {
//      println("already run");
    }
  }
  
  void stop() {
    if (isRunning) {
//      println("stop");
      
      saveInterval = 0;
      isRunning = false;
    } else {
//      println("already stop");
    }
  }
  
  void pause() {
    if (isRunning) {
      int milli = millis();
      saveInterval = milli - prev;
//      println("pause(" + (interval - saveInterval) + ")");
      
      isRunning = false;
    } else {
//      println("already pause");
    }
  }
  
  void resume() {
    if (!isRunning) {
      int milli = millis();
      prev = milli - saveInterval;
//      println("resume(" + (interval - saveInterval) + ")");
      
      isRunning = true;
    } else {
//      println("already resume");
    }
  }
  
  void run() {
    if (isRunning) {
      if (repeatable) {
//        int mill = millis();
        if (millis() - prev >= interval) {
//          println("execute");
          execute();
          prev = millis();
        }
      } else {
        if (count == 0) {
//          println("execute");
          execute();
          count++;
        }
      }
    }
  }
  
  boolean isRunning() {
    return isRunning;
  }
  // execute must be defined by sub-classes
}
