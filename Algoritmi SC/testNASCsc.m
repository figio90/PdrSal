function [ numStep ] = testNASCsc( magn )
% Algoritmo NASCsc per la stima dei passi

%Viene impostata la grandezza della finestra
window = 1:200;
numStep = 0;

while window(end)< length(magn)
    %viene calcolata l'autocorrelazione
    ac = autocorr(magn(window), 80);
    %viene preso il massimo
    m = max(ac(48:80));
    Tmax = find(ac == m);
    %Calcolata la frequenza di camminata stimo il numero di passi
    numStep = numStep + 200/ Tmax;
    window = window + 200;
    
end

%scorse tutte le finestre analizzo gli elementi rimasti
window= window - 200;
num = (length(magn)-window(end));
% e ne stimo i passi
numStep= numStep + numStep*(num/length(magn));
numStep = floor(numStep);
