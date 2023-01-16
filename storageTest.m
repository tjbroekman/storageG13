

% Storage per month
ST_storage = zeros(1,length(E_imbalance));
ST_storage(1) = E_imbalance(1);

% Storage for over a month
LT_storage = zeros(1,length(E_imbalance));


%initialized as all 1s, if 0 then good, else need capacity
E_imbalancePrime = ones(1,length(E_imbalance));
E_imbalancePrime(1) = 0;

%check ids for start and end of months
check = [97 194 292 388 484 582 679 776 874 971 1068 1165];
%short & long term storage efficiency
eff_s = 0.8;
eff_l = 0.9;

%efficiency of moving short term storage to long term storage
eff_s2l = 0.75;

for i=2:length(E_imbalance)
    if(E_imbalance(i)<0)
        if(ST_storage(i) == 0 && LT_storage(i) == 0)
            ST_storage(i) = E_imbalance(i);
            E_imbalancePrime(i) = 1;
        elseif(ST_storage(i)/eff_s<E_imbalance(i))
            %%CHECK MATH HERE
            E_imbalancePrime(i) = 0;
            %%Add another line to quantify the amount from long to grid
            LT_storage(i) = LT_storage(i)+ (E_imbalance(i)+(ST_storage(i)*eff_s))/eff_l;
            ST_storage(i) = 0;
        elseif(ST_storage(i)/eff_s>E_imbalance(i)) 
            E_imbalancePrime(i) = 0;
            ST_storage(i) = ST_storage(i) + E_imbalance(i)/eff_s;
        end
    elseif(E_imbalance(i)>0)
        ST_storage(i) = E_imbalance(i)+ST_storage(i-1);
        E_imbalancePrime(i) = 0;
    end
    
    if(ismember(i,check))
        LT_storage(i)=ST_storage(i)*eff_s2l+LT_storage(i-1);
        ST_storage(i)=0;
    end
end
