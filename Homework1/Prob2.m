clc
clear
close all

t = 50;
T2 = 100;
T1 = 300;
TR = [5, 10, 20];
TE = [2.5, 5, 10];
FA = pi/3;
phi = 0;
offset = -100:100;

s = zeros(length(offset),length(TE));

for i = 1:length(TE)
    for j = 1:length(offset)
        [Ms,~] = steady_state(FA,T1,T2,TE(i),TR(i),offset(j));
        s(j,i) = Ms(1)+1i*Ms(2);
    end
end

ANSWER_2bi = s;

subplot(2,1,1);
plot(offset,-1-abs(s));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title("BSSFP 60 Degree")

legend('TE=0', 'TE=2.5', 'TE=5.0', 'TE=7.5', 'TE=10');

subplot(2,1,2);
plot(offset,angle(s));
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
axis([min(offset) max(offset) -pi pi]);
legend('TE=0', 'TE=2.5', 'TE=5.0', 'TE=7.5', 'TE=10');

%% 2bi

Tr1 = 10;
Te1 = 5;
T11 = 1000;
T21 = 100;
FA1 = deg2rad(10);
offset1 = 0;

[~,Msi] = steady_state(FA1,T11,T21,Te1,Tr1,offset1);
%% 2bii
for k = 1:4
   [Msg,Mss] = gresignal(FA1,T11,T21,Te1,Tr1,pi*2^k);
end

figure

subplot(2,1,1);

scatter([2*pi,4*pi,8*pi,16*pi], abs(Msg))
title("Signal after non Ideal Spoiler")
ylim([-.001 .001])
xlabel('Dephasing Moment');
ylabel('Magnitude');

subplot(2,1,2);
scatter([2*pi,4*pi,8*pi,16*pi], angle(Msg))
xlabel('Dephasing Moment');
ylabel('Phase');
ylim([-.001, .001])

%% 2biii
N= 100;
inc = linspace(1,180,N);

Msig2 = zeros([length(inc) 1]);
Mss2 = zeros([3 length(inc) N]);
for p = 1:length(inc)
    [Msig2(p,:), Mss2(:,p,:)] = rfspoil(FA1,T11,T21,Te1,Tr1,0,N,deg2rad(inc(p)));
end

figure
subplot(2,1,1);
plot(inc,abs(Msig2))
title("Signal After Gradient and RF Spoiler")
xlabel("RF Phase")
ylabel("Magnitude")

subplot(2,1,2);
plot(inc,angle(Msig2))
xlabel("RF Phase")
ylabel("Phase")








