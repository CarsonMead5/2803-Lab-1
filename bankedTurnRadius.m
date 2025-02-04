function [bankRadius] = bankedTurnRadius(velocityBT,gravity,angle)
%BANKEDTURNRADIUS Summary of this function goes here

for i = 1:length(angle)
    bankRadius(i) = velocityBT^2 / gravity * cot(angle(i));
end

end

