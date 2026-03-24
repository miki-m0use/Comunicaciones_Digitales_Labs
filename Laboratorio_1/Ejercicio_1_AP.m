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

plot(t,m) %graficamos la señal
xlabel('tiempo') % nombre del eje horizontal
ylabel('amplitud') %nombre del eje vertical
grid on %mostramos la señal

