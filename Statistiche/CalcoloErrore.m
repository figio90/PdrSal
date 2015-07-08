function [ X,Y,ErrorMean ] = CalcoloErrore( TabellaPassi )

% Viene calcolato l'errore medio come (passiStim-passireal)/passireal*100.
% INPUT : cell creata con la chiamata TabellaPassi( PassiCalcolati.
% OUTPUT: X contentente per ogni elemento l'errore medio. Y contentente
% l'errore medio per ogni elemento ordinato in modo crescente, ErrorMean
% contenente l'errore medio.

X = [];
for i=1:length(TabellaPassi)
    x= ((TabellaPassi{i,2}-TabellaPassi{i,3})/TabellaPassi{i,3})*100;
    X= [X x];
end

Y = sort(X);
ErrorMean = mean(Y(5:100));

end

