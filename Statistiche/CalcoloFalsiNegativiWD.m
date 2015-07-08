function [ Data ,ErrorArray ] = CalcoloFalsiNegativiWD( TWD,Risultati,D)

% Questa funzione calcola per ogni file i falsi negativi ,ovvero tutti gli
% indici reali di camminata non riconosciuti.
% INPUT:
% TWD e D vengono creati con la chiamata [D, TWD] = readall();
% Risultati  è  il prodotto della chiamata Risultati = Statistiche(D,TWD);
% OUTPUT:
% Data: contiene per ogni elemento il numero di falsi negativi.
% ErrorArray: contiene il tasso di errore per ogni elemento.

% viene creata la cell

Data = cell(length(TWD), 2);


for i=1:length(TWD)
    
    % vengono memorizzati gli indici reali di inizio e fine camminata
    inizio = TWD{i,2};
    fine = TWD{i,3};
    
    % numero reale di istanti di camminata
    
    lunghezzaCamminata= fine-inizio;
    
    % risultati stimati
    
    S = Risultati{i,2};
    E = Risultati{i,3};
    
    for j=1:length(S)
        
        %inizio prima e finisco dentro la finestra
        if (S(j) < inizio) && (E(j) < fine) && (E(j) > inizio)
            percorsoCoperto = E(j)-inizio;
            lunghezzaCamminata = lunghezzaCamminata - percorsoCoperto;
        end
        %inizio prima e finisco dopo
        if (S(j) < inizio) && (E(j) > fine)
            
            lunghezzaCamminata = 0;
        end
        %inizio uguale finisco uguale o dopo
        if (S(j) == inizio) && (E(j) >= fine)
            
            lunghezzaCamminata = 0;
        end
        
        %inizio uguale finisco prima
        if (S(j) == inizio) && (E(j) < fine) &&  (E(j) > inizio)
            percorsoCoperto = E(j)-S(j);
            lunghezzaCamminata= lunghezzaCamminata - percorsoCoperto;
        end
        
        %inizio tra start e end e finisco prima di end
        if (S(j) > inizio)&&(S(j) < fine) && (E(j) > inizio) &&  (E(j) < fine)
            percorsoCoperto = E(j)-S(j);
            lunghezzaCamminata= lunghezzaCamminata - percorsoCoperto;
        end
        
        %inizio tra start e end e finisco dopo end
        if (S(j) > inizio) && (S(j) < fine)&& (E(j) >= fine)
            percorsoCoperto = fine-S(j);
            lunghezzaCamminata= lunghezzaCamminata - percorsoCoperto;
        end
    end
    
    % memorizzo nella cell nome e numero di falsi negativi
    
    Data{i,1}= TWD{i,1};
    Data{i,2}= lunghezzaCamminata;
    
    
end

X= [];

for i=1:length(Data)
    X(i) = Data{i,2};
end

ErrorArray = [];

% creo un array contenente gli errori per ogni file

for i=1:length(TWD)
    ErrorArray(i)= (X(i)/ length(D{i,3}))* 100;
end


