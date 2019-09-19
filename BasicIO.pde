
import ddf.minim.*;
import ddf.minim.ugens.*;

import ddf.minim.analysis.*;
import processing.sound.*;
Sound s;
import beads.*;
import controlP5.*;

Minim minim;
InputOutputBind signal;
AudioInput in;


SamplePlayer sp;
ControlP5 p5;

AudioOutput out;


void setup()
{
  size(512, 400, P2D);
  minim = new Minim(this);
  int buffer = 1024;
  out = minim.getLineOut(Minim.STEREO, buffer);

    in = minim.getLineIn();

  signal = new InputOutputBind(1024);
  //add listener to gather incoming data
  in.addListener(signal);
  // adds the signal to the output
  out.addSignal(signal);
  
  
  p5 = new ControlP5(this);

}
void draw() {
 
 
  fill(0);
  rect(0, 0, width, 200);
  stroke(255);
  // draw the waveforms in
  for (int i = 0; i < in.bufferSize() - 1; i++)
  {
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
  // out
  fill(0, 200, 200);
  rect(0, 200, width, 400);
  for (int i = 0; i < out.bufferSize() - 1; i++)
  {
    line(i, 250 + out.left.get(i)*50, i+1, 250 + out.left.get(i+1)*50);
    line(i, 350 + out.right.get(i)*50, i+1, 350 + out.right.get(i+1)*50);
  }
}
class InputOutputBind implements AudioSignal, AudioListener
{
  private float[] leftChannel ;
  private float[] rightChannel;
  InputOutputBind(int sample)
  {
    leftChannel = new float[sample];
    rightChannel= new float[sample];
  }
  // This part is implementing AudioSignal interface, see Minim reference
  void generate(float[] samp)
  {
    arraycopy(leftChannel, samp);
  }
  void generate(float[] left, float[] right)
  {
    arraycopy(leftChannel, left);
    arraycopy(rightChannel, right);
  }
  // This part is implementing AudioListener interface, see Minim reference
  synchronized void samples(float[] samp)
  {
    arraycopy(samp, leftChannel);
  }
  synchronized void samples(float[] sampL, float[] sampR)
  {
    arraycopy(sampL, leftChannel);
    arraycopy(sampR, rightChannel);
  }
}
