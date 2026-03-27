fc = 1000 % frecuencia 
Ms = 1/100000 % frecuencia de muestreo
t = 0:Ms:0.01%vector del tiempo de un segundo
A = 1
m = sin(2*pi*fc*t)


%ahora en la parte dos hay que crear una PAM

%por lo tanto hay que crear un tren de pulsos
%que multiplicara a la señal original m(t) -> quednado p(t)*m(t)
%etnonces como se nos pide crearon varibles extras para poder crear este tren
%que nos ayudara con la creacion del PAM
    % ciclo de trabajo d = tau/Ts esto nos demuestra que tan activo esta el pulso
    % osea el grosor del tiempo que esta activo en porcentaje
    % Fs -> frecuencia de muestreo

Fs = 10000
Ts = 1/Fs

d = 0.5 %donde tau es el ancho del pulso
tau = d*Ts % lo puse mejor asi porque si no es medio webeo poner un tau manual, es mal facil poner el "d"

%creado esto podemos crear el tren de pulsos

p = (square(2*pi*Fs*t, 100*d) + 1)/2 %el 100d se supone que es el ciclo de trabajo/duracion

M = p.*m



plot(t,M)
xlabel('tiempo')
ylabel('amplitud')
title('Señal con muestreo natural')
grid on