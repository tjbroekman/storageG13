% Code by Mark Weijers 
% m.j.weijers@tudelft.nl
% for use in Necessity of Storage course of FM Mulder 2022
% refer to authors if used.

%% Writes the CONSUMPTION.xlsx data using a given time span
%using the formulas from prof. Mulder's paper.

t=[0:(1/(24*4)):365]'; %every 15 minutes a time stamp is made.
t_alt=@(t) (t- floor(t))*24; % every day there is an alternative day with hours in h
%% Determination of the primary energy consumed in the scenario no green policies.

%%%Determination of the primary energy needed during summer and winter

%%%Utilisation of the formula given in supplementary information of Mulder's
%%%paper
% Netherlands:
P2022 = 3023;   % In PJ, in 2021
P2022 = P2022 * 277.777778; % In GWh, to have the common SI unit.
fprintf('%d GWh average hourly use', P2022/365/24);

P_summer =@(t) (1/457564.55381) * ...
    (10 +  (5.5./(1+0.35*(t_alt(t).^2)))  +  ...
    32*exp(-(t_alt(t)-8.97).^(4)./4.5^2) +...
    26.9*exp(-(t_alt(t)-12.5).^(4)./2.9^2)  +...
    29.7*exp(-(t_alt(t)-15.7).^(4)./3.0^2)  + ...
    13.7*exp(-(t_alt(t)-18.95).^(4)./3.4^2)  + ...
    7.9*exp(-(t_alt(t)-22.3).^(4)./4.1^2) );

%Primary energy use winter
P_winter =@(t) (1/852229.6113) * ...
    (30 + 1.8./(1+0.35*(t_alt(t).^2)) + ...
    46.7*exp(-(t_alt(t)-8.8).^4./3.9^2) + ... 
    32.5*exp(-(t_alt(t)-12.26).^4./3.2^2) + ...
    32.2*exp(-(t_alt(t)-15.5).^4./3.0^2) + ...
    10.2*exp(-(t_alt(t)-18.95).^4./3.4^2) + ...
    5.9*exp(-(t_alt(t)-22.3).^4./4.1^2));

%Primary energy use variation
A =@(t) (1 + 0.075 * cos(4*pi*(t - 217)/365)) .* (1 - 0.045 * cos(2*pi*(t - 217)/365));

%Primary energy use total
Primary =@(t) P2022 /365 * ((P_summer(t).*(0.5+0.5*cos(2*pi*(t-172)/365)) + ...
          P_winter(t).*(0.5-0.5*cos(2*pi*(t-172)/365)))).*A(t);
FIT=integral(@(t) Primary(t),0,365);
CONSUMPTION= [Primary(t)*2/3 Primary(t)*1/3 ]*P2022/24/FIT;
% Two nodes: Amsterdam and Groningen. Equal energy.
xlswrite(fileConsumption,[t CONSUMPTION],sheetnameConsumption);
clear time P2022 A Primary P_Winter P_Summer t t_alt