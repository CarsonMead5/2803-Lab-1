function [G_updown,G_lateral,G_backwards,path_length] = coaster_breakingsection(h_0,inc)

% Define parameters
g = 9.81; % gravitational acceleration in m/s^2
v0 = sqrt(2*g*h_0); % initial velocity in m/s 
vf = 0; % final velocity in m/s
height_initial = 0;
height_final = 0;

a_maxb = 39.24;% maximum backward acceleration in m/s^2
db = (v0^2) / (2 * (a_maxb)); % distance traveled during braking
g = 9.81; % gravitational acceleration in m/s^2

% Calculate position along the braking section
path_length = 0:inc:db; % path length from 0 to db
G_lateral = 0 * ones(size(path_length));
G_updown = 1 * ones(size(path_length));
G_backwards = (a_maxb / g) * ones(size(path_length)); % constant backward G's

% Creating figure with subplots
figure()
sgtitle("Breaking Section Loop G-Forces")

subplot(3,1,1)
hold on
plot(path_length,G_updown,'b',LineWidth=1.5)
yline(6,'r')
yline(-1,'r')
hold off
title("Normal G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,path_length(end)])
ylim([-2,7])

subplot(3,1,2)
hold on
plot(path_length,G_lateral,'b',LineWidth=1.5)
yline(3,'r')
yline(-3,'r')
hold off
title("Lateral G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,path_length(end)])
ylim([-4,4])

subplot(3,1,3)
hold on
plot(path_length,G_backwards,'b',LineWidth=1.5)
yline(5,'r')
yline(-4,'r')
hold off
title("Tangential G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,path_length(end)])
ylim([-5,6])

print('breakingsection_gforces_2803_lab1','-dpng','-r300') %saves image file (png)

end
