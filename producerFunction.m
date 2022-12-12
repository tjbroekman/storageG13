function E_p=producerFunction(t,Producers,Constant,solar,wind,biomass)
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
            E_p(:,i)=wind(t,coordinates)...
                *(Producers.capacity(i)*365/(1/(dt)/24));
        case{'biomass'}
            E_p(:,i)=biomass(t,coordinates)*Producers.capacity(i)/(1/(dt)/24);
        otherwise
            E_p(:,i)=ones(size(t,1),1);
    end
end
end