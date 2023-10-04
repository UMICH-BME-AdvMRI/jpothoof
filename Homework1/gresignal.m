
function [Msig,Mss] = gresignal(FA,T1,T2,TE,TR,df)


N = 100;
M = zeros(3,N);
phi = ([1:N]/N-0.5 ) * 4*pi;

for i=1:N
	[M1sig,M1] = gssmulti(FA,T1,T2,TE,TR,df,phi(i));
	M(:,i)=M1;
end;

Mss = mean(M')';
Msig = Mss(1)+i*Mss(2);



