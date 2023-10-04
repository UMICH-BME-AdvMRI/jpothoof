clc
clear
close all

tbw = 2;
ts = 1 *10^-3; % s
df = tbw/ts; 
y = 42.58 * 10^6; %Hz/T
yg = y/(2*pi);
dz = (3 *10^-3); % m
phi = 180; %T/m/s
FOV = [256 256]*1.2/1000; %m 
Gmax = 25/1000; % T/m

Gs = df/(y*dz); %mT/m

Tramp = Gs/phi;
Gss = Gs * 1000;
Ttot = 2*Tramp+ts;

Tpe = 1/(y*FOV(2)*Gmax);


