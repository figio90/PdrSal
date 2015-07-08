function [PrecisionMean, RecallMean ] = PrecisionAndRecall( TWD, RisultatiFalsiNegativi, RisultatiFalsiPos )

% In questa funzione vengono calcolate Precision e Recall. Precision
% è definita come il rapporto tra veripositivi/veripositivi+falsipositivi.
% Recall come veripositivi/veripositivi+falsinegativi
% INPUT:
% TWD  creata con la chiamata [D, TWD] = readall();
% RisultatiFalsiNegativi con la chiamata:CalcoloFalsiNegativiWD(TWD,Risultati,D).
% RisultatiFalsiPos: CalcoloFalsiPositiviWD( TWD,Risultati,D );

VeroPositivi = zeros(length(TWD),1);
Precision = zeros(length(TWD),1);
Recall =  zeros(length(TWD),1);

for i=1:length(TWD)
    x = TWD{i,3}-TWD{i,2};
    y = RisultatiFalsiNegativi{i,2};
    veripositivi = x-y;
    VeroPositivi(i) = veripositivi;
    Precision(i) = veripositivi / (veripositivi + RisultatiFalsiPos{i,2});
    Recall(i)= veripositivi / (veripositivi + y);
    
end

PrecisionMean = mean(Precision);
RecallMean = mean(Recall);




