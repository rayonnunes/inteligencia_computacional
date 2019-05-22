clear;
clc;
close all;
A = importdata('iris_log.dat');
%posição 1-4 representam os atributos 5-7 representam as classes 001, 010 e 100
x = A(:,1:4);
y = A(:,5:7);
%passo de aprendizagem
nt = 0.01;
%adiciona o vetor x0
x0 = ones(length(x),1)*(-1);
x = [x0, x];
w = zeros(length(x),5);
u = x'*w;