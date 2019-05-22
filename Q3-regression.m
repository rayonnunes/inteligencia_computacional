%Algoritmo Regression (linear and multiple)
%Disciplina: SBL0080 - Intelig�ncia Computacional
%Instituto: Universidade Federal do Cear�
%Autor: Rayon Lindraz Nunes
%Determinar modelos de regressão polinomial com parâmetros estimados por mínimos quadrados
clear;
clc;
close all;
A = importdata('data/aerogerador.dat');

%array de velocidade do vento
x = A(:,1);
%array de pot�ncia gerada
y = A(:,2);
n = length(x);
%grau k de 1 at� 5
figure
plot(x,y, '.');
hold on
for k = 1:5
    %matriz x^0, x^1,...,x^k
    X = zeros(n, (k+1)); 
    for i = 1:k+1
        for j = 1:n
            X(j,i) = x(j)^(i-1);
        end
    end

    XT = transpose(X);
    beta = (inv(XT*X)*XT)*y;
    pred_y = X*beta;
    e = y - pred_y;
    med_y = mean(y);

    SQE = sum((y - pred_y).^2);
    Syy = sum((y - med_y).^2);
    r = SQE/Syy;
    r2 = 1 - r;
    p = k+1;
    r2aj = 1 - r*((n-1)/(n-p));
    fprintf('\nr2: %f para grau %d',r2, k);
    fprintf('\nr2Ajustado: %f para grau %d\n',r2aj, k);
    plot(x, pred_y);
end
hold off
legend('Pot�ncia','k = 1','k = 2','k = 3','k = 4','k = 5', 'Location','northwest');
