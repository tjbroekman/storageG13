function [E_cres,E_pres,Transport]=mismatchFunction(E_p,E_c,Efficiency,Transport)
% Code by Mark Weijers 
% m.j.weijers@tudelft.nl
% for use in Necessity of Storage course of FM Mulder 2022
% refer to authors if used.

%% CODE DOES NOT WORK FOR NODES AT EXACT SAME LOCATION (YET)
%E_pres is the energy produced (E_p) after substracting the energy transported to the node. 
%E_cres is the energy that the consumer still needs after being supplied
%(it will be positive if the energy produced wasn't enough)


EfficiencySorted=sort(unique(Efficiency(:)),"descend");
E_pres=E_p; %Residual fraction of energy produced
E_cres=E_c; %Residual fraction of energy necessary
for i=1:size(EfficiencySorted,1)
        %Allocate for every efficiency the transport line used:
    transportLine=(Efficiency==EfficiencySorted(i));
    %Store transport information:
    [Transport.line(i).producerNumber Transport.line(i).consumerNumber val]=...
        find(transportLine);
    %First look up if the energy can be allocated to first up most
    %efficient end user:
    E_M=E_cres - E_pres*(Efficiency.*transportLine);
    %Net energy need is never negative:
    E_M(E_M<0)=0; %If E_M is negative, it will be zero. 
    % Consumer energy takeup from this transport line is saved to back 
    % calculate the usage:
    Transport.line(i).Energy_used_by_node=E_cres-E_M;  
    %New E_p matrix is made:
    %Back calculate the residuals of the producer:
    Transport.line(i).Energy_supplied_by_node=Transport.line(i).Energy_used_by_node*transportLine'*(EfficiencySorted(i));
    E_pres=E_pres-Transport.line(i).Energy_supplied_by_node;
    %Now the consumer residual need is calculated:
    E_cres=E_M;
end
end