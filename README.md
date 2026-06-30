# Filtros de Áudio Butterworth: Separação de Frequências

Programa em MATLAB para projetar Filtros passivos Passa-Baixas e Passa-Altas de 2ª ordem, focados na separação de sinais de áudio. Inclui a seleção automática de componentes reais de prateleira e a validação gráfica do projeto teórico.

# Circuito do Filtro Passa-baixa
![Circuito do Filtro Passa-baixa](lowpass_filter.png)

### Função de transferência obtida a partir da análise desse circuito

$$\frac{\frac{1}{LC}}{(j\omega)^2 + \frac{1}{RC}j\omega + \frac{1}{LC}}$$

---

# Circuito do Filtro Passa-alta
![Circuito do Filtro Passa-alta](highpass_filter.png)

### Função de transferência obtida a partir da análise desse circuito

$$\frac{(j\omega)^2}{(j\omega)^2 + \frac{1}{RC}j\omega + \frac{1}{LC}}$$

---

### Equação Geral da Função de Transferência

$$\frac{\omega_c^2}{(j\omega)^2 + \frac{\omega_c}{Q}j\omega + \omega_c^2}$$

Comparando a função de transferência do passa-baixa com a equação geral, conseguimos extrair duas expressões.  

$$\omega_c^2 = \frac{1}{LC}$$
$$\frac{\omega_c}{Q} = \frac{1}{RC}$$

Tomando $Q = \frac{\sqrt{2}}{2}$ podemos resolver o sistema e obter as seguintes expressões para L e C:  
  
$$C = \frac{\sqrt{2}}{2R\omega_c}$$  
$$L = \frac{R\sqrt{2}}{\omega_c}$$  

---

# Implementação em MATLAB

O código desenvolvido automatiza o cálculo e a validação do projeto. A lógica está dividida entre as seguintes etapas:  

1. **Variáveis de Inicialização:** Pede para o usuário informar a frequência de corte em Hertz e o impedância da carga em Ohm.
2. **Vetores de L e C:** Inicializa dois vetores guardando os valores comerciais de indutância e capacitância.
3. **Cálculo de L e C:** Usa as expressões encontradas para cálcular L e C e percorre o vetor dos valores reais buscando a menor diferença com os valores calculados.
4. **Cálculo das diferenças:** Mostra a diferença entre os valores cálculados e reais dos componentes e da frequência de corte.
5. **Diagramas de Bode:** Usa as funções de transferência encontradas para plotar os gráficos que mostram o comportamento esperado com os componentes cálculados e o real com os componentes comerciais.

---

# Resultados

Seguindo as instruções do trabalho, foi utilizado o programa para os parâmetros de entrada $f = 2kHz$ e $R = 8ohms$ e obtivemos os seguintes resultados:

Indutância Teorico (L): 0.90 mH  
Indutância Real: 0.82 mH  
Capacitância Teorico (C): 7.03 μF  
Capacitancia Real: 6.80 μF  
  
Diferença entre os indutores: 0.08mH  
Diferença entre os capacitores: 0.23μF  
Diferença na frequência de corte: 131.37Hz  

---

## Gráficos de Bode

### Passa-baixa
![Gráfico de Bode - Passa-baixa](bode_lowpass.svg)

### Passa-alta
![Gráfico de Bode - Passa-alta](bode_highpass.svg)

