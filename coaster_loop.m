%% Calculating G Forces around a Roller Coaster Loop
function [Gnorm,Glat,Gtan,s_l] = coaster_loop(h_0,r,loop_height,inc)

    s_l = 0:inc:2*pi*r; % Increments of 0.01 m of arc length

% Calculating G-Force
    Gnorm = 2*(h_0-loop_height)/r + 3*cos(s_l/r);
    Glat = 0*s_l;
    Gtan = -sin(s_l/r);

% Plotting the G-Force Graphs
figure()
sgtitle("Vertical Loop G-Forces")

subplot(3,1,1)
hold on
plot(s_l,Gnorm,'b',LineWidth=1.5)
yline(6,'r')
yline(-1,'r')
hold off
title("Normal G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,s_l(end)])
ylim([-2,7])

subplot(3,1,2)
hold on
plot(s_l,Glat,'b',LineWidth=1.5)
yline(3,'r')
yline(-3,'r')
hold off
title("Lateral G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,s_l(end)])
ylim([-4,4])

subplot(3,1,3)
hold on
plot(s_l,Gtan,'b',LineWidth=1.5)
yline(5,'r')
yline(-4,'r')
hold off
title("Tangential G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,s_l(end)])
ylim([-5,6])

print('loop_gforces_2803_lab1','-dpng','-r300') %saves image file (png)

end
