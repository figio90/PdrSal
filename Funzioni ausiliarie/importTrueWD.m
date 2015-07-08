function groundtruthWD = importTrueWD(filename)

delimiter = {' ','(',')'};
startRow = 3;
endRow = inf;

formatSpec = '%s%f%f%*s%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');

dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

fclose(fileID);

dataArray([2, 3]) = cellfun(@(x) num2cell(x), dataArray([2, 3]), 'UniformOutput', false);
groundtruthWD = [dataArray{1:end-1}];
