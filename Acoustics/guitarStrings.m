
Fs       = 44100;
A        = 110; % The A string of a guitar is normally tuned to 110 Hz
Eoffset  = -5;
Doffset  = 5;
Goffset  = 10;
Boffset  = 14;
E2offset = 19;

% Generate the frequency vector that we will use for analysis.
F = linspace(1/Fs, 1000, 2^12);

% Generate 4 seconds of zeros to be used to generate the guitar notes.
x = zeros(Fs*4, 1);

% When a guitar string is plucked or strummed, it produces a sound wave
% with peaks in the frequency domain that are equally spaced.  These are
% called the harmonics and they give each note a full sound.  We can
% generate sound waves with these harmonics with discrete-time filter
% objects.

% Determine the feedback delay based on the first harmonic frequency
delay = round(Fs/A);

