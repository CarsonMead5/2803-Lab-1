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

count = length(distanceT5A);

for i=1:count
    theta(i)=distanceT5A(i)/radiusT5A;
    h(i)=-cos(theta(i))*radiusT5A+190;
    v(i)=velocity(h(i));
    Gnorm(i)=2*(const.h0Coaster-h(i))/radiusT5A+cos(distanceT5A(i)/radiusT5A);
end
Gtan = distanceT5A*0;
Glat= distanceT5A*0;

% Plotting the G-Force Graphs
figure()
sgtitle("Transition 2 G-Forces")

subplot(3,1,1)
hold on
plot(distanceT5A,Gnorm,'b',LineWidth=1.5)
yline(6,'r')
yline(-1,'r')
hold off
title("Normal G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,distanceT5A(end)])
ylim([-2,7])

subplot(3,1,2)
hold on
plot(distanceT5A,Glat,'b',LineWidth=1.5)
yline(3,'r')
yline(-3,'r')
hold off
title("Lateral G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,distanceT5A(end)])
ylim([-4,4])

subplot(3,1,3)
hold on
plot(distanceT5A,Gtan,'b',LineWidth=1.5)
yline(5,'r')
yline(-4,'r')
hold off
title("Tangential G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,distanceT5A(end)])
ylim([-5,6])

function  v=velocity(h)
    v=sqrt(2*9.81*(125-h));
end
