%este archivo es para el laboratorio, osea trabajaremos con la señal FSK
R = 1000;
Fs = 32000;
dt = 1/Fs;
A_c = 1;
delta_f = 2000;

bits = [1 -1 1 -1 1 -1 1 -1]; %bits pero en formato polar (modulacion polar, asi sale la grafica en el libro)

% Muestras por bit: comprobar entero
Muestras_por_bit = Fs / R;
if Muestras_por_bit ~= floor(Muestras_por_bit)
    warning('Fs/R no es entero. Redondeando Muestras_por_bit.');
    Muestras_por_bit = round(Muestras_por_bit);
end

% Señal moduladora
m_t = repelem(bits(:), Muestras_por_bit);    % columna
N = length(m_t);
t = 0:dt:(length(m_t)-1)*dt;

% ENVOLVENTE
theta_t = 2*pi*delta_f * cumsum(m_t) * dt;
g_t = A_c * exp(1i * theta_t);


% Calculamos la transformada de Fourier de la señal g(t)
nfft = 2^nextpow2(N); 
G = fftshift(fft(g_t, nfft)); 
f = (-nfft/2 : nfft/2-1) * (Fs / nfft);

figure;
subplot(2,1,1);
plot(t, m_t, 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
title('Señal de Datos Banda Base polar m(t)');
grid on;

subplot(2,1,2)
plot(f, abs(G)/max(abs(G)), 'LineWidth', 1.2, 'Color', [1 0.3 0]);
xlim([-3*delta_f, 3*delta_f]);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud normalizada');
title('Espectro de la envolvente compleja g(t)');
grid on;





