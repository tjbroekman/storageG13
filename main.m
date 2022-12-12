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
fileConsumption='CONSUMPTION.xlsx'; %give local file name
sheetnameConsumption='Sheet1'; %probable name

% Meta data input META.xlsx consists of:
% producers p1, p2, p3 etc. of which the maximum capacity, location and
% production type is defined.
% consumers c1, c2, etc. of which the location is defined.
% transport efficiency t1, by which the loss of electricity transport is
% calculated.
fileMeta='META.xlsx';
sheetnameMeta='Sheet1'; %probable name

%% OPTIONAL
%Optional: write a consumers profile on the basis of Mulder paper.
writeConsumers

%% LOAD DATA
%% Load consumer data:
% Make a file with column 1 time data, column 2, 3, and further consumption data
% more columns can be used to generate spatial model. Define location in
% META under c1, c2, etc. for each column supplied.
[consData,consTxt,]= xlsread([fileLocation fileConsumption],sheetnameConsumption);
E_c=consData(:,2:end); %second column and further
t=consData(:,1); %first column and further
clear consData consTxt

%% Load meta file:
% The meta file loads producers and consumers information. Producers p have
% the following format: p1, p2, p3 and are loaded in a structured array
% like Producers.capacity=[capacity p1; capacity p2 etc];
[metaNum,metaTxt,]= xlsread([fileLocation fileMeta],sheetnameMeta);
[Consumers, Producers, Transport, Constant]=loadMeta(metaNum,metaTxt);
clear metaNum metaTxt

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

Output=0; %Output variable suppresses making graphs.
for i=1:50 %Break either if mismatch is low or if counter is finished
    % Variables of the residuals are given. Consumption residuals E_cres
    % and production residuals E_pres. 
    [E_cres, E_pres, Transport]=EPACE(E_c,t,Consumers,Producers,Transport,Constant,Output);

    %Evaluation of mismatch:
    Mismatch=sum(sum(E_cres))-sum(sum(E_pres)) % Net shortage of energy per year
    MisPerc=Mismatch./((365*24)*(sum(Producers.capacity))); % Net shortage percentage of energy
    % The producing capacity is increased by a factor (100% + mismatch percentage). 
    Producers.capacity=Producers.capacity*(1+MisPerc/size(Producers.capacity,2));
    if abs(Mismatch)<1 % 1 is arbitrary, choose a better value.
        break
    end
end

%% print a summary:
Output=1;
EPACE(E_c,t,Consumers,Producers,Transport,Constant,Output);
