function [ passi ] = TestStepCounting( m,inizioCamminata,fineCamminata )

% Questa funzione permette di testare gli algoritmi di step counting
% singolarmente, utilizzando il menù.
% INPUT: magnitudine dell'accelerazione,tempi reali di inizio e fine
% camminata.
% OUTPUT: numero di passi calcolato.

algoritmo = menu(' scegli un algoritmo:  ' ,'WPD' , 'MCC','NASC');

switch algoritmo  % viene selezionato l'algoritmo desiderato
    
    case 1
        passi= testWPD(m(inizioCamminata:fineCamminata));
    case 2
        passi = length(testMCC(m(inizioCamminata:fineCamminata)));
    case 3
        passi = testNASCsc(m(inizioCamminata:fineCamminata));
        
    otherwise
        
        disp(' Il numero deve essere compreso tra 1 e 3');
        
end

