function x=pink_noise(N)
%% pink noise generator
% input %
% N: data length

% output %
% x: generated pink noise

% ref: https://ccrma.stanford.edu/~jos/sasp/Example_Synthesis_1_F_Noise.html
% 2016.1.25. Jisung Wang

B = [0.049922035 -0.095993537 0.050612699 -0.004408786];
A = [1 -2.494956002   2.017265875  -0.522189400];
nT60 = round(log(1000)/(1-max(abs(roots(A))))); % T60 est.
white = randn(1,N+nT60); % Gaussian white noise: N(0,1)
filtered= filter(B,A,white);    % Apply 1/F roll-off to PSD
x=filtered(nT60+1:end);    % Skip transient response