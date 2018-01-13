TriOsc s =>PitShift p=>ADSR env=>LPF filter=>JCRev rev =>Echo echo =>dac;
//TriOsc - like a bell far away, SawOsc - more like an ancient or classical piano,PulseOsc - a brighter bell

//a few notes from The Beatles
[67.0, 72.0,79.0, 
70.0, 79.0, 72.0, 
69.0, 72.0, 79.0,
68.0] @=>float note1[];
[77.0, 76.0, 72.0]@=>float note2[];


//parameters
0.2=>p.mix; //the higher the more chao
0.4=>rev.mix; //somehow related to the loudness and the spatial effect
0.3::second=>echo.delay;
0.2=>echo.mix; //change the degree of wet or dry
20000=>filter.freq; //to reject or stop some very sharp noise (not necessarily needed in this case)
50::ms => env.attackTime;//determine the timbre in some way…
50::ms => env.decayTime;
0.4 => env.sustainLevel;//sustain for a while
500::ms => env.releaseTime;//release slowly

for (0 =>int i; i<note1.size(); i++){
    play(note1[i]);
    0.24::second=>now;
}
for (0 =>int i; i<note2.size(); i++){
    play(note2[i]);
    0::second=>now;
}


//the play function
fun void play(float note)
{
    Std.mtof( note ) => s.freq;//MIDI note to Freq.
    Std.rand2f(0.95,1.05)=>p.shift;//purer when the range becomes more narrow

      1 => env.keyOn;
    0.24::second => now;
        
    1 => env.keyOff;
    0.01::second => now;

}

0.48::second => now;
    
//Summary: this sound sounds like a broken bell(because of pitch shift) rings in some kinds of space.
//Question: how to avoid the high freq noises more effectively?
