clear; clc; close all;

%% Inputs

% Change step, inital height, and gravity to const

const = getConst();

velocityBT = sqrt( 2 * const.gravity * const.h0Coaster ); % m/s
const.stepSize = 0.1; % m
const.gravity = 9.81; % m/s/s

% Inputs
maxG = 5; % g's
lengthBT = 100; % m

% Set-Up arrays for the position every step length and the corresponding
% time values
distance = const.stepSize:const.stepSize:lengthBT; % m
timeValues = distance / velocityBT; % s

% Const for BT Angle
turnDuration = lengthBT / velocityBT; % s
maxBTAngle = acos( 1/maxG ); % rad
amplitudeBTAngle = maxBTAngle / 2; % rad

%% Modelling the Track

% θ(t) = - (θmax/2) * cos((2pi/turnDuration)t) + (θmax/2)
angle = bankedTurnTheta(amplitudeBTAngle,turnDuration,timeValues); % rad

figure();
plot(distance,angle)
title('Bank Angle vs Distance')
xlabel('Distance (m)')
ylabel('Bank Angle (Rad)')

% r = v^2/g * cot(θ(t))
radius = bankedTurnRadius(velocityBT,const.gravity,angle);

%{
figure();
plot(distance,radius)
set(gca,'YScale','log')
%}


theta = const.stepSize ./ radius;
for i = 1:length(radius)
    x(i) = radius(i) .* cos( sum(theta(1:i)));
    y(i) = radius(i) .* sin(sum(theta(1:i)));
end

%{
theta = distance ./ radius;
    x = radius .* cos(theta);
    y = radius .* sin(theta);

figure();
plot(x,y)
set(gca,'XScale','log')
% set(gca,'YScale','log')
%}

%% Modelling Gs Along the Track

gForceForBack = 0 * distance;
gForceLateral = 0 * distance;
gForceNormal = 1 ./ cos( angle );

figure();
subplot(1,3,1)
plot(distance,gForceForBack)
title('Forwards/Backwards G-Forces')
xlabel('Distance (m)')
ylabel('G-Forces (Gs)')

subplot(1,3,2)
plot(distance,gForceLateral)
title('Lateral G-Forces')
xlabel('Distance (m)')
ylabel('G-Forces (Gs)')

subplot(1,3,3)
plot(distance,gForceNormal)
title('Normal G-Forces')
xlabel('Distance (m)')
ylabel('G-Forces (Gs)')
