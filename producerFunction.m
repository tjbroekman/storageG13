function E_p=producerFunction(t,Producers,Constant,solar,wind,biomass,Wind_distribution,limit_solar,Solar_distribution)
% Code by Mark Weijers 
% m.j.weijers@tudelft.nl
% for use in Necessity of Storage course of FM Mulder 2022
% refer to authors if used.

% Energy producer type and location, together with time stamp is converted
% to time and location dependant energy profile.
dt=t(2)-t(1);
E_p=[];

%To determine the limit on solar production if curtailment is needed. 
production_limit = 0.7;

for i=1:size(Producers.type,1)
    string=Producers.type{i,1};
    coordinates=Producers.coordinates(i,:);
    switch string
        
        case{'solar'}
            %solar function gives variation as fraction of annual
            %generation (integral wind from 0 to 365 equals 1)
            E_p(:,i)=solar(t,coordinates,Constant)...
                *(Producers.capacity(i)*365/(1/(dt)/24));
            if limit_solar == 1
                 %Capacity is in GWh per h, so it must be divided by 4 for the maximum in a timestep
                max_production = Producers.capacity(i)/4;
                for j = 1:size(E_p,1)
                    if E_p(j,i) >= max_production*production_limit
                        E_p(j,i) = max_production*production_limit;
                    %The limit is imposed by the "production_limit"
                    %variable found outside the for loop. 
                    end
                end                  
            end

        case{'solar_1'}
            E_p(:,i)=solar(t,coordinates,Constant)...
                *(Producers.capacity(i)*365/(1/(dt)/24)).*Solar_distribution(:,1);
            %The Solar distribution matrix contains weather information
            %that provides variations for each timestep, to produce some
            %noise in the data. It is different for each location. 
            if limit_solar == 1
                 %Capacity is in GWh per h, so it must be divided by 4 for the maximum in a timestep
                max_production = Producers.capacity(i)/4;
                for j = 1:size(E_p,1)
                    if E_p(j,i) >= max_production*production_limit
                        E_p(j,i) = max_production*production_limit;

                    end
                end                  
            end

        case{'solar_2'}
            E_p(:,i)=(solar(t,coordinates,Constant)...
                *(Producers.capacity(i)*365/(1/(dt)/24))).*Solar_distribution(:,2); 
            if limit_solar == 1
                max_production = Producers.capacity(i)/4;
                for j = 1:size(E_p,1)
                    if E_p(j,i) >= max_production*production_limit
                        E_p(j,i) = max_production*production_limit;
                    end
                end                  
            end 

        case{'solar_3'}
            E_p(:,i)=(solar(t,coordinates,Constant)...
                *(Producers.capacity(i)*365/(1/(dt)/24))).*Solar_distribution(:,3); 
            if limit_solar == 1
                max_production = Producers.capacity(i)/4;
                for j = 1:size(E_p,1)
                    if E_p(j,i) >= max_production*production_limit
                        E_p(j,i) = max_production*production_limit;
                    end
                end                  
            end 

        case{'solar_4'}
            E_p(:,i)=(solar(t,coordinates,Constant)...
                *(Producers.capacity(i)*365/(1/(dt)/24))).*Solar_distribution(:,4); 
            if limit_solar == 1
                max_production = Producers.capacity(i)/4;
                for j = 1:size(E_p,1)
                    if E_p(j,i) >= max_production*production_limit
                        E_p(j,i) = max_production*production_limit;
                    end
                end                  
            end 

        case{'solar_5'}
            E_p(:,i)=(solar(t,coordinates,Constant)...
                *(Producers.capacity(i)*365/(1/(dt)/24))).*Solar_distribution(:,5); 
            if limit_solar == 1
                max_production = Producers.capacity(i)/4;
                for j = 1:size(E_p,1)
                   if E_p(j,i) >= max_production*production_limit
                        E_p(j,i) = max_production*production_limit;
                    end
                end                  
            end 

        case{'solar_6'}
            E_p(:,i)=(solar(t,coordinates,Constant)...
                *(Producers.capacity(i)*365/(1/(dt)/24))).*Solar_distribution(:,6); 
            if limit_solar == 1
                max_production = Producers.capacity(i)/4;
                for j = 1:size(E_p,1)
                    if E_p(j,i) >= max_production*production_limit
                        E_p(j,i) = max_production*production_limit;
                    end
                end                  
            end 

        case{'solar_7'}
            E_p(:,i)=(solar(t,coordinates,Constant)...
                *(Producers.capacity(i)*365/(1/(dt)/24))).*Solar_distribution(:,7); 
            if limit_solar == 1
                max_production = Producers.capacity(i)/4;
                for j = 1:size(E_p,1)
                    if E_p(j,i) >= max_production*production_limit
                        E_p(j,i) = max_production*production_limit;
                    end
                end                  
            end


        case{'solar_8'}
            E_p(:,i)=(solar(t,coordinates,Constant)...
                *(Producers.capacity(i)*365/(1/(dt)/24))).*Solar_distribution(:,8); 
            if limit_solar == 1
                max_production = Producers.capacity(i)/4;
                for j = 1:size(E_p,1)
                    if E_p(j,i) >= max_production*production_limit
                        E_p(j,i) = max_production*production_limit;
                    end
                end                  
            end 

        case{'solar_9'}
            E_p(:,i)=(solar(t,coordinates,Constant)...
                *(Producers.capacity(i)*365/(1/(dt)/24))).*Solar_distribution(:,9); 
            if limit_solar == 1
                max_production = Producers.capacity(i)/4;
                for j = 1:size(E_p,1)
                    if E_p(j,i) >= max_production*production_limit
                        E_p(j,i) = max_production*production_limit;
                    end
                end                  
            end 

        case{'solar_10'}
            E_p(:,i)=(solar(t,coordinates,Constant)...
                *(Producers.capacity(i)*365/(1/(dt)/24))).*Solar_distribution(:,10); 
            if limit_solar == 1
                max_production = Producers.capacity(i)/4;
                for j = 1:size(E_p,1)
                    if E_p(j,i) >= max_production*production_limit
                        E_p(j,i) = max_production*production_limit;
                    end
                end                  
            end    

        case{'wind'}
            %wind function gives variation as fraction of annual generation
            %(integral wind from 0 to 365 equals 1)
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24));
        
        case{'wind_1'}
            %wind function gives variation as fraction of annual generation
            %(integral wind from 0 to 365 equals 1)
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                .*Wind_distribution(:,1); 

        case{'wind_2'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                .*Wind_distribution(:,2);  

        case{'wind_3'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                .*Wind_distribution(:,3);  
        
         case{'wind_4'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                .*Wind_distribution(:,4);  

        case{'wind_5'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                .*Wind_distribution(:,5); 
        
        case{'wind_6'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                .*Wind_distribution(:,6);  

        case{'wind_7'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                .*Wind_distribution(:,7);  
        
         case{'wind_8'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                .*Wind_distribution(:,8);  

        case{'wind_9'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                .*Wind_distribution(:,9);

        case{'wind_10'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                .*Wind_distribution(:,10);  

        case{'wind_11'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                .*Wind_distribution(:,11);  
        
         case{'wind_12'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                .*Wind_distribution(:,12);  

        case{'wind_13'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                .*Wind_distribution(:,13);
            

        case{'hydro'}
            %Hydro production is assumed constant throughout the year. 
            E_p(:,i)=ones(size(t,1),1)*Producers.capacity(i)/4;

        case{'biomass'}
            %Biomass production is assumed constant throughout the year. 
            E_p(:,i)=ones(size(t,1),1)*Producers.capacity(i)/4;    
        
        otherwise
            E_p(:,i)=ones(size(t,1),1)*Producers.capacity(i)/4;
    end
end
end
