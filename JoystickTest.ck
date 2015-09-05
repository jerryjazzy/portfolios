//no. of channels
2 => int CHANNELS;

// offset
0 => int CHAN_OFFSET;

//DEADZONE
0.0 => float DEADZONE;

// global
36 => float PITCH_OFFSET; 

// which joystick
0 => int device;

// duration
1000::ms => dur T;

// get from command line
if( me.args() ) me.arg(0) => Std.atoi => device;

// HID objects
Hid trak;
HidMsg msg;

// noise generator, biquad filter, dac (audio output) 
Noise noise => BiQuad f => dac;
// set biquad pole radius
.99 => f.prad;
// set biquad gain
.05 => f.gain;
// set equal zeros 
1 => f.eqzs;


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
    .8 => rev[i].gain;
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


   //Pentatonic Scale
   [0, 2, 4, 7, 9, 12, 14, 16,  19, 21, 24, 26, 28, 31, 33, 36, 38, 40, 43, 45, 48] @=>int scale[];//4 octaves with 21 diff notes in Pentatonic scale.


if( msg.isButtonDown() ){//NOT WORK!
    //Blues Scale - not appropriate
    <<<"blues scale">>>;
    [0, 2,4,5,6,9,11, 14, 16, 17, 18, 21, 23, 26,28,29,30,33,35,38] @=>int scale[];
}


// main loop
while( true )
{

    //set pitch and map the axis position to the pentatonic tones.. (R-Y)
    Math.round((gt.axis[4]+1)*10)$int * 20/20 => int note; 
    scale[note] + PITCH_OFFSET => float pitch;
    <<<note>>>;
    
    // set freq.
    pitch => Std.mtof => fish[n].freq;
    
    // gain (R-Z) 
    //if (gt.axis[5] <= 0.40 ){ 0 => gt.axis[5];}
    //gt.axis[5]*4 =>fish[n].noteOn;
    
    
    // reverb mix (R-X) 
    for( int i; i < CHANNELS; i++ ){
        gt.axis[3]/2 +0.1 => rev[i].mix;
    }
    
    // stick hardness (L-X)
    Math.fabs(gt.axis[0]) => fish[n].stickHardness;
    
    // strike position(L-Y)
    Math.fabs(gt.axis[1]) => fish[n].strikePosition;
    
    // Loudness (L-Z)
    0.5 + gt.axis[2]*3 => fish[n].noteOn;
    
    // wait / (now/second - gt.lastTime/second)
    // Pitch (R-Y)
    Math.fabs(gt.axis[4]-gt.lastAxis[4]) * 1000  => float speed; 
    if ( speed >= 5.0 ) {5.0 => speed;} 
    T - Math.log2(speed/5+1)*950::ms => now;//the faster the swiping, the faster the sound goes
    //gain control
    0.5 + speed*0.10 => fish[n].noteOn;//the faster the swiping the louder the sound
    if (gt.axis[5] <= 0.40 ){ 0 => fish[n].noteOn;}//only when the stick is held above a specific height does the system work
    <<< "speed: ", speed>>>;
    n++;
    CHANNELS %=> n;
  
    
    //for reference: L: axis0-x, axis1-y, axis2-z
    //               R: axis3-x, axis4-y, axis5-z
}
fun void wind()
{
    while( true ){
    // sweep the filter resonant frequency
    100.0 + Std.fabs(Math.sin(gt.axis[2])) * 10000.0 => f.pfreq;
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
            }
            
            // joystick button up
            else if( msg.isButtonUp() )//
            {
                <<< "button", msg.which, "up" >>>;
            }
        }
    }
}

