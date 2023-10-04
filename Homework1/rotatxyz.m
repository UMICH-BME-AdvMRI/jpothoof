function [rxyz] = rotatxyz(phi,theta)
 
rxyz = rotatz(theta)*rotatx(phi)*rotatz(-theta);