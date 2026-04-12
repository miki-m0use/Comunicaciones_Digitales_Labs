clc;
clear;
close all;

alpha = 0.25;   %  el alfa que se tiene que cambiar
f_0 = 1;         % se usa uno porque es una represnetacion normalizada (ajustable pero no tan recomendado)

%Parametros derivados
fDelta = alpha * f_0;
B = f_0 * (1 + alpha);
f_1 = f_0 * (1 - alpha);

%generamos el rango de -2 y 2
f = linspace(-2*B, 2*B, 5000); % crea vector de rangos con 5000 puntos (variables y ajustables)
H = zeros(size(f)); %guarda respuesta del vector

if alpha == 0 %recordar caso especial, guiarse de la ecuacion 10
    H(abs(f) < f_0) = 1;
    H(abs(f) >= f_0) = 0;
else %caso general 
    for i = 1:length(f)
        f_a = abs(f(i)); %guarda el valor absoluto 
         %% función/ecuación 10 
        if f_a < f_1
            H(i) = 1;
        elseif f_a > B
            H(i) = 0;
        else
            H(i) = 0.5 * (1 + cos(pi*(f_a - f_1)/(2*fDelta)));
        end
    end
end

%% ecuacion 14
t = linspace(-10, 10, 5000);
h = zeros(size(t));

for i = 1:length(t) % tomar vector uno por uno 
    ti = t(i);

    if ti == 0
        h(i) = 2*f_0;
    else
        parte1 = sin(2*pi*f_0*ti) / (2*pi*f_0*ti);

        if alpha == 0
            h(i) = 2*f_0 * parte1;
        else
            denom = 1 - (4*fDelta*ti)^2;

            if abs(denom) < 1e-8
                h(i) = NaN;
            else
                parte2 = cos(2*pi*fDelta*ti) / denom;
                h(i) = 2*f_0 * parte1 * parte2;
            end
        end
    end
end

% corregir puntos NaN para que no se corte la grafica
idx = isnan(h);
if any(idx)
    h(idx) = interp1(t(~idx), h(~idx), t(idx), 'linear');
end

figure;
subplot(2,1,1);
plot(f, H, 'LineWidth', 1.5);
grid on;
title(['Respuesta en frecuencia del pulso coseno alzado, \alpha = ', num2str(alpha)]);
xlabel('f');
ylabel('H_e(f)');

subplot(2,1,2);
plot(t, h, 'LineWidth', 1.5);
grid on;
title(['Respuesta al impulso del pulso coseno alzado, \alpha = ', num2str(alpha)]);
xlabel('t');
ylabel('h_e(t)');