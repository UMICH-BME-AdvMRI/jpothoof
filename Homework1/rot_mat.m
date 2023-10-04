function [rot] = rot_mat(deg, axis)


if axis(1)==1
    rot = rotx(deg);
elseif axis(2)==1
    rot = roty(deg);
elseif axis(3)==1
    rot = rotz(deg);
end

