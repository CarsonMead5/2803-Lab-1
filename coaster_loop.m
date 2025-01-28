%% Calculating G Forces around a Roller Coaster Loop
function [Gnorm,Glat,Gtan,s_l] = coaster_loop(h_0,r,loop_height,inc)

    s_l = 0:inc:2*pi*r; % Increments of 0.01 m of arc length

% Calculating G-Force
    Gnorm = 2*(h_0-loop_height)/r + 3*cos(s_l/r);
    Glat = 0*s_l;
    Gtan = -sin(s_l/r);

end