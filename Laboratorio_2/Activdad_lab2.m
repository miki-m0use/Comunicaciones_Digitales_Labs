clear all; close all; clc;

Nbits = 1e4;
alpha_vals = [0 0.25 0.75 1];
sps = 4; % muestras por símbolo
span = 10; % duración del filtro

%generacion de bits NRZ-L
bits = randi([0 1], Nbits, 1);
symbols = 2*bits - 1; % NRZ-L (-1,1)

%Upsampling
tx_upsampled = upsample(symbols, sps);

%Canal AWGN
SNR = 20;

for i = 1:length(alpha_vals)
    
    alpha = alpha_vals(i);
    
    %filtro coseno alzado
    h = rcosdesign(alpha, span, sps, 'normal');
    
    %señal transmitida
    tx_signal = conv(tx_upsampled, h, 'same');
    
    %canal con ruido
    rx_signal = awgn(tx_signal, SNR, 'measured');
    
    %Diagrama de ojo ( si las siguientes tres lineas se dejan ejecutar,
    % aparecen 8 imagenes, es culpa del vicho deeeeaah)
    figure;
    eyediagram(rx_signal, 2*sps);
    title(['Diagrama de ojo - \alpha = ', num2str(alpha)]);
    
end