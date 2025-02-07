function [gForceNormal,gForceLateral,gForceForBack,distance] = coaster_bankedturn(lengthBT,h_0,height,stepLength)
%% Inputs

% Change step, inital height, and gravity to const

gravity = 9.81; % m/s/s
velocityBT = sqrt(2*gravity*(h_0-height)); % m/s
maxG = 5;

% Set-Up arrays for the position every step length and the corresponding
% time values
distance = stepLength:stepLength:lengthBT; % m
timeValues = distance / velocityBT; % s

% Const for BT Angle
turnDuration = lengthBT / velocityBT; % s
maxBTAngle = acos( 1/maxG ); % rad
amplitudeBTAngle = maxBTAngle / 2; % rad

%% Modelling the Track

% θ(t) = - (θmax/2) * cos((2pi/turnDuration)t) + (θmax/2)
angle = bankedTurnTheta(amplitudeBTAngle,turnDuration,timeValues); % rad
% plot(distance,angle)

% r = v^2/g * cot(θ(t))
radius = bankedTurnRadius(velocityBT,gravity,angle);

%{
figure();
plot(distance,radius)
set(gca,'YScale','log')
%}

x = zeros(1,length(radius));
y = zeros(1,length(radius));

theta = stepLength ./ radius;
for i = 1:length(radius)
    x(i) = radius(i) .* cos( sum(theta(1:i)));
    y(i) = radius(i) .* sin(sum(theta(1:i)));
end


%{
theta = distance ./ radius;
    x = radius .* cos(theta);
    y = radius .* sin(theta);
%}

% plot(x,y)
% set(gca,'XScale','log')
% set(gca,'YScale','log')

%% Modelling Gs Along the Track

gForceForBack = 0;
gForceLateral = 0;
gForceNormal = 1 ./ cos( angle );

figure();
sgtitle("Banked Turn G-Forces")

subplot(3,1,1)
hold on
plot(distance,gForceNormal,'b',LineWidth=1.5)
yline(6,'r')
yline(-1,'r')
hold off
title('Normal G-Forces vs. Distance')
xlabel('Distance (m)')
ylabel('G-Force')
xlim([0,distance(end)])
ylim([-2,7])

subplot(3,1,2)
hold on
yline(gForceLateral,'b',LineWidth=1.5)
yline(3,'r')
yline(-3,'r')
hold off
title('Lateral G-Force vs. Distance')
xlabel('Distance (m)')
ylabel('G-Force')
xlim([0,distance(end)])
ylim([-4,4])

subplot(3,1,3)
hold on
yline(gForceForBack,'b',LineWidth=1.5)
yline(5,'r')
yline(-4,'r')
hold off
title('Tangential G-Force vs. Distance')
xlabel('Distance (m)')
ylabel('G-Forces (Gs)')
xlim([0,distance(end)])
ylim([-5,6])

print('bankedturn_gforces_2803_lab1','-dpng','-r300') %saves image file (png)

end
