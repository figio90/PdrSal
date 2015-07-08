function [startw, endw] = testNASC(magn)

std_size = 90; std_step = 45;
std_window = 1:std_size;
num_std_window = floor((length(magn) - std_size) / std_step);
std_lim = 0.6;

std_array = zeros(length(magn), 1);
for i = 1:num_std_window
    std_array(std_window) = std(magn(std_window));
    std_window = std_window + std_step;
end


plot(1:length(magn), magn, 1:length(magn), std_array);

corr_size = 200;
corr_lim = 0.4;

walking = false;
startw = [];
endw = [];

while i < length(magn) - corr_size
    
    ac = autocorr(magn(i:i+corr_size), 150);
    
    if std_array(i) < std_lim
        if walking
            walking = false;
            endw = [endw i];
            i = i + 1;
        else
            i = i + 1;
        end
    else % std_array(i) >= std_lim
        if walking
            i = i + 1;
        else
            if max(ac(40:150)) > corr_lim
                walking = true;
                startw = [startw i];
                i = i + 1;
            else
                i = i + 50;
            end
        end
    end
    
    
end

if length(startw) > length(endw)
    endw= [endw, length(magn)];
end


    function plotRect(x1, x2, y1, y2)
        line([x1 x1], [y1 y2], 'LineWidth', 3, 'Color', [0 0 0]);
        line([x1 x2], [y2 y2], 'LineWidth', 3, 'Color', [0 0 0]);
        line([x2 x2], [y2 y1], 'LineWidth', 3, 'Color', [0 0 0]);
        line([x1 x1], [y1 y2], 'LineWidth', 3, 'Color', [0 0 0]);
        line([x2 x1], [y1 y1], 'LineWidth', 3, 'Color', [0 0 0]);
    end



h1 = plot(1:length(magn), magn, 'b', 1:length(magn), std_array, 'r--');
legend([h1], {'Magnitude','Deviazione standard'})

if length(endw) < length(startw)
    endw = [endw, length(magn)];
end

for i = 1:length(startw)
    plotRect(startw(i), endw(i), min(magn), max(magn));
end

end

