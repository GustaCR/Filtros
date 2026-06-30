clear;
clc;
close all;

% Filtro

%% Variaveis de inicialização

f_corte = input('Insira a frequência de corte (Hz): '); % frequencia de corte (Hz)
%char(937) = Simbolo de Ohm
z = input(['Insira a impedância da carga (', char(937) ,'): ']); % impedancia da carga

w = f_corte * 2 * pi; % frequencia de corte (rad/s)

%% Vetores dos valores comerciais

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

%% Achando os valores de L e C

% Equações de Indutância e Capacitancia obtidos a partir da análise
l = z * sqrt(2) / w;
c =  sqrt(2) / (2 * z * w);

% Achando o valor comercial mais proximo de L
[~, idxL] = min(abs(indutores - l * 1e3));
l_real = indutores(idxL) * 1e-3;

% Achando o valor comercial mais proximo de C
[~, idx] = min(abs(capacitores - c * 1e6));
c_real = capacitores(idx) * 1e-6;

% Imprime os valores teóricos e reais de Indutor e Capacitor
fprintf('\nIndutância Teorico (L): %.2f mH\n', l * 1e3);
fprintf('Indutância Real: %.2f mH\n', l_real * 1e3);
fprintf('Capacitância Teorico (C): %.2f uF\n', c * 1e6);
fprintf('Capacitancia Real: %.2f uF\n\n', c_real * 1e6);

%% Cálculo do erro gerado ao usar os componentes comerciais

l_dif = abs(l_real - l);
fprintf('Diferença entre os indutores: %.2fmH\n', l_dif * 1e3);

c_dif = abs(c_real - c);
fprintf('Diferença entre os capacitores: %.2fuF\n', c_dif * 1e6);

w_real = 1/(sqrt(l_real * c_real));
f_real = w_real / (2 * pi);
fprintf('Diferença na frequência de corte: %.2fHz\n\n', abs(f_real - f_corte));

%% Diagrama de Bode Passa-baixa

% Funções de transferência do passa-baixa

% Teórico
Npbt = [1/(l * c)];
Dpbt = [1, 1/(z * c), 1/(l * c)];
H_pbt = tf(Npbt, Dpbt);

% Real
Npbr = [1/(l_real * c_real)];
Dpbr = [1, 1/(z * c_real), 1/(l_real * c_real)];
H_pbr = tf(Npbr, Dpbr);

% Plot
bode_opt = bodeoptions;
bode_opt.FreqUnits = 'Hz';

figure;
bode(H_pbt, H_pbr, bode_opt);
title("Diagrama de Bode - Filtro Passa-baixa");
legend("Teórico", "Real");
grid on;

%% Diagrama de Bode Passa-alta 

% Funções de Transferência do Passa-alta

% Teórico
Npat = [1, 0, 0];
Dpat = [1, 1/(z * c), 1/(l * c)];
Hpat = tf(Npat, Dpat);


% Real
Npar = [1, 0, 0];
Dpar = [1, 1/(z * c_real), 1/(l_real * c_real)];
Hpar = tf(Npar, Dpar);

figure;
bode(Hpat, Hpar, bode_opt);
title("Diagrama de Bode - Filtro Passa-alta");
legend("Teórico", "Real");

grid on;
