function [SpEn, cSum] = sample_entropy(data,m,L,r, metric)
% data=randn(1000,1);L=1;m=3;r=std(data)*.2;
%% 1. calculation with embedding dimension = m
Ddata=delayRecons(data, L, m);
C1=correlation_sum(Ddata, r, 1, metric);
%% 2. calculation with embedding dimension = m+1
Ddata=delayRecons(data, L, m+1);
cSum=correlation_sum(Ddata, r, 1, metric);
%% Apen
SpEn=-log(cSum+eps/C1);


