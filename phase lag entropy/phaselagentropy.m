function [ple, pli, pc, P]=phaselagentropy(wdata, m, tau)
% INPUT
%   bdata: band-pass filtered data
%   dim: embedding dimension
%   lag: time lag
%
% OUTPUT
%   ple: phase lag entropy
%       to use matrix form: ple_mat = squareform(ple);
%
% 2015.7.17. Heonsoo Lee
% 2017.12.6. Updated, Heonsoo Lee 
% 2018.4.21. Updated, Heonsoo Lee


[len,ch]=size(wdata);
u_len=2^m; % number of patterns
edges1=0:u_len;
a_sig=hilbert(wdata); % analytic signal of signals

cc=0;c_sig=zeros(len, ch*(ch-1)/2);
for c1=1:ch
    c_sig_tmp=repmat(a_sig(:,c1),[1, ch-c1]).*conj(a_sig(:,c1+1:end)); % conjugate product to prevent phase jump
    c_sig(:,cc+1:cc+size(c_sig_tmp,2))=c_sig_tmp;
    cc=cc+size(c_sig_tmp,2);   
end
ph_vec=c_sig./abs(c_sig);
pc=abs(mean(ph_vec));

pll=sign(imag(c_sig));
pli=abs(mean(pll));

pll=heaviside(pll);
Ddata=delayRecons(pll, tau, m);
udata=zeros(size(Ddata,1), 1, size(Ddata,3));
for i=1:m
    udata = udata + Ddata(:,i,:)*2^(i-1);
end
udata=single(squeeze(udata));

cpair=size(udata,2);
for c=1:cpair
    % 4. calculate probability & entropy
    p=histcounts(udata(:,c), edges1);
    p=p./sum(p);
    P(:,c)=p;
    
    ple_tmp=-sum(p.*(log2(p+eps)));
    ple(c)=ple_tmp./log2(u_len); % normalization
end

