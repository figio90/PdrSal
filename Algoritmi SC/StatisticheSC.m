function [ Data ] = StatisticheSC( D,TWD )

% Questa funzione testa un algoritmo, scelto mediante l'uso di un menù, su
% tutte le tracce del dataset.

% D e TWD vengono creati con la chiamata [D, TWD] = readall();
Data = cell(length(TWD), 2);

% Menù grafico di scelta
algoritmo = menu(' scegli un algoritmo: ','WPD' ,'MCC', 'NASC','CWT');

%inizio timer
tic;

switch algoritmo
    
    case 1
        
        h = waitbar(0,'Initializing waitbar...');
        for i=1:length(TWD)
            
            Data(i,1)= TWD(i,1);
            inizioxxx= TWD{i,2};
            finexxx =  TWD{i,3};
            magn= D{i,3};
            temp = magn(inizioxxx:finexxx);
            x = testWPD(temp);
            waitbar(i/length(TWD),h,'Working...')
            Data{i,2} = x;
            
        end
        
        close(h)
        
    case 2
        
        h = waitbar(0,'Initializing waitbar...');
        for i=1:length(TWD)
            Data(i,1)= TWD(i,1);
            inizioxxx= TWD{i,2};
            finexxx =  TWD{i,3};
            magn= D{i,3};
            temp = magn(inizioxxx:finexxx);
            y = testMCC(temp);
            x= length(y);
            waitbar(i/length(TWD),h,'Working...')
            Data{i,2} = x;
            
        end
        
        close(h)
        
    case 3
        
        h = waitbar(0,'Initializing waitbar...');
        for i=1:length(TWD)
            Data(i,1)= TWD(i,1);
            inizioxxx= TWD{i,2};
            finexxx =  TWD{i,3};
            magn= D{i,3};
            temp = magn(inizioxxx:finexxx);
            x = testNASCsc(temp);
            waitbar(i/length(TWD),h,'Working...')
            Data{i,2} = x;
            
            
        end
        
        close(h)
        
    case 4
        h = waitbar(0,'Initializing waitbar...');
        for i=1:length(TWD)
            Data(i,1)= TWD(i,1);
            inizioxxx= TWD{i,2};
            finexxx =  TWD{i,3};
            time = D{i,2};
            magn= D{i,3};
            temp = magn(inizioxxx:finexxx);
            t = time(inizioxxx:finexxx);
            x = testCWT(temp,t);
            waitbar(i/length(TWD),h,'Working...')
            Data{i,2} = x;
            
            
        end
        
        close(h)
        
    otherwise
        disp(' Il numero non è associato a nessun algortimo');
        
        
        
        
end
%fine timer
toc