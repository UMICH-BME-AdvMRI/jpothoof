clc
clear all

load Data_Assignment3_Problem1.mat
d1 = permute(kspaceData_SingleCoil,[2 1]);
%% Pr 1a
ratio = 5/8;
lines = ratio * size(d1,2);
fullim = ifftshift(ifft2(ifftshift(d1)));

unders_k = zeros(size(d1));
unders_k(:,1:lines) = d1(:,1:lines);
unders = ifftshift(ifft2(ifftshift(unders_k)));

figure
subplot(1,2,1)
im(abs(unders))
title("Magnitude Image")
subplot(1,2,2)
im(angle(unders))
title("Phase Image")

phasediff = angle(fullim)-angle(unders);

magdiff = abs(fullim)-abs(unders);

figure
subplot(1,2,1)
im(magdiff)
title("Magnitude Image Difference")
subplot(1,2,2)
im(phasediff)
title("Phase Image Difference")
%% Pr 1b

h = hann(200)*hanning(200)';

k_start = unders_k;

cenK = zeros(size(k_start));
cenK(:,75:125) = k_start(:,75:125);
mid_im = ifftshift(ifft2(ifftshift(cenK)));
phase_init = angle(mid_im);
im_tmp = ifftshift(ifft2(ifftshift(k_start)));
im_rep = abs(im_tmp) .*exp(1j*phase_init);
new_k = fftshift(fft2(fftshift(im_rep)));
new_k0 = zeros(size(new_k));
new_k0(:,1:lines) = new_k(:,1:lines);

%%
for i = 1:25
    im_tmp = ifftshift(ifft2(ifftshift(new_k0)));
    im_rep = abs(im_tmp) .*exp(1j*phase_init);
    new_k = fftshift(fft2(fftshift(im_rep)));
    new_k0 = zeros(size(new_k));
    new_k0(:,1:lines) = new_k(:,1:lines);
end

new_im = ifftshift(ifft2(ifftshift(new_k)));
figure
subplot(1,2,1)
im(abs(new_im))
title("Magnitude Image POCS")
subplot(1,2,2)
im(angle(new_im))
title("Phase Image POCS")


phasediff = angle(fullim)-angle(new_im);

magdiff = abs(fullim)-abs(new_im);


figure
subplot(1,2,1)
im(magdiff)
title("Magnitude Image Difference POCS")
subplot(1,2,2)
im(phasediff)
title("Phase Image Difference POCS")

