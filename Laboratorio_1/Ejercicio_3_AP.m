% Primera parte, osea punto 1 de la actividad previa

%primero definimos las variables solicitadas: 
    % - Frecuencia de 1000Hz
    % - La señal se llamara m(t)
    % - Amplitud A = 1
    % - La señal es sinusoidal

fc = 1000; % frecuencia 
Ms = 1/100000; % muestras cada 10 microsegundos
t = 0:Ms:0.01; % vector de tiempo
A = 1;

m = A*sin(2*pi*fc*t); % señal original



Fs = 10000
Ts = 1/Fs

d = 0.5 %donde tau es el ancho del pulso
tau = d*Ts % lo puse mejor asi porque si no es medio webeo poner un tau manual, es mal facil poner el "d"

%creado esto podemos crear el tren de pulsos

p = (square(2*pi*Fs*t, 100*d) + 1)/2 %el 100d se supone que es el ciclo de trabajo/duracion en porcentaje

pam_natural = p .* m


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


plot(t, pam_instantaneo)
xlabel('Tiempo')
ylabel('Amplitud de m(t)')
title('Señal Original m(t)')
grid on
