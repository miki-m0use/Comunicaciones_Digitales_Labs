%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% --- PARTE 2: MODULACIÓN PCM

N = 4; % No de bits 
L = 2^N; %niveles de cuanti
v_min = -A; % rango minimo de la señal
v_max = A;  % Rango máximo de la señal

% 2. Definición de los niveles de cuantización
delta = (v_max - v_min) / L; % Tamaño del paso de cuantización
niveles = v_min + (delta/2) : delta : v_max - (delta/2);

% 3. Proceso de Cuantización
% Solo cuantizamos los valores donde el pulso está "encendido" en la PAM instantánea
m_cuantizada = zeros(1, length(pam_instantaneo));

for i = 1:length(pam_instantaneo)
    if pam_instantaneo(i) ~= 0 || (mod(t(i), Ts) <= (d * Ts))
        % Encontrar el nivel más cercano
        [~, indice] = min(abs(pam_instantaneo(i) - niveles));
        m_cuantizada(i) = niveles(indice);
    else
        m_cuantizada(i) = 0; % Mantiene el cero si no hay pulso
    end
end

% 4. Cálculo del Error de Cuantización
% El error solo se calcula sobre las muestras activas (instantes de muestreo)
error_cuantizacion = zeros(1, length(t));
for i = 1:length(t)
     if mod(t(i), Ts) <= (d * Ts)
        error_cuantizacion(i) = pam_instantaneo(i) - m_cuantizada(i);
     end
end

% Gráfico comparativo: Original, PAM Instantánea y Cuantizada
figure;
subplot(3,1,1);
plot(t, m); % Señal original
title('Señal original')
grid on;

subplot(3,1,2)
plot(t, pam_instantaneo, 'r', 'LineWidth', 1); % PAM Instantánea
title(['PAM instantanea']);
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;


subplot(3,1,3)
stem(t(1:10:end), m_cuantizada(1:10:end), 'g', 'MarkerFaceColor', 'g'); % Cuantizada (PCM)
title(['Cuantizacion despues del muestreo (N = ', num2str(N), ' bits)']);
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;


% Gráfico del Error de Cuantización

figure;
plot(t, error_cuantizacion, 'k', 'LineWidth', 1.2);
title(['Error de Cuantización (N = ', num2str(N), ' bits)']);
xlabel('Tiempo (s)');
ylabel('Error');
grid on;