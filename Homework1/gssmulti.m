
function [Msig,Mss] = gssmulti(FA,T1,T2,TE,TR,df,phi)

[Ar,Br] = precess(TR-TE,T1,T2,df);
[Ae,Be] = precess(TE,T1,T2,df);

% 	To add the gradient spoiler twist, we just
%	multiply Atr by zrot(phi):

Ar = rotatz(phi)*Ar;

% Let 	M1 be the magnetization just before the tip.
%	M2 be just after the tip.
%	M3 be at TE.
%
% then
%	M2 = Rflip * M1
%	M3 = Ate * M2 + Bte
%	M1 = Atr * M3 + Btr
%
% Solve for M3...
%
%	M3 = Ate*Rflip*Atr*M3 + (Ate*Rflip*Btr+Bte)
I = [1 0 0; 0 1 0; 0 0 1];
Mss = inv(I(3)-Ae*rotaty(FA)*Ar) * (Ae*rotaty(FA)*Br+Be);
Msig = Mss(1)+i*Mss(2);

