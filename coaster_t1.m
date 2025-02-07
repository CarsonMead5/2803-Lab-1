function [Gnorm_t1,Glat_t1,Gtan_t1,s_t1] = coaster_t1(h_0,inc)

% Setting Parameters
r = 30; % m (radius of both quarter circles)
c = 2*sqrt(743.75); % m (circle 2 offset length)
length_flat = 60 - c; % m (length of flat section to loop)
h_c1 = 95; % m (height of center of first circle)
h_c2 = 120; % m (height of center of second circle)
i_h = 107.5; % m (intersect height of both circles)
theta_end = acos((i_h-h_c1)/r); % (theta of intersect of the two circles)

% Setting Arc Length of Transitions
s_1 = 0:inc:theta_end*r;
s_2 = 0:inc:theta_end*r;
s_3 = 0:inc:length_flat;

% Assigning G Force Vectors (Section 1)
Gnorm_1 = 3*cos(s_1/r) + 2*h_c1/r - 2*h_0/r;
Glat_1 = 0*ones(1,length(s_1));
Gtan_1 = sin(s_2/r);
% Assigning G Force Vectors (Section 2)
Gnorm_2 = 3*cos(theta_end - s_2/r) + 2*h_0/r - 2*h_c2/r;
Glat_2 = 0*ones(1,length(s_2));
Gtan_2 = sin(theta_end - s_2/r);
% Assigning G Force Vectors (Section 3)
Gnorm_3 = 1*ones(1,length(s_3));
Glat_3 = 0*ones(1,length(s_3));
Gtan_3 = 0*ones(1,length(s_3));

% Concatenating Arc Length Vectors
s_t1 = [s_1,s_2+inc+s_1(end),s_3+inc+s_1(end)+s_2(end)];

% Concatenating G Force Vectors
Gnorm_t1 = [Gnorm_1,Gnorm_2,Gnorm_3];
Glat_t1 = [Glat_1,Glat_2,Glat_3];
Gtan_t1 = [Gtan_1,Gtan_2,Gtan_3];

figure()
sgtitle("Transition 1 Loop G-Forces")

subplot(3,1,1)
hold on
plot(s_t1,Gnorm_t1,'b',LineWidth=1.5)
yline(6,'r')
yline(-1,'r')
hold off
title("Normal G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,s_t1(end)])
ylim([-2,7])

subplot(3,1,2)
hold on
plot(s_t1,Glat_t1,'b',LineWidth=1.5)
yline(3,'r')
yline(-3,'r')
hold off
title("Lateral G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,s_t1(end)])
ylim([-4,4])

subplot(3,1,3)
hold on
plot(s_t1,Gtan_t1,'b',LineWidth=1.5)
yline(5,'r')
yline(-4,'r')
hold off
title("Tangential G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,s_t1(end)])
ylim([-5,6])

print('transition1_gforces_2803_lab1','-dpng','-r300') %saves image file (png)

end
