function data=logistic_map(N,n_trials,r_range)
%% data generated from the logistic map
% output %
% data: N x ntrials x r
N_fin=N;
N=2000+N_fin;
i=1;
tot_r=numel(r_range)+1;
for r=r_range
    X=rand(1, n_trials);
    for n=1:N
        X(n+1,:)=r*X(n,:).*(1-X(n,:));
    end
    data(:,:,i)=X(N-N_fin+1:N,:);
    i=i+1;
    i/tot_r
end
