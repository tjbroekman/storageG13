function [E_cres, E_pres, Transport, E_p]=EPACE(E_c,t,Consumers,Producers,Transport,Constant,Output,Wind_distribution,limit_solar)

%% EPACE Energy Production And Consumption Equilibration
% Code by Mark Weijers 
% m.j.weijers@tudelft.nl
% for use in Necessity of Storage course of FM Mulder 2022
% refer to authors if used.

%% Producer matrix buildup
% E_p=producerFunction(t,[coordinates])
% Task: fill in solarFunction, windFunction, biomass function
% Constraints:
% input data is time and location data (deg latitude, longitude)
% output data is n x 1 with n is size of vector t.
% for ease: @ makes a handle which can be given to the main function.
solar=@solarFunction;
wind=@windFunction;
biomass=@biomassFunction;
E_p=producerFunction(t,Producers,Constant,solar,wind,biomass,Wind_distribution,limit_solar);

%% Calculate transport efficiencies between users and producers:
%Output matrix gives energy efficiency from producers (rows) to consumers
%(columns).
%Task: check distanceFunction, output in km;
%Task: make multiple modes of transport possible
Efficiency=transportEfficiencyFunction(Transport,Consumers,Producers);

%% E_m= % function calls: minimization problem of energy consumers and producers
% Calculate mismatch between producing and consuming nodes:
% Final function:
% E_m = E_c - Ep * efficiency * transfer fraction

% Approach: Transport between nodes with low energy losses are first fully used. 
% Per time stamp the residuals are calculated. 
% Producers from which lowest transport efficiencies are expected therefore
% contains the surplus energy.
[E_cres,E_pres,Transport]=mismatchFunction(E_p,E_c,Efficiency,Transport);
if Output==1
    plotGraph(t,E_c,E_p,E_cres,E_pres,Consumers,Producers,Transport)
end

end

