function [startw, endw] = testEnergy(magn, step, size)

% Questo algoritmo vuole riconoscere il periodo di camminata analizzando
% l'energia del segnale. Esso è diviso in finestre di dimensione "size"
% che si sovrappongono di "step" elementi. La soglia sopra la quale viene
% riconosciuta la camminata è 0.04. L'energia del segnale è ottenuta
% mediante il calcolo della varianza sulle finestre.
% Input: magnitudine dell'accelerazione,spostamento della finestra,
% larghezzadella finestra.
% Output :[startw, endw] conterranno gli indici di inizio e fine delle
% finestre di camminata calcolate.

if nargin < 3
    size = 100;
end

% Viene impostata la grandezza della finestra e calcolato il numero di
% finestre che si utilizzeranno.

window = 1:size;
num = floor((length(magn) - size) / step);
data = zeros(num,1);
times = zeros(num,1);
walking = false;
lim = 0.1;
startw = [];
endw = [];

% Si scorrono tutte le finestre. Viene calcolata la varianza e aggiornata
% la finestra

for i = 1:num
    data(i) = var(magn(window));
    times(i) = size/2 + (i-1)*step;
    window = window + step;
    
    % Se non si sta camminando e la varianza è maggiore del limite
    % impostato,viene memorizzato l'indice l'indice in startw,ovvero dove
    % iniziano le finestre di camminata.
    
    if ~walking && data(i) > lim
        startw = [startw, times(i)];
        walking = true;
    end
    
    % Se si sta camminando e il valore della varianza scende sotto la
    % soglia chiudo la finestra di camminata memorizzando l'indice attuale.
    
    if walking && data(i) < lim
        endw = [endw, times(i)];
        walking = false;
    end
    
end

if length(startw) > length(endw)
    endw= [endw, length(magn)];
end


if nargout > 0
    return
end

% Grafici

    function plotRect(x1, x2, y1, y2)
        line([x1 x1], [y1 y2], 'LineWidth', 3, 'Color', [0 0 0]);
        line([x1 x2], [y2 y2], 'LineWidth', 3, 'Color', [0 0 0]);
        line([x2 x2], [y2 y1], 'LineWidth', 3, 'Color', [0 0 0]);
        line([x1 x1], [y1 y2], 'LineWidth', 3, 'Color', [0 0 0]);
        line([x2 x1], [y1 y1], 'LineWidth', 3, 'Color', [0 0 0]);
    end

h1 = plot(1:length(magn), magn, 'b', times, data, 'g', 'LineWidth', 1);
legend([h1], {'Magnitude','Energy'})
if length(endw) < length(startw)
    endw = [endw, times(length(times)) + size/2];
end

for i = 1:length(startw)
    plotRect(startw(i), endw(i), min(magn), max(magn));
end

end

