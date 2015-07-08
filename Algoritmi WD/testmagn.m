function [startw, endw] = testmagn(magn,level)

% Questo algoritmo vuole riconoscere il periodo di camminata analizzando
% l'andamento della magnitudine dell'accelerazione.Se supera una soglia,
% passata in input o 10.5 di default, riconosce la camminata.


if nargin < 2
    level = 10.5;
end

data = 0;
times = 0;
walking = false;
startw = [];
endw = [];

% Calcolo la magnitudine dell'accelerazione per ogni istante
for i = 1:(length(magn)-1)
    data(i) = magn(i);
    times(i) =i;
    
    % Se non sto camminando e il calore è meggiore della soglia, inizio
    % a camminare
    
    if ~walking && data(i) > level
        startw = [startw, times(i)];
        walking = true;
    end
    
    % Se sto camminando e scendo sotto il livello, smetto di camminare
    
    if walking && data(i) < level
        endw = [endw, times(i)];
        walking = false;
    end
    
end


if length(startw) > length(endw)
    endw= [endw, length(magn)];
end
% Funzione per stampare rettangoli in corrispondenza delle finestre trovate
if nargout > 0
    return
end

    function plotRect(x1, x2, y1, y2)
        line([x1 x1], [y1 y2], 'LineWidth', 1, 'Color', [0 0 0]);
        line([x1 x2], [y2 y2], 'LineWidth', 1, 'Color', [0 0 0]);
        line([x2 x2], [y2 y1], 'LineWidth', 1, 'Color', [0 0 0]);
        line([x1 x1], [y1 y2], 'LineWidth', 1, 'Color', [0 0 0]);
        line([x2 x1], [y1 y1], 'LineWidth', 1, 'Color', [0 0 0]);
    end

% Grafico riportante la magnitudine dell'accelerazione e le finestre
% di camminata identificate dall'algoritmo

plot(1:length(magn), magn, 'g', times, data, 'b', 'LineWidth', 2);

for i = 1:length(startw)
    plotRect(startw(i), endw(i), min(magn), max(magn));
end

end
