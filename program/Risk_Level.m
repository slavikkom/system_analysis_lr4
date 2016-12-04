function [r R_L] = Risk_Level( R )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
r1 = R(1);
r2 = R(2);
r3 = R(3);
rr12=r1*r2;
rr13=r1*r3;
rr23=r2*r3;
r = 1-(1-r1)*(1-r2)*(1-r3);
if r == 0
    R_L = 0;
elseif r<0.35 && rr12==0 && rr13==0 && rr23 ==0
    R_L = 1;
elseif r<0.35
    R_L = 2;
elseif r>=0.35 && r<0.6
    R_L = 3;
elseif r>=0.6 && r<0.85
    R_L = 4;
elseif r>=0.85 && r<1
    R_L = 5;
else
    R_L = 6;
end
end

