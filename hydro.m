%% Define the time intervals (in minutes)
interval = 15;

%% Define the start and end times of the data
start_time = datetime(2022,1,1,0,0,0);
end_time = datetime(2023,1,1,0,0,0);

%% Create a vector of time intervals
time_vector = start_time:minutes(interval):end_time;

%% Initialize variables to store the energy output and power
energy_output = zeros(size(time_vector));
power = zeros(size(time_vector));

%% Assume flow rate, head and efficiency are constant
%flow_rate = 1000; % cubic meters per second
%head = 100; % meters
efficiency = 0.9;

% Loop through the time intervals
for i = 1:length(time_vector)
    % Calculate the power at each time step
    %power(i) = flow_rate * head * efficiency;
    power(i) = 180;
    % Calculate the energy output at each time step
    energy_output(i) = power(i) * interval;
end

%% Plot the energy output over time
figure
plot(time_vector, energy_output)
xlabel('Time')
ylabel('Energy Output (GW)')
title('Energy Output of Hydroelectric Power Plant')

