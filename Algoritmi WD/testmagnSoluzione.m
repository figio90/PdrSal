function [startw, endw] = testmagnSoluzione(magn,level)

% Questo algoritmo vuole riconoscere il periodo di camminata analizzando
% l'andamento della magnitudine dell'accelerazione.Se supera una soglia,
% passata in input o 10.5 di default, riconosce la camminata.
% Si assume che non si possa interrompere la caminata e riprenderla
% in meno di 0.9s.


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
    
    % Se non sto camminando e il valore è meggiore della soglia, inizio
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

ArrayInd = [];

% Ricerco tutte le finestre che iniziano troppo vicine alla fine della
% precedente, andandole ad eliminare
for i = 1:(length(startw)-1)
    if (startw(i+1)-endw(i))<90
        ArrayInd = [ArrayInd i];
    end
end

ArrayInd2 = ArrayInd +1 ;
startw(ArrayInd2)=[];
endw(ArrayInd)=[];

if length(startw) > length(endw)
    endw= [endw, length(magn)];
end

% Funzione per stampare rettangoli in corrispondenza delle finestre trovate
if nargout > 0
    return
end

    function plotRect(x1, x2, y1, y2)
        line([x1 x1], [y1 y2], 'LineWidth', 2, 'Color', [1 0 0]);
        line([x1 x2], [y2 y2], 'LineWidth', 2, 'Color', [1 0 0]);
        line([x2 x2], [y2 y1], 'LineWidth', 2, 'Color', [1 0 0]);
        line([x1 x1], [y1 y2], 'LineWidth', 2, 'Color', [1 0 0]);
        line([x2 x1], [y1 y1], 'LineWidth', 2, 'Color', [1 0 0]);
    end


plot(1:length(magn), magn, 'b', times, data,'b', 'LineWidth', 2);

if length(endw) < length(startw)
    endw = [endw, times(length(times))];
end

for i = 1:length(startw)
    plotRect(startw(i), endw(i), min(magn), max(magn));
end

end
