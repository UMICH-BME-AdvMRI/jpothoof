function [Mss,Msig]=steady_state(FA,T1,T2,TE,TR,df)

[Ar, Br] = precess(TR-TE, T1,T2,df);

[Ae, Be] = precess(TE,T1,T2,df);

I = [1 0 0; 0 1 0; 0 0 1];

Mss = inv(I-Ae*roty(FA)*Ar) * (Ae*roty(FA)*Br+Be);
Msig = Mss(1)+i*Mss(2);
