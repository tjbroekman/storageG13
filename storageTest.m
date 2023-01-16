

% Storage per month
ST_storage = zeros(1,length(E_imbalance));
ST_input = zeros(1,length(E_imbalance));
% ST_storage(1) = E_imbalance(1);

% Storage for over a month
LT_storage = zeros(1,length(E_imbalance));
LT_input = zeros(1,length(E_imbalance));

shortages = zeros(1,length(E_imbalance));

%check ids for start and end of months
check = [2976 5664 8640 11520 14496 17376 20352 23328 26208 29184 32064 35040];
%short & long term storage efficiency
eff_s = 0.8;
eff_l = 0.9;


for i=1:length(E_imbalance)
    if(E_imbalance(i)<0)    % SHORTAGE
        if(abs(ST_storage(i)) >= abs(E_imbalance(i)))   % ENOUGH ST
            ST_storage(i+1) = ST_storage(i) - abs(E_imbalance(i));
            LT_storage(i+1) = LT_storage(i);
        else
%             if(abs(E_imbalance(i)))
            shortages(i) = abs(E_imbalance(i))-ST_storage(i);      % NOT ENOUGH ST
            ST_storage(i+1) = 0;
            LT_storage(i+1) = LT_storage(i);
        end
%         elseif(ST_storage(i)/eff_s<E_imbalance(i))
%             %%CHECK MATH HERE
%             E_imbalancePrime(i) = 0;
%             %%Add another line to quantify the amount from long to grid
%             LT_storage(i) = LT_storage(i)+ (E_imbalance(i)+(ST_storage(i)*eff_s))/eff_l;
%             ST_storage(i) = 0;
%         elseif(ST_storage(i)/eff_s>E_imbalance(i)) 
%             E_imbalancePrime(i) = 0;
%             ST_storage(i) = ST_storage(i) + E_imbalance(i)/eff_s;
%         end

    elseif(E_imbalance(i)>0)    %EXCESS
        if(ST_storage(i)>=50000)
            LT_storage(i+1) = LT_storage(i)+E_imbalance(i)*eff_l;
            ST_storage(i+1) = ST_storage(i);
            LT_input(i) = E_imbalance(i);
        else
        ST_storage(i+1) = E_imbalance(i)*eff_s+ST_storage(i);
        LT_storage(i+1) = LT_storage(i);
        ST_input(i) = E_imbalance(i);
        end
    end

    
%     if(ismember(i,check))
%         LT_storage(i)=ST_storage(i)*eff_s2l+LT_storage(i-1);
%         ST_storage(i)=0;
%     end
end
