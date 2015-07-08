function [times, magn] = importdat(fileID, startRow, endRow)
%% Utilizzato per importare i files del dataset
% INPUT: file.dat
% OUTPUT: due array contenente il tempo e la magnitudine dell'accelerazione

%% Set delimiters and other variables
delimiter = {',',' '};
if nargin<=2
    startRow = 1;
    endRow = inf;
end

formatSpec = '%f%f%f%f%f%[^\n\r]';

%% Read columns of data according to format string.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN,'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Create output variable
data = [dataArray{1:end-1}];
acc = data(:,2) == 1;
times = (data(acc,1) - data(1,1)) / 1e9;
magn = sqrt(data(acc,3).^2 + data(acc,4).^2 + data(acc,5).^2);




