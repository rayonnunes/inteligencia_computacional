%Algoritmo Hill Climbing (Random Restart)
%Disciplina: SBL0080 - Intelig�ncia Computacional
%Instituto: Universidade Federal do Cear�
%Autor: Rayon Lindraz Nunes
%Encontrar o m�ximo de f(x,y) = |x sen(y*pi/4) + y sen(x*pi/4)| 
%(x,y) pertencem ao intervalo [0,20] com vizinhan�a 0.01

clear;
clc;

%vari�vel de controle de repeti��es
repeat = 10;

%vizinhan�a (passo)
step = 0.01;

%vetor z que contem a posi��o atual da busca e seus poss�veis passos 
%(x,y) (x+,y) (x-,y) (x,y+) (x,y-) respectivamente 
z = zeros(5,1);

%ao fim de cada repeti��o do hill climbing, armazena-se o m�ximo local
%juntamente com seu par (x,y) respectivamente
maxLocal = zeros(repeat,1);
xLocal = zeros(repeat,1);
yLocal = zeros(repeat,1);

for i = 1:repeat
    
    %gerando x e y aleat�rios [0,20]
    x = randi(21)-1; 
    y = randi(21)-1;
    
    %flag indicando que foi atingido um m�ximo local
    maxFlag = 1;
    while (maxFlag)
        z(1) = abs(x*sin((y*pi)/4)+y*sin((x*pi)/4)); % z(x,y)
        
        % se (x,y) estiverem dentro do intervalo, 
        % calcule todos os poss�veis passos de z
        if (x <= 20 && x >= 0) 
            z(2) = abs((x+step)*sin((y*pi)/4)+y*sin(((x+step)*pi)/4)); % z(x+,y)
            z(3) = abs((x-step)*sin((y*pi)/4)+y*sin(((x-step)*pi)/4)); % z(x-,y)
        end

        if  (y <= 20 && y >= 0)
            z(4) = abs(x*sin(((y+step)*pi)/4)+(y+step)*sin((x*pi)/4)); % z(x,y+)
            z(5) = abs(x*sin(((y-step)*pi)/4)+(y-step)*sin((x*pi)/4)); % z(x,y-)
        end
        
        %indice z(1) recebe o maior dos passos calculados, 
        %caso z(1)=max(z) ent�o z(1) � um m�ximo local.
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
                %disp('m�ximo local atingido');
                maxFlag = 0;
        end
        maxLocal(i) = z(1);
        xLocal(i) = x;
        yLocal(i) = y;
    end
end

%retorna valor e �ndice m�ximos entre os m�ximos locais 
%(note que n�o necessariamente � um m�ximo global)
[val, idx] = max(maxLocal);
fprintf('Resultado de Hill Climbing com %d repeti��es: \nZ = %f;\nX que Maximiza a fun��o: %f;\nY que Maximiza a fun��o: %f.\n',repeat, val, xLocal(idx), yLocal(idx));

%Plotagem de gr�fico
[X,Y] = meshgrid(1:.25:20,1:.25:20);
Z = abs(X.*sin((Y.*pi)/4)+Y.*sin((X*pi)/4));
surf(X,Y,Z);
hold on
%marca��o de todos os m�ximos locais calculados
j = scatter3(xLocal,yLocal,maxLocal,'red');
j.SizeData = 100;
%�nfase no maior dos m�ximos locais
h = scatter3(xLocal(idx),yLocal(idx),maxLocal(idx),'filled','diamond', 'red');
h.SizeData = 300;
hold off