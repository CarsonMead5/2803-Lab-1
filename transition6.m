%% Pre-Processing
clear; clc; close all;

% Retrieve Constants
const = getConst();

% Find initial bank angle from banked turn element
gMaxBT = 3; % g's
initialBankAngle = acos( 1/gMaxBT ); % rad

% Given length of transition, find the linear change in theta
lengthT6 = 25; % m

% Set up distance vector
distanceT6 = 0:const.stepSize:lengthT6;

% Use initial bank angle and length to find fitting cosine function
amplitude = initialBankAngle/2;
theta = amplitude * cos(pi/25 * distanceT6) + amplitude;

% Check using plot
figure();
plot(distanceT6,theta)
title('Bank Angle vs Distance')
ylabel('Radians')
xlabel('Meters')

%% Modelling the Track

xT6 = distanceT6;
yT6(1:length(distanceT6)) = 0;
zT6(1:length(distanceT6)) = 0;

% Plot the linear track path
figure();
plot3(xT6,yT6,zT6,'k','LineWidth',2)
grid on;
title('Transition 6 Track Model')
xlabel('X-Distance (m)')
ylabel('Y-Distance (m)')
zlabel('Z-Distance (m)')
xlim([-5,30])
ylim([-1,1])
zlim([0,1])

%% Modelling Gs Along the Track

% Calculate Experienced & Allowable G-Forces in the Tangential Direction
gFForward = 0 * distanceT6;
gFForwardMax(1,1:length(distanceT6)) = 5;

gFBackward = 0 * distanceT6;
gFBackwardMax(1,1:length(distanceT6)) = 6;

% Calculate Experienced & Allowable G-Forces in the Lateral Direction
gFLateral = tan(theta);
gFLateralMax(1,1:length(distanceT6)) = 3;

% Calculate Experienced & Allowable G-Forces in the Normal Direction
gFNormal = 1./cos(theta);
gFUpMax(1,1:length(distanceT6)) = 6;
gFDownMax(1,1:length(distanceT6)) = 1;

% Plot Experienced & Allowable G-Forces in All Directions
hold on;
figure();
subplot(2,2,1)
plot(distanceT6,gFForward,'k',distanceT6,gFForwardMax,'r--')
title('Forwards G-Forces')
xlabel('Distance (m)')
ylabel('G-Forces (Gs)')
ylim([-0.5,6.5])
legend('Forward Gs Felt', 'Forward G Limit', Location='east')

subplot(2,2,2)
plot(distanceT6,gFBackward,'k',distanceT6,gFBackwardMax,'r--')
title('Backwards G-Forces')
xlabel('Distance (m)')
ylabel('G-Forces (Gs)')
ylim([-0.5,6.5])
legend('Backward Gs Felt', 'Backward G Limit',Location='east')

subplot(2,2,3)
plot(distanceT6,gFLateral,'k',distanceT6,gFLateralMax,'r--')
title('Lateral G-Forces')
xlabel('Distance (m)')
ylabel('G-Forces (Gs)')
ylim([-0.5,6.5])
legend('Lateral Gs Felt', 'Lateral G Limit')

subplot(2,2,4)
plot(distanceT6,gFNormal,'k',distanceT6,gFUpMax,'g--',distanceT6,gFDownMax,'r--')
title('Normal G-Forces')
xlabel('Distance (m)')
ylabel('G-Forces (Gs)')
ylim([-0.5,6.5])
legend('Normal Gs Felt', 'Upward G Limit', 'Downward G Limit',Location='southoutside')
