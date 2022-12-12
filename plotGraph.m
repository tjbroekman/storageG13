function plotGraph(t,E_c,E_p,E_cres,E_pres,Consumers,Producers,Transport)
% Code by Mark Weijers 
% m.j.weijers@tudelft.nl
% for use in Necessity of Storage course of FM Mulder 2022
% refer to authors if used.

%% Energy mismatch, totals:
figure(1)
subplot(2,1,1)
hold on
plot(t,E_c,'*')
plot(t,E_p)
xlabel('time (days)')
ylabel('Energy (GW)')
title('Total Energy Consumption (*) and Production');
for i=1:size(Consumers.coordinates,1)
    leg{i}=sprintf('Consumer %i');
end
j=1;
for i=(size(Consumers.coordinates,1)+1):(size(Producers.coordinates,1)+size(Consumers.coordinates,1))
    leg{i}=sprintf('Producer %i, %s', j, Producers.type{j});
    j=j+1;
end
legend(leg);

subplot(2,1,2)
hold on
plot(t,E_cres,'*')
plot(t,E_pres)
xlabel('time (days)')
ylabel('Energy (GW)')
title('Residuals of energy consumption (*) and production')
for i=1:size(Consumers.coordinates,1)
    leg{i}=sprintf('Consumer %i');
end
j=1;
for i=(size(Consumers.coordinates,1)+1):(size(Producers.coordinates,1)+size(Consumers.coordinates,1))
    leg{i}=sprintf('Producer %i, %s', j, Producers.type{j});
    j=j+1;
end
legend(leg);

figure(2)
hold on
for i=1:size(Transport.line,2)
    plot(t,sum(Transport.line(i).Energy_used_by_node,2));
    leg{i}=sprintf('Producer %i Consumer %i',Transport.line(i).producerNumber,Transport.line(i).consumerNumber);
end
legend(leg)
title('Node transport analysis')
xlabel('time (days)')
ylabel('Effective energy transported through node (GW)')

end