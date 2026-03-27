% Primera parte, osea punto 1 de la actividad previa

%primero definimos las variables solicitadas: 
    % - Frecuencia de 1000Hz
    % - La señal se llamara m(t)
    % - Amplitud A = 1
    % - La señal es sinusoidal
%ademas como se menciona matlab no puede generar señales analogas
%consideraremos que la señal tiene muestras cada 1/100000s (osea
% 10microsegundos)

fc = 1000 % frecuencia 
Ms = 1/100000 %muestras cada 10 microsegundos
t = 0:Ms:0.01%vector del tiempo de un segundo, tiempos mas peuqeños hace mejor la iamgen de la grafica
A = 1
m = A*sin(2*pi*fc*t)


Fs = 10000
Ts = 1/Fs

d = 0.5 %donde tau es el ancho del pulso
tau = d*Ts % lo puse mejor asi porque si no es medio webeo poner un tau manual, es mal facil poner el "d"

%creado esto podemos crear el tren de pulsos

p = (square(2*pi*Fs*t, 100*d) + 1)/2

subplot(2,1,1)
plot(t, m)
xlabel('Tiempo')
ylabel('Amplitud de m(t)')
title('Señal Original m(t)')
grid on

subplot(2,1,2)
plot(t, p)
xlabel('Tiempo')
ylabel('amplitud')
title('Señal tren de pulso cuadrado')
grid on

