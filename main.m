% Matlab energy modeling code
% Code by Mark Weijers 
% m.j.weijers@tudelft.nl
% for use in Necessity of Storage course of FM Mulder 2022
% refer to authors if used.
clear all
close all

%% LOCATIONS
fileLocation=''; % in case you save your excel files elsewhere
% Energy model input CONSUMPTION.xlsx consists of:
% A time vector t of n x 1,
% An energy consumption matrix E_c matrix of n x m with m types of
% consumers (e.g. different locations or different behavior).
%fileConsumption='CONSUMPTION.xlsx'; %give local file name
%sheetnameConsumption='Sheet1'; %probable name

% Meta data input META.xlsx consists of:
% producers p1, p2, p3 etc. of which the maximum capacity, location and
% production type is defined.
% consumers c1, c2, etc. of which the location is defined.
% transport efficiency t1, by which the loss of electricity transport is
% calculated.
fileMeta='META_final_WITH_storage.xlsx';
sheetnameMeta='Sheet1';

fileWind='Wind_distribution.xlsx';
sheetnameWind='Sheet1';

fileSolar='Solar_distribution.xlsx';
sheetnameSolar='Sheet1';

%Variable to determine if 70% limit in solar production is activated:
limit_solar = 0;

%% LOAD DATA
% Load meta file:
% The meta file loads producers and consumers information. Producers p have
% the following format: p1, p2, p3 and are loaded in a structured array
% like Producers.capacity=[capacity p1; capacity p2 etc];
[metaNum,metaTxt,]= xlsread([fileLocation fileMeta],sheetnameMeta);
[metaNum_example] =[metaNum];
[metaTxt_example] = [metaTxt];
[Consumers, Producers, Transport, Constant]=loadMeta(metaNum,metaTxt);

clear metaNum metaTxt

%% Load consumer data:
% Consumer data will be provided by the Consumerfunction, which will output
% directly a E_c matrix with the consumption values per timestep.
E_c=consumerFunction(Consumers);
t=[0:(1/96):365]';

%% Load Wind Data:
%Load the Wind Distribution information obtained for each wind farm
%location. It is a matrix of as many rows as timesteps and with columns =
%nº of locations.
Wind_distribution_ = xlsread([fileLocation fileWind],sheetnameWind);
Wind_distribution = Wind_distribution_ .^3;

%% Load Solar Weather Data:
%Load the Solar Distribution information obtained for each solar farm
%location. It is a matrix of as many rows as timesteps and with columns =
%nº of locations.
Solar_distribution = xlsread([fileLocation fileSolar],sheetnameSolar);

%% Central function:
%EPACE gives back the unmatched residual energies as function of time.
%Also the Transport matrix is filled in with where which energy is
%transported.

% Code is iterated until capacity of producers match the consumers.
% Storage efficiencies are not accounted yet: the iteration matches the 
% total year consumption with the total year production without storage
% losses. You will have to choose how to handle long and short term
% storage from these mismatch patterns, and correct for losses
% during storage.

Output=1; %Output variable suppresses making graphs.
[E_cres, E_pres, Transport, E_p_original]=EPACE(E_c,t,Consumers,Producers,Transport,Constant,Output,Wind_distribution,limit_solar,Solar_distribution);
for i=1:75 %Break either if mismatch is low or if counter is finished
    % Variables of the residuals are given. Consumption residuals E_cres
    % and production residuals E_pres. 
    [E_cres, E_pres, Transport, E_p]=EPACE(E_c,t,Consumers,Producers,Transport,Constant,Output,Wind_distribution,limit_solar,Solar_distribution);
    %Evaluation of mismatch:
    E_imbalance = EnergyImbalance (E_p,E_c);
    Mismatch=sum(sum(E_cres))-sum(sum(E_pres)) % Net shortage of energy per year
    Shortage_Total=shortageCalculation(E_imbalance)
        % MisPerc=Mismatch./((365*24)*(sum(Producers.capacity))); % Net shortage percentage of energy
          MisPerc=Shortage_Total/(365*24*(sum(Producers.capacity)))
    % The producing capacity is increased by a factor (100% + mismatch percentage). 
     Producers.capacity(1,1:23)= Producers.capacity(1,1:23)*(1.01+MisPerc/3); 
     %Only the first 23 producers are modified because the rest are hydro
     %and biomass plants with unchanging capacity. 
    % *It is dividing the shortage percentage by the number of producers.
    if shortageCalculation(E_imbalance)<1 % this value is arbitrary, just needs to be small.
        break
    end
end

[shortageSum,ST_storage,LT_storage] = shortageCalculation(E_imbalance);
LT_storage_max = max(LT_storage);

Storage_Output = 1;
    if Storage_Output == 1
        figure();
        plot(LT_storage);
        title("Longterm")
        figure();
        plot(ST_storage);
        title("Shortterm")
    end

%% print a summary:
Output=0;
[E_cres, E_pres, Transport, E_p_final] = EPACE(E_c,t,Consumers,Producers,Transport,Constant,Output,Wind_distribution,limit_solar,Solar_distribution);

%Extracting Useful information:
E_imbalance = EnergyImbalance (E_p_final,E_c);

%Total Energy Produced:
E_total=sum(E_p_final(:));

%Total Production Capacity:
Capacity_total = sum(Producers.capacity);

for i=1:size(Producers.type,1)
    string=Producers.type{i,1};
    coordinates_solar_1=Producers.coordinates(i,:);
end
E_p_frac_solar=solarFunction(t,coordinates_solar_1,Constant);


for i=1:size(Producers.type,1)
    string=Producers.type{i,1};
    coordinates=Producers.coordinates(i,:);
end

E_p_frac_wind=windFunction(t,Producers.coordinates(2,:));

