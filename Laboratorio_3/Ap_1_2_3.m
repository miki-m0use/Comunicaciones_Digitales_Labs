
%el ancho de banda de una señal OOK o ASK se escribe de la siguiente
%manera: B = (1+r)R segun el libro
%* 
% B es el ancho de banda
% r: es el factor de roll off
% R: velocidad de bit en bits/s
% 
% Entonces
% *%

r = 1;
R = 1000;

B = (1+r)*R

%Por otro lado la envolvente compleja es: g(t) = A_c * m(t)
%como m(t) es una señal unipolar:
%DATOS NECESARIOS
%----------------------------------------------------------------------------------------------------------
muestras_por_bit = 32 %numero de muestras en cada bit
Fs = muestras_por_bit*R %frecuencia de muestreo
dt = 1/Fs; % Calcular el intervalo de muestreo
T_b = 1/R %duracion de un bit

bits = [1 0 1 0 1 0 1 0]; 
m_t = repelem(bits, muestras_por_bit);
A_c = 1; % amplitud de la portadora

t = 0:dt:(length(m_t)-1)*dt;

%ENTONCES
g_t = A_c * m_t


% Calculamos la transformada de Fourier de la señal g(t)
N = length(g_t);
G_f = fft(g_t);          % Calculamos la FFT
G_f_shift = fftshift(G_f); % Centramos el espectro en 0 Hz

% Vector de frecuencias correcto centrado en 0 Hz
f = linspace(-Fs/2, Fs/2, N);

%GRAFICAMOS

figure;
subplot(2,1,1);
plot(t, m_t, 'LineWidth', 2);
ylim([-0.2 1.2]);
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
title('Señal de Datos Banda Base Unipolar m(t)');
grid on;

subplot(2,1,2);
plot(f, abs(G_f_shift)/N, 'LineWidth', 1.5);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud Normalizada');
title('Transformada de Fourier de la Envolvente Compleja g(t) [OOK]');
grid on;