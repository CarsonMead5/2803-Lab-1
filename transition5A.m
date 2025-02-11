%% Pre-Processing
clear; clc; close all;

% Retrieve Constants
const = getConst();

% Inputs for circular element
xInitialT5A = 201.5485; % m
zInitialT5A = 50; % m
slopeInitialT5A = -2.8923;
zFinalT5A = 0; % m

% Calculate the angle and radius for circular arc
thetaTotalT5A = atan(-slopeInitialT5A);
phiT5A = pi / 2 - thetaTotalT5A;
radiusT5A = - zInitialT5A / ( sin(phiT5A) - 1 );

% Calculate length and set up distance vector
lengthT5A = thetaTotalT5A * radiusT5A;
distanceT5A = 0:const.stepSize:lengthT5A;

%% Modelling the Track
thetaT5A = distanceT5A / radiusT5A; % solve for angle for polar coordinates

% Convert to cartesian cooridnates
xT5A = radiusT5A .* cos(thetaT5A + pi + phiT5A) + (xInitialT5A+radiusT5A*cos(phiT5A));
zT5A = radiusT5A .* sin(thetaT5A + pi + phiT5A) + (radiusT5A);
yT5A(1:length(thetaT5A)) = 0;

% Plot transition track
plot3(xT5A,yT5A,zT5A,'k','LineWidth',2)
grid on;
title('Transition 5A Track Model')
xlabel('X-Distance (m)')
ylabel('Y-Distance (m)')
zlabel('Z-Distance (m)')
ylim([-5,5])

%% Modelling G-Forces Along the Track
