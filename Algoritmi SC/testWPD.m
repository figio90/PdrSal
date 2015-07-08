function [ numPassi ] = testWPD( magn,sizeMov)

% Algoritmo per la stima dei passi basato sul riconoscimento di picchi nel
% segnale.
% INPUT: magnitudine dell'accelerazione, dimensione della finestra per il
% calcolo della media mobile per smussare il segnale
% OUTPUT: numero di passi stimati
if length(magn) < 32
    numPassi = 0;
    return
end


if nargin < 2
    sizeMov = 31;
end

% Viene calcolata la media mobile
m = movingmean(magn,sizeMov);

% Stimato il numero di picchi, utilizzando MinPeakProminence. Esso tende a
% riconoscere passi regolari, andando così ad escludere picchi troppo
% ravvicinati dati da rumore nel segnale

picchi = findpeaks(m,'MinPeakProminence',1);
numPassi = length(picchi);


% picchi conterrà gli indici dei picchi rilevati, numPassi il numero
% stimato


end

