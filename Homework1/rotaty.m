function [ry] = rotaty(phi)

ry = [cos(phi) 0 sin(phi);0, 1, 0; -sin(phi) 0 cos(phi)];