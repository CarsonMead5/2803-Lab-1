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
G_forewards = 0 * ones(size(path_length));
G_normal = 0 * ones(size(path_length));
G_backwards = (a_maxb / g) * ones(size(path_length)); % constant backward G's
G_lateral = 0 * ones(size(path_length));

% Create figure and subplots
figure;

% Create the subplot for Backward G's during the braking section
subplot(4,2,1);
plot(path_length, G_forewards, 'k', 'LineWidth', 2);
yline(5, 'r--', 'LineWidth', 1);
title('Forewards Gs During Braking Section');
xlabel('Path Length along Track (m)');
ylabel('Forewards Gs (g)');
xlim([0 30]);
ylim([0 6]); 
legend('Gs experienced','Gs limit')
grid on;

subplot(4,2,2);
plot(path_length, G_backwards, 'k', 'LineWidth', 2);
yline(4, 'r--', 'LineWidth', 1);
title('Backwards Gs During Braking Section');
xlabel('Path Length along Track (m)');
ylabel('Backwards Gs (g)');
xlim([0 30]);
ylim([0 6]); 
legend('Gs experienced','Gs limit')
grid on;

subplot(4,2,3);
plot(path_length, G_lateral, 'k', 'LineWidth', 2);
yline(3, 'r--', 'LineWidth', 1);
title('Lateral Gs During Braking Section');
xlabel('Path Length along Track (m)');
ylabel('Lateral Gs (g)');
xlim([0 30]);
ylim([0 6]);
legend('Gs experienced','Gs limit')
grid on;

subplot(4,2,4);
plot(path_length, G_normal, 'k', 'LineWidth', 2);
yline(6, 'r--', 'LineWidth', 1);
title('Normal Gs During Braking Section');
xlabel('Path Length along Track (m)');
ylabel('Normal Gs (g)');
xlim([0 30]);
ylim([0 6]);
legend('Gs experienced','Gs limit')
grid on;




% Formatting
sgtitle('G-Forces during Braking Section');

% Display the figure
figure(gcf);