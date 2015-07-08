function [ TavolaPassi] = TabellaPassi( PassiCalcolati)

% Questa funzione ha lo scopo di creare una una tabella riportante per ogni
% campione i passi calcolati e i passi veri.
% INPUT: Cell contenente i passi calcolati
% OUTPUT : Cell contenente nome file,passi stimati,passi reali.

% viene importato il file contenente il numero di passi esatti che viene
% fornito col Dataset.

PassiVeri = importSCtrue('groundtruth_SC.txt');

% Viene creata la Cell che conterrà l'output

TavolaPassi = cell(length(PassiCalcolati), 3);


for i=1:length(PassiCalcolati)
    
    name = PassiCalcolati{i,1};
    % per poter associare a ogni file il numero corretto di passi viene
    % letto il prefisso e poi confrontato con 'groundtruth_SC.txt'.
    dot_index = strfind(name, '.');
    num_index = dot_index(1) + 1;
    pref = name(1:num_index);
    
    % Viene riempita la cell con nome,passi stimati,passi reali
    
    TavolaPassi{i,1} = name;
    TavolaPassi{i,2} = PassiCalcolati{i,2};
    for j=1:length(PassiVeri)
        if strcmp(pref,PassiVeri{j,1})
            TavolaPassi{i,3}= PassiVeri{j,2};
        end
        
    end  
    
    
end

