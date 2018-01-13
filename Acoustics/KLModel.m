% Demo on Kelly-Lochbaum equations

%S = [1 2 5 2 1 10]; % surface areas of the tubes. The last is out there
S = [1 4 3 1 2 10];
len = 0.03; % the length of a tube, m
v = 340; % the speed of sound, m/s
k = (S(1:end-1)-S(2:end))./(S(1:end-1)+S(2:end)); % reflection coefficients

fs = round( v/len); % sampling frequency
x = zeros(1,1000);
x(1) = 1; % let¡¯s calculate impulse response of length 1000
g = 0.5; % reflection at the glottis
d = 0.95; % ¡¯loss¡¯ coefficient (quite arbitrary)
F0 = zeros(1,length(S)); % forward travelling waves before delay,
% first is glottis
F1 = zeros(1,length(S)-1); % forward travelling waves after delay
B0 = zeros(1,length(S)); % backward travelling waves after delay
B1 = zeros(1,length(S)); % backward before delay
for n = 1:length(x),
    F0old = F0;
    F1old = F1;
    B0old = B0;
    B1old = B1;
    B0(1) = B1old(1);
    F0(1) = B0(1)*g+x(n); % glottis-excitation + reflection
    F1(1) = F0old(1);
    if ( length(B0) < 3),
        B1(1) = 0;
    else
        B1(1) = B1(2)*d*(1+k(1)) + F1(1)*d*k(1);
    end
    for i = 2:length(F1),
        B0(i) = B1old(i);
        F0(i) = F1(i-1)*d*(1-k(i-1)) + B0(i)*d*(-k(i-1));
        F1(i) = F0old(i-1);
        B1(i) = B1(i+1)*d*(1+k(i)) + F1(i)*d*k(i);
    end
    b02(n) = B0(2);
    B0(end) = 0; % no reflection back
    F0(end) = F1(end)*d*(1-k(end));
    y(n) = F0(end); % save the output
end

figure
freqz(y,1,1024,fs);
title('Frequency response')