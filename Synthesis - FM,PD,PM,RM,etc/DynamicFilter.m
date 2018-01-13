% Dynamic Filter

fs              =   44100;
sampingPeriod   =   1/fs;
dur             =   1;
% t               =   0:(1/fs):(dur-1/fs);
amp             =   1;
freq            =   440;
t_AT            =   .5; % attack time in seconds


attackCoeff = 1 - exp(-1.0 * sampingPeriod / t_AT);

sig = zeros(1,fs*dur);
env = 1;

for s = 1:fs*dur
        
    currentSample = amp * 1;
    sig(s) =  env * currentSample;
    env = env + attackCoeff * (1- (1/0.63) - env);
    
    % attackCoef_ = 1 - exp(-1.0f / (samplerate * config_.atkTime_));
    % envelope_ += config_.aCoef_ * ((1/0.63f) - envelope_);
end

figure;
tVec =  0:(1/fs):(dur-1/fs);
plot(tVec, sig);

% soundsc(sig,fs);