function ApEn=approximate_entropy(data, m, L, r, metric)
% Pincus (1991), Bruhn (200), N~1000, r~0.1 or 0.2 of SD
% embedding dimension: m=2~3

% Ferenets (2007): 15s windows, 5s overlap, m=2, r=0.2SD, fs=400?, channel?, 6-47Hz, use M-module EEG
% Fan (2010): fs=128Hz, 
% Liang (2015): Fp1-A2, fs=(512=>)128Hz, 10s windows, 5s overlap

% data=randn(1000,1);L=1;m=3;r=std(data)*.2;
%% 1. calculation with embedding dimension = m
Ddata=delayRecons(data, L, m);
% calculate distance (D: symmetric distance matrix)
D=pdist(Ddata, metric);
% find close points
D_close=D<r;
% how many friends?
D_close=squareform(D_close);
N=size(D_close,2);
C=sum(D_close,2);
C=C(C~=0);
phi1=sum(log(C))/N;
%% 2. calculation with embedding dimension = m+1
Ddata=delayRecons(data, L, m+1);
% calculate distance (D: symmetric distance matrix)
D=pdist(Ddata, metric);
% find close points
D_close=D<r;
% how many friends?
D_close=squareform(D_close);
N=size(D_close,2);
C=sum(D_close,2);
C=C(C~=0);
phi2=sum(log(C))/N;
%% Apen
ApEn=phi1-phi2;


