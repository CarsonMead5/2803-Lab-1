%% Full Rollercoaster Main Function

clear; close all; clc;

%% General Setup

inc = 0.01; % increment of arc length (m)
h_0 = 125; % start height of coaster (m)
g = 9.81; % gravitational acceleration (m/s^2)

% Initializing Maximum G Thresholds
Gmax.forward = 5;
Gmax.back = 4;
Gmax.up = 6;
Gmax.down = 1;
Gmax.lat = 3;


%% Section 1: Transition 1 (Carson)

[t1.Gnorm,t1.Glat,t1.Gtan,t1.s] = coaster_t1(h_0,inc);

tot.s = t1.s;

%% Section 2: Loop (Carson)

l.r = 15; % radius of loop (m)
l.loop_height = 105; % height of center of loop off of the ground (m)

[l.Gnorm,l.Glat,l.Gtan,l.s] = coaster_loop(h_0,l.r,l.loop_height,inc); % Calls loop function

tot.s = [tot.s,(l.s + tot.s(end) + inc)]; % Concatenates arc length vector w/ previous

%% Section 3: Transition 2

[t2.Gnorm,t2.Glat,t2.Gtan,t2.s] = coaster_t2(h_0,g,inc);

tot.s = [tot.s, (t2.s + tot.s(end) + inc)]; % Concatenates arc length vector w/ previous

%% Section 4: 0G Parabola

p.x_0 = 142.412;
p.z_0 = 111.8669;
p.slope_i = 0.8;
p.x_end = 201.5485;

[p.Gnorm,p.Glat,p.Gtan,p.s,p.x_end,p.s_end,p.z_end,p.dydx_end] = coaster_parabola(g,h_0,p.x_0,p.z_0,p.slope_i,inc,p.x_end);

tot.s = [tot.s, (p.s + tot.s(end) + inc)]; % Concatenates arc length vector w/ previous

%% Section 5: Transition 3

% [t3.Gnorm,t3.Glat,t3.Gtan,t3.s] = coaster_t3();

% tot.s = [tot.s, (t3.s + tot.s(end) + inc)]; % Concatenates arc length vector w/ previous

%% Section 6: Banked Turn

bt.lengthBT = 100; % m
bt.height = 0; % m

[bt.Gnorm,bt.Glat,bt.Gtan,bt.s] = coaster_bankedturn(bt.lengthBT,h_0,bt.height,inc);

tot.s = [tot.s, (bt.s + tot.s(end) + inc)]; % Concatenates arc length vector w/ previous

%% Section 7: Braking Section

[bs.Gnorm,bs.Glat,bs.Gtan,bs.s] = coaster_brakingsection(h_0,inc);

tot.s = [tot.s, (bs.s + tot.s(end) + inc)]; % Concatenates arc length vector w/ previous

%% Concatenating G-Force Vectors

% % Concatenates Normal G-Force Vectors
% tot.Gnorm = [t1.Gnorm,l.Gnorm,t2.Gnorm,p.Gnorm,t3.Gnorm,bt.Gnorm,bs.Gnorm];
% 
% % Concatenates Lateral G-Force Vectors
% tot.Glat = [t1.Glat,l.Glat,t2.Glat,p.Glat,t3.Glat,bt.Glat,bs.Glat];
% 
% % Concatenates Tangential G-Force Vectors
% tot.Gtan = [t1.Gtan,l.Gtan,t2.Gtan,p.Gtan,t3.Gtan,bt.Gtan,bs.Gtan];

%% Checking if G-Force Exceeds Limits

% for i = 1:length(tot.Gnorm)
%     if (tot.Gnorm(i) <= -Gmax.down) || (tot.Gnorm(i) >= Gmax.up)
%         disp("ERROR : G-Forces Exceed Thresholds in Normal Direction")
%         break;
%     end
% end
% 
% for i = 1:length(tot.Glat)
%     if (tot.Glat(i) <= -Gmax.lat) || (tot.Glat(i) >= Gmax.lat)
%         disp("ERROR : G-Forces Exceed Thresholds in Lateral Direction")
%         break;
%     end
% end
% 
% for i = 1:length(tot.Gtan)
%     if (tot.Gtan(i) <= -Gmax_back) || (tot.Gtan(i) >= Gmax.forward)
%         disp("ERROR : G-Forces Exceed Thresholds in Tangential Direction")
%         break;
%     end
% end

%% Checking if Track Exceeds Length Limits

% max_length = 1250; % max length of track
% 
% if tot.s(end) > max_length
% 
%         disp("ERROR : Track Exceeds Length Threshold")
% 
% end

%% Plotting G-Force Vs Arc Length

% hold on
% plot(tot.s,tot.Gnorm,'r')
% plot(tot.s,tot.Glat,'b')
% plot(tot.s,tot.Gtan,'g')
% hold off
% title("G-Force vs. Arc Length")
% legend("Normal G-Force","Lateral G-Force","Tangential G-Force")

%% Plot 3D Map of Rollercoaster

plot3dcoaster(h_0,inc);
