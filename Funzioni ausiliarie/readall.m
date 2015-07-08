function [Data, TrueWD] = readall()

files = dir('*.dat');
Data = cell(length(files), 3);

h = waitbar(0,'Initializing waitbar...');

%% Import filename, times, magnitude arrays into Data cell array
for i = 1:length(files)
    Data(i, 1) = cellstr(files(i).name);
    [t, m] = importdat(fopen(files(i).name));
    Data(i, 2) = num2cell(t, 1); Data(i, 3) = num2cell(m, 1);
    waitbar(i/length(files),h,'Working...')
end

close(h)

%% Import filename, (real) start, (real) end values into TrueWD cell array
TrueWD = importTrueWD('groundtruth_WD.txt');


%% Substitute Data names with TrueWD names
for i = 1:length(files)

    % split TrueWD name after the number
    name = TrueWD{i,1};
    dot_index = strfind(name, '.');
    num_index = dot_index(1) + 1;
    pref = name(1:num_index);
    suff = name(num_index+1:end);
    
    % search for the corresponding file and substitute its name in Data
    for j = 1:length(files)
        f_name = Data{j,1};
        if isempty(strfind(f_name, pref)) || isempty(strfind(f_name, suff))
            continue
        end
        fprintf('Change <%s> name to <%s>\n', f_name, name);
        Data(j,1) = cellstr([pref suff]);
    end
    
end