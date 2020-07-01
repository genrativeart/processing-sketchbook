// give necessary permissions for runtime in android
// choose necessary permissions from sketch -> permissions

import ketai.sensors.*;


KetaiAudioInput mic;
short[] data;

void setup()
{
  fullScreen();
  orientation(LANDSCAPE);
  mic = new KetaiAudioInput(this);
  fill(255,0,0);
  textSize(displayDensity * 24);
  fill(255, 0, 0);
  textSize(48);
  requestPermission("android.permission.RECORD_AUDIO", "initAudio");
}

void initAudio(boolean granted)
{
  if (granted)
  {
    mic = new KetaiAudioInput(this);
    println("Audio recording permission granted");
  } else {
    println("Audio recording permission denied");
  }
}


void draw()
{
  background(128);
  if (data != null)
  {  
    for (int i = 0; i < data.length; i++)
    {
      if (i != data.length-1)
        line(i, map(data[i], -32768, 32767, height, 0), i+1, map(data[i+1], -32768, 32767, height, 0));
    }
  }

  if (mic != null && mic.isActive())
    text("READING MIC", width/2, height/2);
  else
    text("NOT READING MIC", width/2, height/2);
}


void onAudioEvent(short[] _data)
{
  data= _data;
}

void mousePressed()
{
  if (mic != null && mic.isActive())
    mic.stop(); 
  else
    mic.start();
}
