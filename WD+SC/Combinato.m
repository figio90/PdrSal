function [ DataFinale] = Combinato( D,TWD )

% Questa funzione permette di applicare un algoritmo di step counting sulle
% finestre di camminata riconosciute da un algoritmo di walk detection.
% INPUT:
% TWD e D vengono creati con la chiamata [D, TWD] = readall();
% OUTPUT:
% DataFinale: contiene il nome del file e i passi stimati.


% Esecuzione algoritmo WD
tic;
Data = Statistiche(D,TWD);

DataFinale = cell(length(TWD), 2);
Inizio = [];
Fine = [] ;
numPassi = 0;

% Scelta algoritmo SC
toc
algoritmo = menu(' scegli un algoritmo: ','WPD' ,'MCC', 'NASC','CWT');
tic;
% Esecuzione algoritmo SC scelto

switch algoritmo
    
    case 1 % WPD
        
        for i=1:length(TWD)
            Inizio = Data{i,2};
            Fine = Data{i,3};
            for j=1:length(Inizio)
                
                
                magn = D{i,3}(Inizio(j):Fine(j));
                numPassi = numPassi + testWPD(magn);
            end
            
            DataFinale{i,1} = TWD{i,1};
            DataFinale{i,2} = numPassi;
            numPassi = 0 ;
            
            
        end
        
    case 2 %MCC
        for i=1:length(TWD)
            Inizio = Data{i,2};
            Fine = Data{i,3};
            for j=1:length(Inizio)
                magn = D{i,3}(Inizio(j):Fine(j));
                x = length(testMCC(magn));
                numPassi = numPassi + x;
            end
            
            DataFinale{i,1} = TWD{i,1};
            DataFinale{i,2} = numPassi;
            numPassi = 0 ;
            
        end
        
    case 3 %NASC
        for i=1:length(TWD)
            Inizio = Data{i,2};
            Fine = Data{i,3};
            for j=1:length(Inizio)
                
                magn = D{i,3}(Inizio(j):Fine(j));
                numPassi = numPassi + testNASCsc(magn);
            end
            
            DataFinale{i,1} = TWD{i,1};
            DataFinale{i,2} = numPassi;
            numPassi = 0 ;
            
            
        end
        
        
    case 4 % WPD
        
        for i=1:length(TWD)
            Inizio = Data{i,2};
            Fine = Data{i,3};
            for j=1:length(Inizio)
                
                magn = D{i,3}(Inizio(j):Fine(j));
                t= D{i,2};
                time = t(Inizio(j):Fine(j));
                
                numPassi = numPassi +testCWT(magn,time);
            end
            
            DataFinale{i,1} = TWD{i,1};
            DataFinale{i,2} = numPassi;
            numPassi = 0 ;
            
            
        end
end

toc


