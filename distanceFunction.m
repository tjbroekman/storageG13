function distance=distanceFunction(coordinate1,coordinate2)
% Code by Mark Weijers 
% m.j.weijers@tudelft.nl
% for use in Necessity of Storage course of FM Mulder 2022
% refer to authors if used.

%Use global coordinate system
%output in km
deltacoordinate=(coordinate1-coordinate2)/180*pi();
% From: https://en.wikipedia.org/wiki/Geographical_distance
% lattitude (1), longtitude (2)
R=6371.009; %km
distance=R*sqrt(deltacoordinate(1)^2 ...
        +cos((coordinate1(1)/180*pi()+coordinate2(1)/180*pi())/2)...
            *deltacoordinate(2)^2);
end
