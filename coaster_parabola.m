%% Rollercoaster Zero G Parabola;
function [Gnorm_p,Glat_p,Gtan_p,s_p,x_end,s_end,z_end,dydx_end] = coaster_parabola(g,h_0,x_0,z_0,slope_i,inc,x_end)

% Calculating initial velocity slope at entrance
theta = atan(slope_i);

% Creating symbolic equations for the movement of the coaster
syms x
y = -4.905*((x-x_0)/(sqrt(2*g*(h_0-z_0))*cos(theta)))^2 + sqrt(2*g*(h_0-z_0))*sin(theta)*(x-x_0)/(sqrt(2*g*(h_0-z_0))*cos(theta))+z_0;
dydx = diff(y,x);

% Determining the end values based on the last t-value
z_end = -4.905*((x_end-x_0)/(sqrt(2*g*(h_0-z_0))*cos(theta)))^2 + sqrt(2*g*(h_0-z_0))*sin(theta)*(x_end-x_0)/(sqrt(2*g*(h_0-z_0))*cos(theta))+z_0;
dydx_end = double(subs(dydx,x,x_end));

% Creating a symbolic expression for the slope in the parabola
% dydx = dydt/dxdt;

% Arc length function that will be integrated
f = sqrt(1+dydx^2);

% Determining the total arc length of the parabola
s_end = double(int(f,x,x_0,x_end));

% Creating arc length vector with correct increment
s_p = 0:inc:s_end;

% Calculating g-forces (0 as no g-forces through whole parabola)
Gnorm_p = zeros(1,length(s_p));
Glat_p = zeros(1,length(s_p));
Gtan_p = zeros(1,length(s_p));

% Plotting the G-Force Graphs
figure()
sgtitle("Zero-G Parabola G-Forces")

subplot(3,1,1)
hold on
plot(s_p,Gnorm_p,'b',LineWidth=1.5)
yline(6,'r')
yline(-1,'r')
hold off
title("Normal G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,s_p(end)])
ylim([-2,7])

subplot(3,1,2)
hold on
plot(s_p,Glat_p,'b',LineWidth=1.5)
yline(3,'r')
yline(-3,'r')
hold off
title("Lateral G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,s_p(end)])
ylim([-4,4])

subplot(3,1,3)
hold on
plot(s_p,Gtan_p,'b',LineWidth=1.5)
yline(5,'r')
yline(-4,'r')
hold off
title("Tangential G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,s_p(end)])
ylim([-5,6])

print('parabola_gforces_2803_lab1','-dpng','-r300') %saves image file (png)

end
