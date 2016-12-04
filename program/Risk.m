function R = Risk( value, value_crtkl, value_nrml )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if value > value_nrml
    R=0;
elseif value < value_crtkl
    R=1;
else
    R = (value_nrml - value)/(value_nrml - value_crtkl);

end

