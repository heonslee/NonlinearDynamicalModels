function [C, D_close] = correlation_sum(Ddata, r, n_min, metric)

% n_min=10;r=3.2;data=randn(100,1);m=3;L=1;Ddata=delayRecons(data,L,m);metric = 'chebychev'

%% calculate distance (D: symmetric distance matrix)
D=pdist(Ddata, metric);%,'chebychev');
% D=ones(10,10)*3.1;n_min=2;
%% find close points
D_close=D<r;
D_close=squareform(D_close);
N=size(D_close,1);
% D_close=ones(50,50);N=size(D_close,1);n_min=2;
%% Exclude the points which are on the same trajectory
for i=1:n_min
    D_close(i:N+1:end)=0;
end
D_close=D_close';
for j=1:n_min
    D_close(j:N+1:end)=0;
end
D_close=D_close'; % figure;imagesc(D_close)
%% how many friends?
C=sum(D_close(:),'omitnan');
%% normalization
n_min=n_min-1;
denom=(N-n_min)*(N-n_min-1);
C=C/denom;


