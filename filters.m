clear;
clc;
close all;

% Filtro

% Variaveis de inicialização

f_corte = 2000; % frequencia de corte (Hz)
z = 8; % impedancia da carga

w = f_corte * 2 * pi; % frequencia de corte (rad/s)

% Vetor de indutores em valor comercial (mH)
indutores = [0.10, 0.12, 0.15, 0.18, 0.22, 0.27, ...
             0.33, 0.39, 0.47, 0.56, 0.68, 0.82, ...
             1.00, 1.20, 1.50, 1.80, 2.20, 2.70, ...
             3.30, 3.90, 4.70, 5.60, 6.80, 8.20, ...
             10.0, 12.0, 15.0];

% Vetor de capacitores em valor comercial (uF)
capacitores = [1.0, 1.2, 1.5, 1.8, 2.2, 2.7, ...
    3.3, 3.9, 4.7, 5.6, 6.8, 8.2, ...
    10, 12, 15, 18, 22, 27, ...
    33, 39, 47, 56, 68, 82, ...
    100];

% Equações de Indutância e Capacitancia obtidos a partir da análise
l = z * sqrt(2) / w;
c =  sqrt(2) / (2 * z * w);

% Achando o valor comercial mais proximo de L
[~, idxL] = min(abs(indutores - l * 10^3));
l_real = indutores(idxL) * 10^-3;

% Achando o valor comercial mais proximo de C
[~, idx] = min(abs(capacitores - c * 10^6));
c_real = capacitores(idx) * 10^-6;

% Imprime os valores teóricos e reais de Indutor e Capacitor
fprintf('Indutância Teorico (L): %.2f mH\n', l * 10^3);
fprintf('Indutância Real: %.2f mH\n', l_real * 10^3);
fprintf('Capacitância Teorico (C): %.2f uF\n', c * 10^6);
fprintf('Capacitancia Real: %.2f uF\n', c_real * 10^6);

% Diagramas de Bode

% Passa-baixas Teorico
% Funções de transferência
Npbt = [1/(l * c)];
Dpbt = [1, 1/(z * c), 1/(l * c)];
H_pbt = tf(Npbt, Dpbt);

% Bode
figure;
title("Diagrama de Bode - Passa-Baixas Teorico");
bode(H_pbt);

grid on;

% Passa-baixas Real
% Funções de transferência
Npbr = [1/(l_real * c_real)];
Dpbr = [1, 1/(z * c_real), 1/(l_real * c_real)];
H_pbr = tf(Npbr, Dpbr);

%Bode
figure;
title("Diagrama de Bode - Passa-Baixas Real");
bode(H_pbr);

grid on;

% Passa-altas Teorico

% Função de transferência
Dpat = [1, 1/(z * c), 1/(l * c)];
H_pat = tf([1, 0, 0], Dpat);

% Bode
figure;
title("Diagrama de Bode - Passa-altas Teorico");
bode(H_pat);

grid on;

%Passa-altas Real

% Função de Transferência
Dpar = [1, 1/(z * c_real), 1/(l_real * c_real)];
H_par = tf([1, 0, 0], Dpar);

% Bode
figure;
title("Diagrama de Bode - Passa-altas Real");
bode(H_pat);

grid on;
