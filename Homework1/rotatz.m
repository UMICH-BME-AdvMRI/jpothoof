function [rz] = rotatz(phi)
rz = [cos(phi) -sin(phi) 0; sin(phi) cos(phi) 0; 0 0 1];