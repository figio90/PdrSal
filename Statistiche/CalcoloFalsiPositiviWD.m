function [ Data , FalsiPositivi,ErrorRate,ErrorArray] = CalcoloFalsiPositiviWD( TWD,Risultati,D )

% Questa funzione ha il compito di calcolare i falsi positivi,ovvero tutti
% gli indici temporali dove è riconosciuta erroneamente una camminata.
% INPUT:
% TWD e D vengono creati con la chiamata [D, TWD] = readall();
% Risultati  è  il prodotto della chiamata Risultati = Statistiche(D,TWD);
% OUTPUT:
% Data: contiene per ogni file i campioni risultati essere falsi positivi
% per ogni finestra di camminata riconosciuta
% FalsiPositivi = contiene per ogni file il numero di falsiPositivi
% ErrorRate = contiene l'errore di ogni file,calcolato come
% falsiPositivi/tot;


Data = cell(length(TWD), 2);
FalsiP = [];



for i=1:length(TWD)
    
    % vengono memorizzati gli indici veri di inizio e fine camminata
    inizio = TWD{i,2};
    fine = TWD{i,3};
    
    % indici di inizio e fine calcolati dall'algoritmo
    S = Risultati{i,2};
    E = Risultati{i,3};
    
    for j=1:length(S)
        %scorro tutte le finestre di camminata trovate
        
        % se finisco prima dell'inizio vero tutta la finestra è falsa
        % positiva
        if(E(j) < inizio)
            FalsiP = [FalsiP  (E(j)-S(j))];
        end
        
        % se inizio prima e termino all'interno della finestra reale i
        % falsi positivi satranno tutti gli indici presenti tra l'inizio
        % reale e l'inizio stimato
        
        if (S(j) < inizio) && (E(j) < fine) && E(j) > inizio
            FalsiP = [FalsiP (inizio - S(j))];
        end
        
        % se inizio prima e finisco dopo gli indici reali, i falsi positivi
        % saranno gli indici contenuti tra inizio reale e inizio stimato,
        % fine stimato e fine reale
        
        if (S(j) < inizio) && (E(j) > fine)
            FalsiP = [FalsiP  ((inizio -S(j)) + (E(j)-fine))];
        end
        
        % se l'inizio stimato s itrova tra l'inizio e la fine reali e la
        % fine stimata dopo la fine reale i falsi positivi saranno gli
        % indici tra la fine stimata e la fine reale.
        
        if (inizio < S(j)) && (S(j)<fine) && (E(j)> fine)
            FalsiP = [FalsiP  (E(j)-fine)];
        end
        
        % se l'inizio stimato è dopo la fine reale allora i falsi positivi
        % saranno tutti gli elementi della finestra calcolata
        
        if (S(j)> fine)
            FalsiP = [FalsiP  (E(j)-S(j))];
        end
        
    end
    
    % inserisco i risultati nella cell
    
    Data{i,1}= TWD{i,1};
    Data{i,2}= FalsiP;
    
    FalsiP= [];
    
end

% ora conto il numero di indici falsi positivi

FalsiPositivi = cell(length(TWD), 2);
X = [];
for i=1:length(TWD)
    X= Data{i,2};
    a=0;
    for j=1:length(X)
        a= a + X(j);
    end
    FalsiPositivi{i,2}= a;
    FalsiPositivi{i,1} = TWD{i,1};
    
end

% calcolo l'errore per ogni elemento

ErrorRate = cell(length(TWD),2);
ErrorArray = [];
for i=1:length(TWD)
    ErrorRate{i,2} = (FalsiPositivi{i,2}/ length(D{i,3}))* 100;
    ErrorArray(i)= (FalsiPositivi{i,2}/ length(D{i,3}))* 100;
end


