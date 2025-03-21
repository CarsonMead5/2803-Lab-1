%Lab 1, ASEN 2803-004, Group 4-10, Armand Etchen, 107290116, MOD 10FEB2025
%3D scatter plot of whole roller coaster. Colormap shown for velocity

%TEMP: USING PLACEHOLDER FOR TRANSITION AFTER PARABOLA

%cleaning
close all
clear
clc

%const
inc=0.1;

%t1 first circle
x1_1_start=0;
x1_1_end=27.27;
x1_1=x1_1_start:inc:x1_1_end;
z1_1=sqrt(900-x1_1.^2)+95;


%t1 second circle
x1_2_start=x1_1_end;
x1_2_end=54.54;
x1_2=x1_2_start:inc:x1_2_end;
z1_2=-sqrt(900-(x1_2-2*sqrt(743.75)).^2)+120;

xtot=[x1_1, x1_2];
ytot=zeros(size(xtot));
ztot=[z1_1, z1_2];

%t2 flat
x2_start=x1_2_end;
x2_end=60;
x2=x2_start:inc:x2_end;
y2=0.*x2;
z2=90+y2;

xtot=[xtot, x2];
ytot=zeros(size(xtot));
ztot=[ztot, z2];

%loop
xloop_start=60;
xloop_end=xloop_start;
rloop=15;
incloop=1000;
xloop=linspace(xloop_start-rloop,xloop_end+rloop,incloop);
zloop_1=sqrt(rloop.^2-(xloop-60).^2)+105;
zloop_2=-sqrt(rloop.^2-(xloop-60).^2)+105;
xloop=[xloop, xloop];
zloop=[zloop_1,zloop_2];

xtot=[xtot, xloop];
ytot=zeros(size(xtot));
ztot=[ztot, zloop];

%t3 flat
x3_start=xloop_start;
x3_end=80;
x3=x3_start:inc:x3_end;
y3=zeros(size(x3));
z3=y3+90;

xtot=[xtot, x3];
ytot=zeros(size(xtot));
ztot=[ztot, z3];

%t4 circle
x4_start=x3_end;
x4_end=142.412;
x4=x4_start:inc:x4_end;
y4=zeros(size(x4));
z4=-sqrt(100.^2-(x4-80).^2)+190;

xtot=[xtot, x4];
ytot=zeros(size(xtot));
ztot=[ztot, z4];

%parabola

xparabola_start=x4_end;
xparabola_end=201.5485;
xparabola=xparabola_start:inc:xparabola_end;
yparabola=xparabola*0;
zparabola=-4.905*((xparabola-142.412)/12.53462).^2 + 10.02770*((xparabola-142.142)/12.53462) + 111.8669;

xtot=[xtot, xparabola];
ytot=zeros(size(xtot));
ztot=[ztot, zparabola];

%t5a PLACEHOLDER

x_t5a_start=201.5485;
x_t5a_end=251.5485;
x_t5a=x_t5a_start:inc:x_t5a_end;
y_t5a=zeros(size(x_t5a));
z_t5a=linspace(50,0,length(x_t5a));

%t5b PLACEHOLDER
x_t5b_start=251.5485;
x_t5b_end=276.5485;
x_t5b=x_t5b_start:inc:x_t5b_end;
y_t5b=zeros(size(x_t5b));
z_t5b=y_t5b;

xtot=[xtot, x_t5a, x_t5b];
ytot=[ytot, y_t5a, y_t5b];
ztot=[ztot, z_t5a, z_t5b];

%banked turn

vmax=49.5227;
theta=1.231; %rad
r=vmax^2/9.81*cot(theta); %88.3769m
%circle center (276.5485, 88.3760, 0)

xbt_start=276.5485;
xbt_end=xbt_start;
xbt_inc=10000;

ybt=linspace(0,176.777,xbt_inc);
xbt=sqrt(r.^2-(ybt-r).^2)+r+(276.5485-r);
zbt=zeros(1,xbt_inc);

xtot=[xtot, xbt];
ytot=[ytot, ybt];
ztot=[ztot, zbt];

%twisting line

xtwist_start=276.5485;
xtwist_end=251.5485;
xtwist=xtwist_start:-inc:xtwist_end;
ytwist=zeros(size(xtwist))+176.777;
ztwist=zeros(size(xtwist));

xtot=[xtot, xtwist];
ytot=[ytot, ytwist];
ztot=[ztot, ztwist];

%braking section

xbrake_start=251.5485;
xbrake_end=220.2985;
xbrake=xbrake_start:-inc:xbrake_end;
ybrake=zeros(size(xbrake))+176.777;
zbrake=zeros(size(xbrake));

xtot=[xtot, xbrake];
ytot=[ytot, ybrake];
ztot=[ztot, zbrake];

%velocity
v=sqrt(2*9.81*(125-ztot));

%recalculating braking section velocity
v(15023:end)=linspace(49.5227,0,313);

%3D plot
s=1;
c=ztot;
figure
scatter3(xtot,ytot,ztot,s,v);
colormap jet
title('3D Plot');
xlabel('x (m)');
ylabel('y (m)');
zlabel('z (m)');
h=colorbar;
h.Label.String='Speed (m/s)';

print('scatter3_2803_lab1','-dpng','-r300') %saves image file (png)