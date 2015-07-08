function [steps] = testMCC(magnitude)

% Algoritmo per la stima di passi. Dopo aver calcolato la media mobile
% sulla magnitudine dell'accelerazione, spezzo il segnale in finestre di 50
% campioni, calcolo la media e conto come passo ogni volta che il segnale
% incrocia positivamente la media.
% INPUT: magnitudine dell'accelerazione del segnale
% OUTPUT: indice dei passi stimati.

smoothing_size = 29;
window_size = 50;
steps = [];

if length(magnitude) < 32
    steps = [];
    return
end
smooth_magnitude = movingmean(magnitude, smoothing_size);

% Divido il segnale in finestre

wstart = 1; wend = window_size;
while wstart <= length(magnitude) - window_size
    
    window_mean = mean(smooth_magnitude(wstart:wend));
    m2 = smooth_magnitude(wstart:wend) - window_mean;
    
    %plot(wstart:wend, window_mean * ones(wend-wstart+1, 1), 'k', 'LineWidth', 2);
    %hold on;
    
    
    % controllo se ci sono incroci postivi. In caso affermativo memorizzo
    % l'indice nell'array steps
    
    for i = 2:window_size
        if m2(i - 1) < 0 && m2(i) >= 0
            steps = [steps  wstart + i];
        end
    end
    
    %aggiorno la finestra
    
    wstart = wend;
    wend = wend + window_size;
    
end

%Grafico

t = 1:length(smooth_magnitude);
h1 = plot(t, smooth_magnitude,'b', t(steps), 9, 'ro','MarkerSize',5,'MarkerFaceColor','r');
legend(h1, {'Magnitude','Steps'})


end