function [Consumers, Producers, Transport, Constant]=loadMeta(metaNum,metaTxt);
% Code by Mark Weijers 
% m.j.weijers@tudelft.nl
% for use in Necessity of Storage course of FM Mulder 2022
% refer to authors if used.

%get rid of headers:
metaTxt2=metaTxt(2:end,:);
% sort Meta data:
meta=[];
Constant=[];
constantCounter=1; %Used to neatly pack all constants behind each other.
for i=1:size(metaTxt2,1)
    % Fetch out the constants:
    if strcmp(metaTxt2{i,1},'constant')
        id=0;
        Constant.name{constantCounter,1}=metaTxt2{i,2};
        Constant.name{constantCounter,2}=metaTxt2{i,4};
        Constant.value(constantCounter)=metaNum(i,1);
        constantCounter=constantCounter+1;
    else
    % Consumer (c) or producer (p) metadata:
        %introduce two counters for consumers and producers:
        %create structured array meta to save all data
    switch(metaTxt2{i,1}(1))
        case{'c'}
            id=1;
        case{'p'}
            id=2;
        case{'t'}
            id=3;
        otherwise
            id=0;                
    end
    end
    % Check if identification is done properly:
    if id>0
        %identify which property is assigned:
        switch string((metaTxt2(i,2)))
            case{'coordinates'}
                meta.users(id).coordinates(str2num(metaTxt2{i,1}(2:end)),:)=metaNum(i,:);
            case{'type'}
                meta.users(id).type{str2num(metaTxt2{i,1}(2:end)),1}=metaTxt2{i,5};
            case{'capacity'}
                meta.users(id).capacity(str2num(metaTxt2{i,1}(2:end)))=metaNum(i,1);
            case{'efficiency'}
                meta.users(id).efficiency(str2num(metaTxt2{i,1}(2:end)))=metaNum(i,1);
            case{'conversion'}
                meta.users(id).conversionEfficiency(str2num(metaTxt2{i,1}(2:end)))=metaNum(i,1);
            otherwise
        end
    end
end
fprintf('The amount of consumers is: %i \n',size(meta.users(1).capacity,2))
fprintf('The amount of producers is: %i \n',size(meta.users(2).capacity,2))

%Create the meta fields:
Producers=meta.users(2);
Consumers=meta.users(1);
Transport=meta.users(3);
