function [bankAngle] = bankedTurnTheta(amplitudeBTAngle,turnDuration,timeValues)
%BANKEDTURNANGLE Values of Theta over the duration of the turn

for i = 1:length(timeValues)
    bankAngle(i) = - amplitudeBTAngle * cos( (2*pi/turnDuration) * timeValues(i) ) + amplitudeBTAngle;
end

end
