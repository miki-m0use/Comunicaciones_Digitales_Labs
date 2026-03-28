% Primera parte, osea punto 1 de la actividad previa

% primero definimos las variables solicitadas: 
  % - Frecuencia de 1000Hz
  % - La señal se llamara m(t)
  % - Amplitud A = 1
  % - La señal es sinusoidal

fc = 1000; % frecuencia 
Ms = 1/100000; % muestras cada 10 microsegundos
t = 0:Ms:0.01; % vector de tiempo
A = 1;

m = A*sin(2*pi*fc*t); % señal original

Fs = 10000;
Ts = 1/Fs;

d = 0.5; % ciclo de trabajo
tau = d*Ts;

% Tren de pulsos
p = (square(2*pi*Fs*t, 100*d) + 1)/2;

% PAM natural
pam_natural = p .* m;

% PAM instantanea

pam_instantaneo = zeros(1, length(t));
% Buscamos los momentos donde el pulso sube
for i = 1:length(t)
    % Determinamos en qué periodo de muestreo estamos
    n = floor(t(i) / Ts);

    
    % Calculamos el tiempo exacto del inicio de ese pulso
    t_muestreo = n * Ts;
    
    % Si el tiempo actual cae dentro de la duración del pulso (tau)
    if mod(t(i), Ts) <= (d * Ts)
        % Tomamos el valor de m(t) SOLO al inicio del pulso
        pam_instantaneo(i) = A * sin(2*pi*fc*t_muestreo);
    else
        pam_instantaneo(i) = 0;
    end
end
%Hata aca era lo de la actividad previa ya hecho 

% FOURIER.............................


Y_m = fft(m); %transformada de Fourier de la señal ORIGINAL 
Y_nat = fft(pam_natural); %Transformada de la PAM natural
Y_inst = fft(pam_instantaneo);%Transformada de la PAM instantanea

fs_fft = 1/Ms; % frecuencia de muestreo usada en la simulacion
f = (0:length(Y_m)-1)*fs_fft/length(Y_m); %Construye el eje de frecuencias para la transformada de Fourier

% Solo frecuencias positivas
mitad = 1:floor(length(Y_m)/2);

f_pos = f(mitad);
Ym_pos = abs(Y_m(mitad));
Ynat_pos = abs(Y_nat(mitad));
Yinst_pos = abs(Y_inst(mitad));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(3,1,1)
plot(f_pos, Ym_pos, 'LineWidth', 1.2); hold on;
xlabel('Tiempo')
ylabel('Frecuencia ')
title('Señal Original m(t)')
grid on

subplot(3,1,2)
plot(f_pos, Ynat_pos, 'LineWidth', 1.2);
xlabel('Tiempo')
ylabel('Frecuencia')
title('Señal PAM natural')
grid on

subplot(3,1,3)
plot(f_pos, Yinst_pos, 'LineWidth', 1.2);
xlabel('tiempo')
ylabel('Frecuencia')
title('Señal PAM instantanea')
grid on

legend('Señal original', 'PAM natural', 'PAM instantánea');
xlim([0 30000]);
