%% Pre-Processing
function [gFNormal,gFLateral,gFTan,distanceT3B] = coaster_t3()

% Retrieve Constants
const = getConst();

%% First Half of Transition:
% Inputs for circular element
xInitialT3A = 201.5485; % m
zInitialT3A = 50; % m
slopeInitialT3A = -2.8923;
zFinalT3A = 0; % m

% Calculate the angle and radius for circular arc
thetaTotalT3A = atan(-slopeInitialT3A);
phiT3A = pi / 2 - thetaTotalT3A;
radiusT3A = - zInitialT3A / ( sin(phiT3A) - 1 );

% Calculate length and set up distance vector
lengthT3A = thetaTotalT3A * radiusT3A;
distanceT3A = 0:const.stepSize:lengthT3A;

%% Modelling the Track
thetaT3A = distanceT3A / radiusT3A; % solve for angle for polar coordinates

% Convert to cartesian cooridnates
xT3A = radiusT3A .* cos(thetaT3A + pi + phiT3A) + (xInitialT3A+radiusT3A*cos(phiT3A));
zT3A = radiusT3A .* sin(thetaT3A + pi + phiT3A) + (radiusT3A);
yT3A(1:length(thetaT3A)) = 0;

% % Plot transition track
% plot3(xT3A,yT3A,zT3A,'k','LineWidth',2)
% grid on;
% title('Transition 5A Track Model')
% xlabel('X-Distance (m)')
% ylabel('Y-Distance (m)')
% zlabel('Z-Distance (m)')
% ylim([-5,5])

%% Calculating G's for First Half

% Initializing Count Vectors
count = length(distanceT3A);
Gnorm = zeros(1,count);
theta = zeros(1,count);
h = zeros(1,count);

for i=1:count
    theta(i)=thetaTotalT3A - distanceT3A(i)/radiusT3A;
    h(i)=-cos(theta(i))*radiusT3A+radiusT3A;
    Gnorm(i)=2*(const.h0Coaster-h(i))/radiusT3A+cos(thetaTotalT3A - distanceT3A(i)/radiusT3A);
end
Gtan = distanceT3A*0;
Glat= distanceT3A*0;

%% Second Half of Transition Calculations

% Find initial bank angle from banked turn element
gMaxBT = 3; % g's
initialBankAngle = acos( 1/gMaxBT ); % rad

% Given length of transition, find the linear change in theta
lengthT3B = 25; % m

% Set up distance vector
distanceT3B = 0:const.stepSize:lengthT3B;

% Use initial bank angle and length to find fitting cosine function
amplitude = initialBankAngle/2;
thetaT3B = - amplitude * cos(pi/25 * distanceT3B) + amplitude;

% % Check using plot
% figure();
% plot(distanceT6,theta)
% title('Bank Angle vs Distance')
% ylabel('Radians')
% xlabel('Meters')

% %% Modelling the Track
% 
% xT6 = distanceT6;
% yT6(1:length(distanceT6)) = 0;
% zT6(1:length(distanceT6)) = 0;
% 
% % Plot the linear track path
% figure();
% plot3(xT6,yT6,zT6,'k','LineWidth',2)
% grid on;
% title('Transition 6 Track Model')
% xlabel('X-Distance (m)')
% ylabel('Y-Distance (m)')
% zlabel('Z-Distance (m)')
% xlim([-5,30])
% ylim([-1,1])
% zlim([0,1])

%% Modelling Gs Along the Track

% Calculate Experienced & Allowable G-Forces in the Tangential Direction
gFTan = 0 * distanceT3B;
gFForwardMax(1,1:length(distanceT3B)) = 5;

gFBackwardMax(1,1:length(distanceT3B)) = 6;

% Calculate Experienced & Allowable G-Forces in the Lateral Direction
gFLateral = sin(thetaT3B);
gFLateralMax(1,1:length(distanceT3B)) = 3;

% Calculate Experienced & Allowable G-Forces in the Normal Direction
gFNormal = cos(thetaT3B);
gFUpMax(1,1:length(distanceT3B)) = 6;
gFDownMax(1,1:length(distanceT3B)) = 1;

%% Combining Vectors from First Half to Second Half of Transition

% Combining the vectors from each half of the transition
distanceT3B = [distanceT3A, distanceT3B + const.stepSize + distanceT3A(end)];
gFNormal = [Gnorm,gFNormal];
gFLateral = [Glat,gFLateral];
gFTan = [Gtan,gFTan];

% Plot Experienced & Allowable G-Forces in All Directions
hold on;
figure()
sgtitle("Transition 3 G-Forces")

subplot(3,1,1)
hold on
plot(distanceT3B,gFNormal,'b',LineWidth=1.5)
yline(6,'r')
yline(-1,'r')
hold off
title("Normal G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,distanceT3B(end)])
ylim([-2,7])

subplot(3,1,2)
hold on
plot(distanceT3B,gFLateral,'b',LineWidth=1.5)
yline(3,'r')
yline(-3,'r')
hold off
title("Lateral G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,distanceT3B(end)])
ylim([-4,4])

subplot(3,1,3)
hold on
plot(distanceT3B,gFTan,'b',LineWidth=1.5)
yline(5,'r')
yline(-4,'r')
hold off
title("Tangential G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,distanceT3B(end)])
ylim([-5,6])

print('transition3_gforces_2803_lab1','-dpng','-r300') %saves image file (png)

end
