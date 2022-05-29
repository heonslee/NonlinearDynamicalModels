function Data=henon_map(N, a, b, n_trials)
%% Henon Map
% input
% N: data length
% a, b: parameters (1.1, 0.4)
% n_trials: # of data pairs you want to generate

% output
% data: henon map (N x 2 x n_trials)

% 2016.1.15. Jisung Wang
%%
n=2000+N;
data=rand(1,2,n_trials);
for i=1:n-1
    data(i+1,1,:)=data(i,2,:)+1-a*data(i,1,:).^2;
    data(i+1,2,:)=b*data(i,1,:);
end
Data=data(2001:2000+N,:,:);