%% Pre-Processing
clear; clc; close all;

% Retrieve Constants
const = getConst();

% Banked Turn Velocity
const.velocityBT = sqrt( 2 * const.gravity * const.h0Coaster ); % m/s

% Inputs
gMaxBT = 5; % g's

% Turn Bank Angle, Radius, Length Calcualtions
bankAngleBT = acos( 1/gMaxBT ); % rad
radiusBT = const.velocityBT^2 / const.gravity * cos(bankAngleBT) / sin(bankAngleBT); % m
lengthBT = pi * radiusBT;

%% Modelling the Track

distanceBT = 0:const.stepSize:lengthBT; % Set up array of distance values
thetaBT = distanceBT / radiusBT; % Use distance value and radius to solve for internal angle

% Use radius and angle to convert to cartesian coordinates
yBT = radiusBT .* cos(thetaBT);
xBT = radiusBT .* sin(thetaBT);
zBT(1:length(thetaBT)) = 0;

% Plot the semi-circular track path
figure();
plot3(xBT,yBT,zBT,'k','LineWidth',2)
grid on;
title('Banked Turn Track Model')
xlabel('X-Distance (m)')
ylabel('Y-Distance (m)')
zlabel('Z-Distance (m)')
axis square;
xlim([-55,55])
ylim([-55,55])
zlim([0,5])

%% Modelling Gs Along the Track

% Calculate Experienced & Allowable G-Forces in the Tangential Direction
gFForward = 0 * distanceBT;
gFForwardMax(1,1:length(distanceBT)) = 5;

gFBackward = 0 * distanceBT;
gFBackwardMax(1,1:length(distanceBT)) = 6;

% Calculate Experienced & Allowable G-Forces in the Lateral Direction
gFLateral(1,1:length(distanceBT)) = 0;
gFLateralMax(1,1:length(distanceBT)) = 3;

% Calculate Experienced & Allowable G-Forces in the Normal Direction
gFNormal(1,1:length(distanceBT)) = 1 / cos( bankAngleBT );
gFUpMax(1,1:length(distanceBT)) = 6;
gFDownMax(1,1:length(distanceBT)) = 1;

% Plot Experienced & Allowable G-Forces in All Directions
hold on;
figure();
subplot(2,2,1)
plot(distanceBT,gFForward,'k',distanceBT,gFForwardMax,'r--')
title('Forwards G-Forces')
xlabel('Distance (m)')
ylabel('G-Forces (Gs)')
ylim([-0.5,6.5])
legend('Forward Gs Felt', 'Forward G Limit', Location='east')

subplot(2,2,2)
plot(distanceBT,gFBackward,'k',distanceBT,gFBackwardMax,'r--')
title('Backwards G-Forces')
xlabel('Distance (m)')
ylabel('G-Forces (Gs)')
ylim([-0.5,6.5])
legend('Backward Gs Felt', 'Backward G Limit',Location='east')

subplot(2,2,3)
plot(distanceBT,gFLateral,'k',distanceBT,gFLateralMax,'r--')
title('Lateral G-Forces')
xlabel('Distance (m)')
ylabel('G-Forces (Gs)')
ylim([-0.5,6.5])
legend('Lateral Gs Felt', 'Lateral G Limit')

subplot(2,2,4)
plot(distanceBT,gFNormal,'k',distanceBT,gFUpMax,'g--',distanceBT,gFDownMax,'r--')
title('Normal G-Forces')
xlabel('Distance (m)')
ylabel('G-Forces (Gs)')
ylim([-0.5,6.5])
legend('Normal Gs Felt', 'Upward G Limit', 'Downward G Limit',Location='east')
