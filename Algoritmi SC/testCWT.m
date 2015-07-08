function [ passi ] = testCWT( magn,t )
% Dato il vettore della magnitudine e del tempo applica l'algoritmo CWT

%Viene applicata sulla magnitudine la Continuous Wavelet Transform
[wave, period, scale, coi, dj,paramout, k] = contwt(magn,1/100);
% Vengono scremati i dati non appartenente al range di frequenze di
% camminata
wave(abs(wave) > 2.5) = 0;  wave(abs(wave) < 0.3) = 0;
%Viene applicata la trasformata inversa
m2 =  invcwt(wave, 'MORLET', scale, paramout, k);

window_size = 50;
steps= [];
wstart = 1; wend = window_size;

%Viene applicato l'algoritmo MCC
while wstart <= length(m2) - window_size
    
    window_mean = mean(m2(wstart:wend));
    m3 = m2(wstart:wend) - window_mean;
    
    for i = 2:window_size
        if m3(i - 1) < 0 && m3(i) >= 0
            steps = [steps  wstart + i];
        end
    end
    
    wstart = wstart + window_size;
    wend = wend + window_size;
    passi = floor(length(steps)/5.1) ;
    
end

if nargout > 0
    return
end

t = 1:length(m2);
plot(t, m2, t(steps), 9, 'r*');

end