function [ Data ] = Statistiche(D,TWD)

% La funzione testa un algoritmo a scelta di WD su tutte le tracce del
% dataset

% D e TWD vengono creati con la chiamata [D, TWD] = readall();
Data = cell(length(TWD), 3);

algoritmo = menu(' scegli un algoritmo: ','MAGN_TH_TEMP','ENER_TH','ENER_TH_MOV','STD_TH','NASC','MAGN');

switch algoritmo
    case 1
        h = waitbar(0,'Initializing waitbar...');
        for i=1:length(TWD)
            Data(i,1)= TWD(i,1);
            [S,E]=testmagnSoluzione(D{i,3},10.5);
            Data{i,2} = S;
            Data{i,3}= E;
            waitbar(i/length(TWD),h,'Working...')
            
        end
        
        close(h)
        
    case 2
        h = waitbar(0,'Initializing waitbar...');
        
        for i=1:length(TWD)
            Data(i,1)= TWD(i,1);
            [S,E]=testEnergy(D{i,3},50);
            Data{i,2} = S;
            Data{i,3}= E;
            waitbar(i/length(TWD),h,'Working...')
        end
        
        close(h)
        
    case 3
        
        h = waitbar(0,'Initializing waitbar...');
        for i=1:length(TWD)
            Data(i,1)= TWD(i,1);
            [S,E]=testEnergyMov(D{i,3},50);
            Data{i,2} = S;
            Data{i,3}= E;
            waitbar(i/length(TWD),h,'Working...')
        end
        
        close(h)
        
    case 4
        
        h = waitbar(0,'Initializing waitbar...');
        
        for i=1:length(TWD)
            Data(i,1)= TWD(i,1);
            [S,E]=teststd(D{i,3},40);
            Data{i,2} = S;
            Data{i,3}= E;
            waitbar(i/length(TWD),h,'Working...')
            
        end
        
        close(h)
        
    case 5
        
        h = waitbar(0,'Initializing waitbar...');
        for i=1:length(TWD)
            Data(i,1)= TWD(i,1);
            [S,E]=testNASC(D{i,3});
            Data{i,2} = S;
            Data{i,3}= E;
            waitbar(i/length(TWD),h,'Working...')
            
        end
        
        close(h)
        
    case 6
        h = waitbar(0,'Initializing waitbar...');
        for i=1:length(TWD)
            Data(i,1)= TWD(i,1);
            [S,E]=testmagn(D{i,3},10.5);
            Data{i,2} = S;
            Data{i,3}= E;
            waitbar(i/length(TWD),h,'Working...')
            
        end
        
        close(h)
        
    otherwise
        disp(' Il numero non è associato a nessun algoritmo');
        
        
end

