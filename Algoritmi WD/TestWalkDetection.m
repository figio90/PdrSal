function [ S,E ] = TestWalkDetection( m )

% Questa funzione permette di testare gli algoritmi di walk detection
% singolarmente, utilizzando il menù.
% INPUT: magnitudine dell'accelerazione
% OUTPUT: vettori contenenti gli indici di inizio e fine delle finestre
% calcolate.

algoritmo = menu(' scegli un algoritmo:  ' , 'MAGN_TH' , 'MAGN_TH_TEMP', 'ENER_TH','ENER_TH_MOV','STD','NASC');

S = [];
E = [];


switch algoritmo  % Viene selezionato l'algoritmo desiderato
    
    case 1
        [S,E] = testmagn(m);
    case 2
        [S,E] = testmagnSoluzione(m);
    case 3
        [S,E] = testEnergy(m,50);
    case 4
        [S,E] = testEnergyMov(m,50);
    case 5
        [S,E] = teststd(m,40);
    case 6
        [S,E] = testNASC(m);
        
    otherwise
        
        disp(' Il numero deve essere compreso tra 1 e 6');
end


end

