%Algoritmo fuzzy logic based decision
%Disciplina: SBL0080 - Intelig�ncia Computacional
%Instituto: Universidade Federal do Cear�
%Autor: Rayon Lindraz Nunes
%Criar um controle inteligente para freios a partir da pressão no pedal, velocidade do carro e velocidade da roda
clear;
clc;
close all;

p = -1;
w = -1;
c = -1;

%press�o no pedal
while (p < 0 || p > 100)
    prompt = ('insira o valor de press�o no pedal (0-100): ');
    p =  input(prompt);
    if (p < 0 || p > 100 || ischar(p))
       disp('Erro, a PRESS�O NO PEDAL deve ser um n�mero entre 0 e 100, tente novamente'); 
       p = -1;
    end
end

%velocidade da roda
while (w < 0 || w > 100)
    prompt2 = ('insira o valor para a velocidade da roda (0-100): ');
    w =  input(prompt2);
    if (w < 0 || w > 100 || ischar(w))
       disp('Erro, a VELOCIDADE DA RODA deve ser um n�mero entre 0 e 100, tente novamente') 
       w = -1;
    end
end

%velocidade do carro
while (c < 0 || c > 100)
    prompt3 = ('insira o valor para a velocidade do carro (0-100): ');
    c =  input(prompt3);
    if (c < 0 || c > 100 || ischar(c))
       disp('Erro, a VELOCIDADE DO CARRO deve ser um n�mero entre 0 e 100, tente novamente')
       c = -1;
    end
end

%determinar se p � Baixo (l) M�dio (m) ou Alto (h)
%calcula l(p)
if (p <= 50)
    lp = 1 - (p/50);
else
    lp = 0;
end

%calcula m(p)
if (p >= 30 && p < 50)
    mp = (p/20) - (3/2);
elseif (p >= 50 && p < 70)
    mp = 1 - ((p-50)/20);
else
    mp = 0;
end

%calcula h(p)
if (p > 50)
   hp = (p/50) - 1;
else
    hp = 0;
end

P = [lp mp hp];
[valp idxp] = max(P);

%determinar se w � devagar (s) M�dio (m) ou R�pido (f)
%calcula s(w)
if (w <= 60)
    sw = 1 - (w/60);
else
    sw = 0;
end

%calcula m(w)
if (w >= 20 && w < 50)
    mw = (w/30) - (2/3);
elseif (w >= 50 && w < 80)
    mw = 1 - ((w-50)/30);
else
    mw = 0;
end

%calcula f(w)
if (w > 40)
   fw = (w/40) - 1;
else
    fw = 0;
end

W = [sw mw fw];
[valw idxw] = max(W);

%determinar se c � devagar (s) M�dio (m) ou R�pido (f)
%calcula s(c)
if (c <= 60)
    sc = 1 - (c/60);
else
    sc = 0;
end

%calcula m(c)
if (c >= 20 && c < 50)
    mc = (c/30) - (2/3);
elseif (c >= 50 && c < 80)
    mc = 1 - ((c-50)/30);
else
    mc = 0;
end

%calcula f(c)
if (c > 40)
   fc = (c/40) - 1;
else
    fc = 0;
end

C = [sc mc fc];
[valc idxc] = max(C);

%Regras de sa�da:
%Regra 4:
if(idxp == 1)
   disp('Baixa Press�o nos pedais: Liberar Freio');
end
%Regra 1:
if (idxp == 2)
    disp('Press�o m�dia nos pedais: Aplicar Freio');
end
%Regra 2:
if (idxp == 3)
    if (idxc == 3)
        if (idxw == 3)
            disp('Carro em alta velocidade sem derrapagem: Aplicar Freio');
        else
            %Regra 3:
            disp('Carro derrapando: Liberar Freio');
        end
    else
        disp('Carro em velocidade segura: Aplicar Freio');
    end
end