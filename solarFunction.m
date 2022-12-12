function E_p_frac=solarFunction(t,coordinates,Constant)
% Code by Mark Weijers 
% m.j.weijers@tudelft.nl
% for use in Necessity of Storage course of FM Mulder 2022
% refer to authors if used.

%convert coordinates to radial:
coordinates=coordinates/180*pi;
%find the constants:
foundMatrix=zeros(4,1);
for i=1:size(Constant.name,1)
    if strcmp(Constant.name{i,1},'solar')
    switch Constant.name{i,2}
        case 'd0'
            d0=Constant.value(i)/180*pi();
            foundMatrix(1,1)=1;
        case 'a0'
            a0=Constant.value(i);
            foundMatrix(2,1)=1;
        case 'a1'
            a1=Constant.value(i);
            foundMatrix(3,1)=1;
        case 'k'
            k=Constant.value(i);
            foundMatrix(4,1)=1;
    end
    end
end
%check if matrix is complete:
if size(find(foundMatrix),1)==4
    %% Define functions:
    %Year inclination to earth:
    delta=@(x) d0*cos(2*pi*((x-172)/365));
    %Reduction of power due to the angle of solar rays:
    CosVarFun=@(x,coordinates,delta) max(sin(coordinates(1)).*sin(delta(x))+cos(coordinates(1)).*cos(delta(x)).*cos(2*pi*(x-1/2)-coordinates(2)),0);
    % Normalization function for specific location:
    Fint=@(x,coordinates,delta,a0,a1,k,CosVarFun) CosVarFun(x,coordinates,delta).*(a0+a1.*exp(-k./CosVarFun(x,coordinates,delta)));
    % Normalization factor of specific coordinate:
    F= integral(@(x) Fint(x,coordinates,delta,a0,a1,k,CosVarFun),0,365);
    % A check on this:
    %     Is=@(x, coordinates, delta, a0,a1,k,F) CosVarFun(x,coordinates,delta)./F.*(a0+a1.*exp(-k./CosVarFun(x,coordinates,delta)))
    %     integral(@(x) Is(x, coordinates, delta, a0,a1,k,F),0,365)
    
    %% Calculation of fractional energy generation at time t in (Energy at this moment / Annual energy total)
    E_p_frac=Fint(t,coordinates,delta,a0,a1,k,CosVarFun)./F;

    fprintf('Solar succesfully calculated \n');
else
    E_p_frac=zeros(size(t,1),1);
end
end