function [E_imbalance]= EnergyImbalance(E_p,E_c)
% First aim is to calculate the daily difference between energy produced
% and energy demanded by the consumer. Previous to the losses of
% transport. 

%We obtain the total production of energy from the producers (per timestep):
E_p_total = sum(E_p,2);

%We obtain the total energy demanded by the consumers (per timestep):
E_c_total = sum(E_c,2);

E_imbalance = E_p_total - E_c_total;

end