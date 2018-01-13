//no. of lisa's max voices --TBC
30 => int MAXVOICES;
30::second => dur DURATION;
//no. of channels   ( 6 for performence and 2 for normal computers or earphones )
2 => int CHANNELS;

// offset
0 => int CHAN_OFFSET;

//DEADZONE
0.0005 => float DEADZONE;

// global
36 => float PITCH_OFFSET; 

// which joystick
0 => int device;

// duration
1000::ms => dur T;

// define a flag no.
0 => int flag;




//load drum sample into buffer
SndBuf sndbuf;
me.dir() + "/bigdrum_02.aiff" => sndbuf.read; 
sndbuf => NRev DrumRev => Gain drumGain=>dac;
.1 => DrumRev.mix;
.5 => drumGain.gain;
sndbuf.samples() => int numSamples; 
numSamples => sndbuf.pos;

//load thunder and rain sounds
SndBuf heavyThunder => dac;
SndBuf sharpThunder => dac;
SndBuf rain => dac;

me.dir()  + "/HeavyThunder.wav" => heavyThunder.read; 
heavyThunder.samples() => int numSamples2; 
numSamples2 => heavyThunder.pos; // sets playhead position

me.dir()  + "/SharpThunder.wav" => sharpThunder.read; 
sharpThunder.samples() => int numSamples3; 
numSamples3 => sharpThunder.pos; // sets playhead position

me.dir()  + "/Rain.wav" => rain.read; 
rain.samples() => int numSamples4; 
numSamples4 => rain.pos; // sets playhead position




// get from command line
if( me.args() ) me.arg(0) => Std.atoi => device;

// HID objects
Hid trak;
HidMsg msg;


// noise generator, biquad filter, dac (audio output) 
Noise noise => BiQuad f =>NRev WindRev=>Gain nGain=> dac;//=>dac
// set biquad pole radius
.99 => f.prad;
// set biquad gain
.001 => f.gain;
// set equal zeros 
1 => f.eqzs;
//reverb for wind
.4=>WindRev.mix;


// open joystick 0, exit on fail
if( !trak.openJoystick( device ) ) me.exit();
//print
<<< "joystick '" + trak.name() + "' ready", "" >>>;

// data structure for gametrak
class GameTrak
{
    // timestamps
    time lastTime;
    time currTime;
    
    // previous axis data
    float lastAxis[6];
    // current axis data
    float axis[6];
    // is the button down? 1 for down, 0 for up
    int buttonDown;

}

// gametrack
GameTrak gt;


// synthesis
ModalBar fish[CHANNELS];
NRev rev[CHANNELS];

// loop
for( int i; i < CHANNELS; i++ )
{
    fish[i] => rev[i] => dac.chan(i+CHAN_OFFSET);
    1.0 => rev[i].gain;
    .1 => rev[i].mix;
}

//Noise noise => BiQuad bq =>Gain g => dac;
//.5=> g.gain;



// counter
int n;

// spork control
spork ~ gametrak();
// print
spork ~ print();
//spork wind sound
spork ~ wind();
//spork the drum sound
spork ~ drum();
//spork the function of alternating scales
spork ~ changeScale();

//Pentatonic Scale
[0, 2, 4, 7, 9, 12, 14, 16,  19, 21, 24, 26, 28, 31, 33, 36, 38, 40, 43, 45, 48] @=>int scale[];//4 octaves with 21 diff notes in Pentatonic scale.


//Blues Scale - not appropriate
//<<<"blues scale">>>;
//[0, 2,4,5,6,9,11, 14, 16, 17, 18, 21, 23, 26,28,29,30,33,35,38] @=>int scale[];



// main loop
while( true )
{

    //set pitch and map the axis position to the pentatonic tones.. (R-Y)
    Math.round((gt.axis[4]+1)*10)$int * 20/20 => int note; 
    scale[note] + PITCH_OFFSET => float pitch;
    <<<note>>>;
    
    // set freq.
    pitch => Std.mtof => fish[n].freq;
    
    //define the speed
    Math.fabs(gt.axis[4]-gt.lastAxis[4]) * 800  => float speed; 

    // gain (R-Z) 
    if (gt.axis[5] <= 0.40 ){ 0 => gt.axis[5];}
    else {1.0 => fish[n].noteOn; }
    
    // reverb mix (R-X) 
    for( int i; i < CHANNELS; i++ ){
        gt.axis[3]/2 +0.1 => rev[i].mix;
    }
    
    // stick hardness (L-X)
    Math.fabs(gt.axis[1]) => fish[n].stickHardness;
    
    // strike position(L-Y)
    //Math.fabs(gt.axis[1]) => fish[n].strikePosition;
    
    // Loudness (L-Z)
    
    
    // Pitch (R-Y)
    if ( speed >= 5.0 ) {5.0 => speed;} 
    T - Math.log2(speed/5+1)*(T/ms-80)::ms => now;//the faster the swiping, the faster the sound goes
    <<< "speed: ", speed>>>;
    if ( gt.axis[0] >= 0.75 ) { 2000::ms => now; }//hold the left stick to right to keep the last sound alone(don't actually know how to express this…)
    n++;
    CHANNELS %=> n;
      
    //for reference: L: axis0-x, axis1-y, axis2-z
    //               R: axis3-x, axis4-y, axis5-z
}


fun void drum()
{
    while( true ){
        
      if( gt.axis[0] <=-0.4 )
      {
        0=>sndbuf.pos;
      } 
      .6::second => now;
    }
}


fun void wind()
{
    while( true ){
    // sweep the filter resonant frequency
    100.0 + Std.fabs(Math.sin(gt.axis[2])) * 10000.0 => f.pfreq;
    if (gt.axis[2] <= 0.40 ){ 0.0 => nGain.gain;}
    0.01 + gt.axis[2]*1.5 => nGain.gain;

    10::ms => now;
    }
}

// print
fun void print()
{
    // time loop
    while( true )
    {
        // values
        <<< "axes:", gt.axis[0],gt.axis[1],gt.axis[2], gt.axis[3],gt.axis[4],gt.axis[5] >>>;
        // advance time
        100::ms => now;
    }
}


// gametrack handling
fun void gametrak()
{
    while( true )
    {
        // wait on HidIn as event
        trak => now;
        
        // messages received
        while( trak.recv( msg ) )
        {
            // joystick axis motion
            if( msg.isAxisMotion() )
            {            
                // check which
                if( msg.which >= 0 && msg.which < 6 )
                {
                    // check if fresh
                    if( now > gt.currTime )
                    {
                        // time stamp
                        gt.currTime => gt.lastTime;
                        // set
                        now => gt.currTime;
                    }
                    // save last
                    gt.axis[msg.which] => gt.lastAxis[msg.which];
                    // the z axes map to [0,1], others map to [-1,1]
                    if( msg.which != 2 && msg.which != 5 )
                    { msg.axisPosition => gt.axis[msg.which]; }
                    else
                    {
                        1 - ((msg.axisPosition + 1) / 2) - DEADZONE => gt.axis[msg.which];
                        if( gt.axis[msg.which] < 0 ) 0 => gt.axis[msg.which];
                    }
                }
            }
            
            // joystick button down
            else if( msg.isButtonDown() )//
            {
                <<< "button", msg.which, "down" >>>;

                flag++;
                if (flag >= 3){ 0 => flag; }
                <<<"Flag:", flag>>>;
                //spork the rain&thunder sounds when button down
                spork ~ rainNthunder();
            }
            
            // joystick button up
            else if( msg.isButtonUp() )//
            {
                <<< "button", msg.which, "up" >>>;
            }
        }
    }
}

fun void changeScale()
{
    while( true )
    {
        if (flag == 0)
        {
            //Pentatonic Scale
            [0, 2, 4, 7, 9, 12, 14, 16,  19, 21, 24, 26, 28, 31, 33, 36, 38, 40, 43, 45, 48] @=> scale;//4 octaves with 21 diff notes in Pentatonic scale.
            <<<"Pentatonic">>>;

        }
        
        if (flag == 1)
        {   

            <<<"Minor">>>;
            //Pentatonic Scale in minor
            [0, 2, 3, 7, 9, 12, 14, 15,  19, 21, 24, 26, 27, 31, 33, 36, 38, 39, 43, 45, 48] @=>scale;//
        }
        
        if (flag == 2)
        {   <<<"whole-tone">>>;
           //whole-tone scale
            [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40] @=> scale;//
        }
        
    500::ms => now;
    }
}

fun void rainNthunder()
{
        if( flag == 0 )//some criteria
        {
            
            0 => rain.pos;
        }
        if( flag == 1 )//some criteria
        {
            
            0 => sharpThunder.pos;
        }
        if( flag == 2 )//some criteria
        {
            
            0 => heavyThunder.pos;
        }
        
        10::second=>now;
}

