function [E_c]=consumerFunction(Consumers)
% Code by Mark Weijers 
% m.j.weijers@tudelft.nl
% for use in Necessity of Storage course of FM Mulder 2022
% refer to authors if used.

% Energy Consumer type and location, together with time stamp is converted
% to time and location dependant energy demand profile.
% Profiles: residential, commercial, transport, industry
% The units used in the META file should be GW (or GWh/h), obtained as an
% average of the year. 
%dt=t(2)-t(1);
t=[0:(1/96):365]'; %every 15 minutes a time stamp is made.
t_alt=@(t) (t- floor(t))*24; % every day there is an alternative day with hours in h
E_c=[]; %The matrix could be created with the size it will have to optimize this. 



%Primary energy use summer
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

%The plan is to avoid using a separate excel file. But in case it needs to
%be used:
%xlswrite(fileConsumption,[t CONSUMPTION],sheetnameConsumption);
%For matrix shifting: https://www.mathworks.com/help/matlab/ref/circshift.html

demand_profile = 0; %Auxiliary variable

for i=1:size(Consumers.type,1)
    string=Consumers.type{i,1};
    coordinates=Consumers.coordinates(i,:);
    switch string
        
        case{'residential_-5'}
            demand_profile=@(t) Consumers.capacity(i)*24*((P_summer(t).*(0.5+0.5*cos(2*pi*(t-172)/365)) + ...
          P_winter(t).*(0.5-0.5*cos(2*pi*(t-172)/365)))).*A(t);
            FIT=integral(@(t) demand_profile(t),0,365);
            E_c(:,i) = demand_profile(t)*Consumers.capacity(i)*365/4/FIT;
%After obtaining the demand in UTC_0, the function circshift
%will displace all the values in the chosen dimension. In this
%case, it must go backwards 5 hours, so 20 timesteps. 
            E_c(:,i) = circshift(E_c(:,i), (4*(-5)), 1);

        case{'residential_-6'}
            demand_profile=@(t) Consumers.capacity(i)*24*((P_summer(t).*(0.5+0.5*cos(2*pi*(t-172)/365)) + ...
          P_winter(t).*(0.5-0.5*cos(2*pi*(t-172)/365)))).*A(t);
            FIT=integral(@(t) demand_profile(t),0,365);
            E_c(:,i) = demand_profile(t)*Consumers.capacity(i)*365/4/FIT;   
            E_c(:,i) = circshift(E_c(:,i), (4*(-6)), 1);

        case{'residential_-7'}
            demand_profile=@(t) Consumers.capacity(i)*24*((P_summer(t).*(0.5+0.5*cos(2*pi*(t-172)/365)) + ...
          P_winter(t).*(0.5-0.5*cos(2*pi*(t-172)/365)))).*A(t);
            FIT=integral(@(t) demand_profile(t),0,365);
            E_c(:,i) = demand_profile(t)*Consumers.capacity(i)*365/4/FIT;
            E_c(:,i) = circshift(E_c(:,i), (4*(-7)), 1);

        case{'residential_-8'}
            demand_profile=@(t) Consumers.capacity(i)*24*((P_summer(t).*(0.5+0.5*cos(2*pi*(t-172)/365)) + ...
          P_winter(t).*(0.5-0.5*cos(2*pi*(t-172)/365)))).*A(t);
            FIT=integral(@(t) demand_profile(t),0,365);
            E_c(:,i) = demand_profile(t)*Consumers.capacity(i)*365/4/FIT;   
            E_c(:,i) = circshift(E_c(:,i), (4*(-8)), 1);

        case{'commercial_-5'}
            demand_profile=@(t) Consumers.capacity(i)*24*((P_summer(t).*(0.5+0.5*cos(2*pi*(t-172)/365)) + ...
          P_winter(t).*(0.5-0.5*cos(2*pi*(t-172)/365)))).*A(t);
            FIT=integral(@(t) demand_profile(t),0,365);
            E_c(:,i) = demand_profile(t)*Consumers.capacity(i)*365/4/FIT;   
            E_c(:,i) = circshift(E_c(:,i), (4*(-5)), 1);
        
        case{'commercial_-6'}
            demand_profile=@(t) Consumers.capacity(i)*24*((P_summer(t).*(0.5+0.5*cos(2*pi*(t-172)/365)) + ...
          P_winter(t).*(0.5-0.5*cos(2*pi*(t-172)/365)))).*A(t);
            FIT=integral(@(t) demand_profile(t),0,365);
            E_c(:,i) = demand_profile(t)*Consumers.capacity(i)*365/4/FIT;   
            E_c(:,i) = circshift(E_c(:,i), (4*(-6)), 1);

        case{'commercial_-7'}
            demand_profile=@(t) Consumers.capacity(i)*24*((P_summer(t).*(0.5+0.5*cos(2*pi*(t-172)/365)) + ...
          P_winter(t).*(0.5-0.5*cos(2*pi*(t-172)/365)))).*A(t);
            FIT=integral(@(t) demand_profile(t),0,365);
            E_c(:,i) = demand_profile(t)*Consumers.capacity(i)*365/4/FIT;
            E_c(:,i) = circshift(E_c(:,i), (4*(-7)), 1);

        case{'commercial_-8'}
            demand_profile=@(t) Consumers.capacity(i)*24*((P_summer(t).*(0.5+0.5*cos(2*pi*(t-172)/365)) + ...
          P_winter(t).*(0.5-0.5*cos(2*pi*(t-172)/365)))).*A(t);
            FIT=integral(@(t) demand_profile(t),0,365);
            E_c(:,i) = demand_profile(t)*Consumers.capacity(i)*365/4/FIT;   
            E_c(:,i) = circshift(E_c(:,i), (4*(-8)), 1);

        otherwise
            E_c(:,i)=ones(size(t,1),1)*Consumers.capacity(i)/4;
    end
end
end
