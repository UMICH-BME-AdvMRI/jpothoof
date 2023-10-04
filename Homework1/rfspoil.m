function [Msig,Mss]=rfspoil(FA,T1,T2,TE,TR,df,N,inc)

if (nargin < 8)
	inc = 117/180*pi;
end;
if (nargin < 7)
	N = 100;
end;
if (nargin < 6)
	df = 0;
end;

Nf = 100;	% Simulate 100 different gradient-spoiled spins.
phi = [1:Nf]/Nf*2*pi;

M=zeros(3,Nf,N+1);

	
[Ate,Bte] = precess(TE,T1,T2,df);
[Atr,Btr] = precess(TR-TE,T1,T2,df);

M = [zeros(2,Nf);ones(1,Nf)];
on = ones(1,Nf);
	
Rfph = 0;
Rfinc = inc;

for n=1:N
	A = Ate * rotatxyz(FA,Rfph);
	B = Bte;
	M = A*M+B*on;
	Msig = mean( squeeze(M(1,:)+i*M(2,:)) ) * exp(-i*Rfph);
	Mss = M;
	M=Atr*M+Btr*on;
	for m=1:Nf
		M(:,m) = rotatz(phi(m))*M(:,m);
	end;

	Rfph = Rfph+Rfinc;
	Rfinc = Rfinc+inc;
end;


		






