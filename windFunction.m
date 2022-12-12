function E_p_frac=windFunction(t,coordinates)
% Code by Mark Weijers 
% m.j.weijers@tudelft.nl
% for use in Necessity of Storage course of FM Mulder 2022
% refer to authors if used.

%convert coordinates to radial:
coordinates=coordinates/180*pi;

%fraction of year average:
E_p_frac=(cos(2*pi().*((t-29)/365))*43/92+1)...
    .*(3/4*cos(2*pi().*(t-16/24)-coordinates(2))+1)/365;
fprintf('wind succesfully calculated \n');
end