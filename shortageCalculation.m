function shortageSum = shortageCalculation(E_imbalance)

% Storage per month
ST_storage = zeros(1,length(E_imbalance));
ST_input = zeros(1,length(E_imbalance));

% Storage for over a month
LT_storage = zeros(1,length(E_imbalance));
LT_storage(1) = 0;
LT_input = zeros(1,length(E_imbalance));

shortages = zeros(1,length(E_imbalance));

%short & long term storage efficiency
eff_s = 0.9;
eff_l = 0.53;


for i=1:length(E_imbalance)
    if(E_imbalance(i)<0)    % SHORTAGE
        if(abs(ST_storage(i)) >= abs(E_imbalance(i)))   % ENOUGH ST
            ST_storage(i+1) = ST_storage(i) - abs(E_imbalance(i));
            LT_storage(i+1) = LT_storage(i);
        else
            if(abs(E_imbalance(i))>=ST_storage(i)+LT_storage(i))

            shortages(i) = abs(E_imbalance(i))-ST_storage(i)-LT_storage(i);      % NOT ENOUGH ST AND LT
            ST_storage(i+1) = 0;
            LT_storage(i+1) = 0;
            else
                LT_storage(i+1) = LT_storage(i) - (abs(E_imbalance(i))-ST_storage(i)); % NOT ENOUGH ST BUT WITH LT ENOUGH
                ST_storage(i+1) = 0;
                
            end
        end

    elseif(E_imbalance(i)>0)    %EXCESS
        if(ST_storage(i)>=25000)
            LT_storage(i+1) = LT_storage(i)+E_imbalance(i)*eff_l;
            ST_storage(i+1) = ST_storage(i);
            LT_input(i) = E_imbalance(i);
        else
        ST_storage(i+1) = E_imbalance(i)*eff_s+ST_storage(i);
        LT_storage(i+1) = LT_storage(i);
        ST_input(i) = E_imbalance(i);
        end
    end

end

shortageSum = sum(shortages);


end