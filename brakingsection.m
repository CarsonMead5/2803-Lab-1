clc
clear
close all

% Define parameters
v0 = 50; % initial velocity in m/s 
vf = 0; % final velocity in m/s
height_initial = 0;
height_final = 0;

a_maxb = 39.24;% maximum backward acceleration in m/s^2
db = (v0^2) / (2 * (a_maxb)); % distance traveled during braking
g = 9.81; % gravitational acceleration in m/s^2

% Calculate position along the braking section
path_length = linspace(0, db, 100); % path length from 0 to db
G_lateral = 0 * ones(size(path_length));
G_updown = 0 * ones(size(path_length));
G_backwards = (a_maxb / g) * ones(size(path_length)); % constant backward G's


% Create figure and subplots
figure;

% Create the subplot for Backward G's during the braking section
subplot(3,1,1);
plot(path_length, G_lateral, 'k', 'LineWidth', 2);
title('Lateral Gs During Braking Section');
xlabel('Path Length along Track (m)');
ylabel('Lateral G (g)');
ylim([-5 5]); % G limits
grid on;

subplot(3,1,2);
plot(path_length, G_updown, 'k', 'LineWidth', 2);
title('Up/Down Gs During Braking Section');
xlabel('Path Length along Track (m)');
ylabel('Up/Down G (g)');
ylim([-5 5]); % G limits
grid on;

subplot(3,1,3);
plot(path_length, G_backwards, 'k', 'LineWidth', 2);
title('Backward Gs During Braking Section');
xlabel('Path Length along Track (m)');
ylabel('Backward G (g)');
ylim([0 10]); % G limits
grid on;


% Formatting
sgtitle('G-Forces during Braking Section');

% Display the figure
figure(gcf);