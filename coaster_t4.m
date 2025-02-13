function [gFNormal,gFLateral,gFTan,distanceT6] = coaster_t4()

% Retrieve Constants
const = getConst();

%% 2nd Half of the Transition:

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

% % Check using plot
% figure();
% plot(distanceT6,theta)
% title('Bank Angle vs Distance')
% ylabel('Radians')
% xlabel('Meters')

%% Modelling the Track

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
gFTan = 0 * distanceT6;
gFForwardMax(1,1:length(distanceT6)) = 5;
gFBackwardMax(1,1:length(distanceT6)) = 6;

% Calculate Experienced & Allowable G-Forces in the Lateral Direction
gFLateral = sin(theta);
gFLateralMax(1,1:length(distanceT6)) = 3;

% Calculate Experienced & Allowable G-Forces in the Normal Direction
gFNormal = cos(theta);
gFUpMax(1,1:length(distanceT6)) = 6;
gFDownMax(1,1:length(distanceT6)) = 1;

% Plot Experienced & Allowable G-Forces in All Directions
hold on;
figure()
sgtitle("Transition 4 G-Forces")

subplot(3,1,1)
hold on
plot(distanceT6,gFNormal,'b',LineWidth=1.5)
yline(6,'r')
yline(-1,'r')
hold off
title("Normal G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,distanceT6(end)])
ylim([-2,7])

subplot(3,1,2)
hold on
plot(distanceT6,gFLateral,'b',LineWidth=1.5)
yline(3,'r')
yline(-3,'r')
hold off
title("Lateral G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,distanceT6(end)])
ylim([-4,4])

subplot(3,1,3)
hold on
plot(distanceT6,gFTan,'b',LineWidth=1.5)
yline(5,'r')
yline(-4,'r')
hold off
title("Tangential G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,distanceT6(end)])
ylim([-5,6])

print('transition4_gforces_2803_lab1','-dpng','-r300') %saves image file (png)

end