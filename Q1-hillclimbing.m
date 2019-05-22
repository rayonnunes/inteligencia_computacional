%Algoritmo Hill Climbing (Random Restart)
%Disciplina: SBL0080 - Inteligência Computacional
%Instituto: Universidade Federal do Ceará
%Autor: Rayon Lindraz Nunes
%Encontrar o máximo de f(x,y) = |x sen(y*pi/4) + y sen(x*pi/4)| 
%(x,y) pertencem ao intervalo [0,20] com vizinhança 0.01

clear;
clc;

%variável de controle de repetições
repeat = 10;

%vizinhança (passo)
step = 0.01;

%vetor z que contem a posição atual da busca e seus possíveis passos 
%(x,y) (x+,y) (x-,y) (x,y+) (x,y-) respectivamente 
z = zeros(5,1);

%ao fim de cada repetição do hill climbing, armazena-se o máximo local
%juntamente com seu par (x,y) respectivamente
maxLocal = zeros(repeat,1);
xLocal = zeros(repeat,1);
yLocal = zeros(repeat,1);

for i = 1:repeat
    
    %gerando x e y aleatórios [0,20]
    x = randi(21)-1; 
    y = randi(21)-1;
    
    %flag indicando que foi atingido um máximo local
    maxFlag = 1;
    while (maxFlag)
        z(1) = abs(x*sin((y*pi)/4)+y*sin((x*pi)/4)); % z(x,y)
        
        % se (x,y) estiverem dentro do intervalo, 
        % calcule todos os possíveis passos de z
        if (x <= 20 && x >= 0) 
            z(2) = abs((x+step)*sin((y*pi)/4)+y*sin(((x+step)*pi)/4)); % z(x+,y)
            z(3) = abs((x-step)*sin((y*pi)/4)+y*sin(((x-step)*pi)/4)); % z(x-,y)
        end

        if  (y <= 20 && y >= 0)
            z(4) = abs(x*sin(((y+step)*pi)/4)+(y+step)*sin((x*pi)/4)); % z(x,y+)
            z(5) = abs(x*sin(((y-step)*pi)/4)+(y-step)*sin((x*pi)/4)); % z(x,y-)
        end
        
        %indice z(1) recebe o maior dos passos calculados, 
        %caso z(1)=max(z) então z(1) é um máximo local.
        switch max(z)
            case z(2)
                z(1) = z(2);
                x = x+step;
                %disp('movendo-se para x+');
            case z(3)
                z(1) = z(3);
                x = x-step;
                %disp('movendo-se para x-');
            case z(4)
                z(1) = z(4);
                y = y+step;
                %disp('movendo-se para y+');
            case z(5)
                z(1) = z(5);
                y = y-step;
                %disp('movendo-se para y-');
            otherwise
                %disp('máximo local atingido');
                maxFlag = 0;
        end
        maxLocal(i) = z(1);
        xLocal(i) = x;
        yLocal(i) = y;
    end
end

%retorna valor e índice máximos entre os máximos locais 
%(note que não necessariamente é um máximo global)
[val, idx] = max(maxLocal);
fprintf('Resultado de Hill Climbing com %d repetições: \nZ = %f;\nX que Maximiza a função: %f;\nY que Maximiza a função: %f.\n',repeat, val, xLocal(idx), yLocal(idx));

%Plotagem de gráfico
[X,Y] = meshgrid(1:.25:20,1:.25:20);
Z = abs(X.*sin((Y.*pi)/4)+Y.*sin((X*pi)/4));
surf(X,Y,Z);
hold on
%marcação de todos os máximos locais calculados
j = scatter3(xLocal,yLocal,maxLocal,'red');
j.SizeData = 100;
%ênfase no maior dos máximos locais
h = scatter3(xLocal(idx),yLocal(idx),maxLocal(idx),'filled','diamond', 'red');
h.SizeData = 300;
hold off