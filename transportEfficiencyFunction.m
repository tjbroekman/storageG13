function Efficiency=transportEfficiencyFunction(Transport,Consumers,Producers)
% Code by Mark Weijers 
% m.j.weijers@tudelft.nl
% for use in Necessity of Storage course of FM Mulder 2022
% refer to authors if used.

coordinates=unique([Consumers.coordinates; Producers.coordinates],'rows');
fprintf('There are %i unique locations \n', size(coordinates,1));

%Calculate transfer efficiency between every consumer and producer:
% Currently only an AC line is included as mode of transport:
% Transport equation eff_total=eff^(distance)
Efficiency=zeros(size(Producers.coordinates,1),size(Consumers.coordinates,1));
for i=1:size(Producers.coordinates,1)
    for j=1:size(Consumers.coordinates,1)
         Efficiency(i,j)=Transport.conversionEfficiency^2*Transport.efficiency^...
             (distanceFunction(Producers.coordinates(i,:),...
             Consumers.coordinates(j,:))/1000);
    end
end
end