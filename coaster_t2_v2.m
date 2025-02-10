%Lab 1, ASEN 2803-004, Group 4-10, Armand Etchen, 107290116, MOD 10FEB2025
%Transition into parabola. Starts from zero slope, ends at slope=0.8

%cleaning
clear
close all
clc

%start elevation 90, ends 111.8669
%arc length 67.4

%const
g=9.81;
h0=125;

%velocity
function  v=velocity(h)
    v=sqrt(2*9.81*(125-h));
end

%arc length
incr=0.1; r=100;
stot=0.67474*r;
s=0:incr:stot;

count=length(s);
sz=size(s);

%initializing
v=zeros(sz);
h=zeros(sz);
theta=zeros(sz);
Gnorm=zeros(sz);
Gtan=zeros(sz);
Glat=zeros(sz);
z=zeros(sz);
phi=zeros(sz);

%calculating
for i=1:count
    theta(i)=s(i)/r;
    h(i)=-cos(theta(i))*r+190;
    v(i)=velocity(h(i));
    Gnorm(i)=2*(h0-h(i))/r+cos(s(i)/r);
    Gtan(i)=-sin(s(i)/r);
end
GLat=s*0;

% Plotting the G-Force Graphs
figure()
sgtitle("Transition 2 G-Forces")

subplot(3,1,1)
hold on
plot(s,Gnorm,'b',LineWidth=1.5)
yline(6,'r')
yline(-1,'r')
hold off
title("Normal G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,s(end)])
ylim([-2,7])

subplot(3,1,2)
hold on
plot(s,Glat,'b',LineWidth=1.5)
yline(3,'r')
yline(-3,'r')
hold off
title("Lateral G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,s(end)])
ylim([-4,4])

subplot(3,1,3)
hold on
plot(s,Gtan,'b',LineWidth=1.5)
yline(5,'r')
yline(-4,'r')
hold off
title("Tangential G-Force vs. Distance")
xlabel("Distance (m)")
ylabel("G-Force")
xlim([0,s(end)])
ylim([-5,6])

print('t2_gforces_2803_lab1','-dpng','-r300') %saves image file (png)
