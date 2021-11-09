%% Aplicacion OFDM 
clear all; 
close all; 
clc;

%% Se�al de informaci�n 
rango = [0,1]; %Generanmos 0 y 1 con probabilidad variable
size = [1,64]; % Tama�o de matriz 
bits = randi(rango,size);
disp(['Se�al de informaci�n: ' num2str(bits)]);
M = 16;
b = log2(M);
l = (M)^1/2;

%% Representaci�n de la se�al de info binaria como se�al digital
x = bits;
bperiodo = 0.0002; 
paso = bperiodo/100;
fs = 1/bperiodo;
t1=paso:paso:100*length(x)*(bperiodo/100);
bit = []; 
for n=1:1:length(x)
    if(x(n)==1);
       s = ones(1,100);
    else(x(n)==0);
        s = zeros(1,100);
    end
     bit=[bit s];
end


figure(1)
subplot(3,1,1);
plot(t1,bit,'lineWidth',1);grid on;
axis([ 0 bperiodo*length(x) -0.5 1.5]);
ylabel('Amplitud(v)');
xlabel('Tiempo(s)');
title('Se�al de informacion');
s=length(x);%tama�oo del vector X
t=0:bperiodo:bperiodo*s/4-bperiodo;%vector tiempo
df=fs/(s-1); 
f=-fs/8:df:fs/8; %vector frecuencia

%% XXXXXXXXXXXXXXXXXXXXXX modulacion 64QAM  XXXXXXXXXXXXXXXXXXXXXXXXXXX
% Convertimos se�al a decimales para modular 
seq = bits';
p = reshape(seq,4,[])'; % 4 columnas / 16 caracteres (64bits)
p1 = num2str(p); % convertimos bits a caracteres
% disp(p);
disp(p1);
p2 = bin2dec(p1); % Convertimos bits a decimales para modular
disp(p2); 
y = qammod(p2,M); % modulamos (m=16) 
sym=0:1:M-1;     % simbolos considerables QAM
yy=qammod(sym,M); % diagrama de constelacion 64QAM         
y2 = y';
x1 = real(ifft(y2)); % modula la portadora de alta frecuencia
y3=fft(x1);%tranformada discreta de fourier
ws=abs(y3);%magnitud coeficientes
sound(x1,fs); % escuchamos la se�al

%XXXXXXXXXXXXXXXXXXXXXX Gr�ficas  XXXXXXXXXXXXXXXXXXXXXXXXXXX
figure(1)
subplot(3,1,2);
stem(t,x1,'lineWidth',1);grid on;
ylabel('Amplitud(v)');
xlabel('Tiempo(s)');
title('Se�al modulada');

figure(1)
subplot(3,1,3);
stem(f,fftshift(ws),'lineWidth',1);grid on;
ylabel('Amplitud(v)');
xlabel('Frecuencia(Hz)');
title('Grafica Espectro De Magnitud'); 

figure(2)
scatterplot(yy),grid on;
title('Diagrama de constelaciones 64QAM');