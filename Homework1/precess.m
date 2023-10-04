function [A,B]= precess(t,T1,T2,df)

deg = 2*pi*df*t/1000;

r1 = exp(-t/T1);
r2 = exp(-t/T2);

A = [r2 0 0;0 r2 0;0 0 r1]*rotatz(deg);
B = [0 0 1-exp(-t/T1)]';