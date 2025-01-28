%% Full Rollercoaster Main Function


%% General Setup

inc = 0.01; % increment of arc length (m)
h_0 = 125; % start height of coaster (m)

%% Section 1: Transition 1

% [Gnorm_t1,Glat_t1,Gtan_t1,s_t1] = coaster_t1();
% 
% s_tot = s_t1;

%% Section 2: Loop

r_l = 10; % radius of loop (m)
loop_height = 110; % height of center of loop off of the ground (m)

[Gnorm_l,Glat_l,Gtan_l,s_l] = coaster_loop(h_0,r_l,loop_height,inc); % Calls loop function

s_tot = s_tot + (s_l + s_tot(end) + inc); % Concatenates arc length vector w/ previous

%% Section 3: Transition 2

% [Gnorm_t2,Glat_t2,Gtan_t2,s_t2] = coaster_t2();

% s_tot = s_tot + (s_t2 + s_tot(end) + inc); % Concatenates arc length vector w/ previous

%% Section 4: 0G Parabola

% [Gnorm_p,Glat_p,Gtan_p,s_p] = coaster_parabola();

% s_tot = s_tot + (s_p + s_tot(end) + inc); % Concatenates arc length vector w/ previous

%% Section 5: Transition 3

% [Gnorm_t3,Glat_t3,Gtan_t3,s_t3] = coaster_t3();

% s_tot = s_tot + (s_t3 + s_tot(end) + inc); % Concatenates arc length vector w/ previous

%% Section 6: Banked Turn

% [Gnorm_bt,Glat_bt,Gtan_bt,s_bt] = coaster_bankedturn();

% s_tot = s_tot + (s_bt + s_tot(end) + inc); % Concatenates arc length vector w/ previous

%% Section 7: Transition 4

% [Gnorm_t4,Glat_t4,Gtan_t4,s_t4] = coaster_t4();

% s_tot = s_tot + (s_t4 + s_tot(end) + inc); % Concatenates arc length vector w/ previous

%% Section 8: Braking Section

% [Gnorm_bs,Glat_bs,Gtan_bs,s_bs] = coaster_breakingsection();

% s_tot = s_tot + (s_bs + s_tot(end) + inc); % Concatenates arc length vector w/ previous

%% Concatenating G-Force Vectors

% % Concatenates Normal G-Force Vectors
% Gnorm_tot = [Gnorm_t1,Gnorm_l,Gnorm_t2,Gnorm_p,Gnorm_t3,Gnorm_bt,Gnorm_t4,Gnorm_bs];
% 
% % Concatenates Lateral G-Force Vectors
% Glat_tot = [Glat_t1,Glat_l,Glat_t2,Glat_p,Glat_t3,Glat_bt,Glat_t4,Glat_bs];
% 
% % Concatenates Tangential G-Force Vectors
% Gtan_tot = [Gtan_t1,Gtan_l,Gtan_t2,Gtan_p,Gtan_t3,Gtan_bt,Gtan_t4,Gtan_bs];

%% Checking if G-Force Exceeds Limits

% Setting maximum thresholds
Gmax_forward = 5;
Gmax_back = 4;
Gmax_up = 6;
Gmax_down = 1;
Gmax_lat = 3;

% for i = 1:length(Gnorm_tot)
%     if (Gnorm_tot(i) <= -Gmax_down) || (Gnorm_tot(i) >= Gmax_up)
%         disp("ERROR : G-Forces Exceed Thresholds in Normal Direction")
%         break;
%     end
% end
% 
% for i = 1:length(Glat_tot)
%     if (Glat_tot(i) <= -Gmax_lat) || (Glat_tot(i) >= Gmax_lat)
%         disp("ERROR : G-Forces Exceed Thresholds in Lateral Direction")
%         break;
%     end
% end
% 
% for i = 1:length(Gtan_tot)
%     if (Gtan_tot(i) <= -Gmax_back) || (Gtan_tot(i) >= Gtan_forward)
%         disp("ERROR : G-Forces Exceed Thresholds in Tangential Direction")
%         break;
%     end
% end

%% Checking if Track Exceeds Length Limits

% max_length = 1250; % max length of track
% 
% if s_tot(end) > max_length
% 
%         disp("ERROR : Track Exceeds Length Threshold")
% 
% end

%% Plotting G-Force Vs Arc Length

% hold on
% plot(s_tot,Gnorm_tot,'r')
% plot(s_tot,Glat_tot,'b')
% plot(s_tot,Gtan_tot,'g')
% hold off
% title("G-Force vs. Arc Length")
% legend("Normal G-Force","Lateral G-Force","Tangential G-Force")
