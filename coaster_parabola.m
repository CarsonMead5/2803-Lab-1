%Lab 1, ASEN 2803-004, Group 4-10, Armand Etchen, 107290116, MOD 07FEB2025
%Parabola section

%cleaning
clear
close all
clc

%const
g=9.81;
h0=125;

%velocity
syms h
v=sqrt(2*g*(h0-h));

%parabola
syms x
y=(-1/100)*x^2+100;

%diffs
yp=diff(y,x);
ypp=diff(y,x,2);

%dist
function s=dist(x)
    s=sqrt(1+(x/50).^2);
end

%initialize mat
x1=-40:60;
count=length(x1);
sz=size(x1);
y1=zeros(sz);v1=zeros(sz); theta1=zeros(sz);
yp1=zeros(sz);ypp1=zeros(sz);rho1=zeros(sz); gforce=zeros(sz);
dist1=zeros(sz); gtan=zeros(sz);

%populate mat
for i=1:count
    y1(i)=vpa(subs(y,x,x1(i)));
    v1(i)=vpa(subs(v,h,y1(i)));
    yp1(i)=vpa(subs(yp,x,x1(i)));
    ypp1(i)=vpa(subs(ypp,x,x1(i)));
    rho1(i)=((1+yp1(i)^2)^(3/2))/(abs(ypp1(i)));
    theta1(i)=90-abs(atand(yp1(i)));
    gforce(i)=round(v1(i)^2/g/rho1(i)-sind(theta1(i)),10);
    dist1(i)=integral(@dist,-40,x1(i));
    gtan(i)=cosd(theta1(i));
end
glat=x1*0;

%plot
figure
sgtitle('Parabola G-Forces')
subplot(3,1,1);

plot(dist1,gforce,'b',LineWidth=1.5);
xlim([0,dist1(end)])
ylim([-2,7])
yline(6,'r')
yline(-1,'r')
title('Normal G-Forces vs. Distance')
xlabel('Distance (m)')
ylabel('G-Force')

subplot(3,1,2);
plot(dist1,glat,'b',LineWidth=1.5);
xlim([0,dist1(end)])
ylim([-2,7])
yline(6,'r')
yline(-1,'r')
title('Lateral G-Forces vs. Distance')
xlabel('Distance (m)')
ylabel('G-Force')

subplot(3,1,3);
plot(dist1,gtan,'b',LineWidth=1.5);
xlim([0,dist1(end)])
ylim([-2,7])
yline(6,'r')
yline(-1,'r')
title('Tangential G-Forces vs. Distance')
xlabel('Distance (m)')
ylabel('G-Force')

print('parabola_gforces_2803_lab1','-dpng','-r300')