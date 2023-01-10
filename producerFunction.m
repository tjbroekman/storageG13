function E_p=producerFunction(t,Producers,Constant,solar,wind,biomass,Wind_distribution)
% Code by Mark Weijers 
% m.j.weijers@tudelft.nl
% for use in Necessity of Storage course of FM Mulder 2022
% refer to authors if used.

% Energy producer type and location, together with time stamp is converted
% to time and location dependant energy profile.
dt=t(2)-t(1);
E_p=[];
for i=1:size(Producers.type,1)
    string=Producers.type{i,1};
    coordinates=Producers.coordinates(i,:);
    switch string
        
        case{'solar'}
            %solar function gives variation as fraction of annual
            %generation (integral wind from 0 to 365 equals 1)
            E_p(:,i)=solar(t,coordinates,Constant)...
                *(Producers.capacity(i)*365/(1/(dt)/24));

        case{'wind'}
            %wind function gives variation as fraction of annual generation
            %(integral wind from 0 to 365 equals 1)
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24));
        
        case{'wind_1'}
            %wind function gives variation as fraction of annual generation
            %(integral wind from 0 to 365 equals 1)
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                *Wind_distribution(:,1); 

        case{'wind_2'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                *Wind_distribution(:,2);  

        case{'wind_3'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                *Wind_distribution(:,3);  
        
         case{'wind_4'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                *Wind_distribution(:,4);  

        case{'wind_5'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                *Wind_distribution(:,5); 
        
        case{'wind_6'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                *Wind_distribution(:,6);  

        case{'wind_7'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                *Wind_distribution(:,7);  
        
         case{'wind_8'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                *Wind_distribution(:,8);  

        case{'wind_9'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                *Wind_distribution(:,9);

        case{'wind_10'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                *Wind_distribution(:,10);  

        case{'wind_11'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                *Wind_distribution(:,11);  
        
         case{'wind_12'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                *Wind_distribution(:,12);  

        case{'wind_13'}
            E_p(:,i)=wind(t,coordinates)*(Producers.capacity(i)*365/(1/(dt)/24))...
                *Wind_distribution(:,13);
            
        case{'biomass'}
            E_p(:,i)=biomass(t,coordinates)*Producers.capacity(i)/(1/(dt)/24);
        otherwise
            E_p(:,i)=ones(size(t,1),1);
    end
end
end
