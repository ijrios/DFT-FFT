%% Aplicacion OFDM 
clear all; 
close all; 
clc;

%% Señal de información 
rango = [0,1]; %Generanmos 0 y 1 con probabilidad variable
size = [1,256]; % Tamaño de matriz 
bits = randi(rango,size);
disp(['Señal de información: ' num2str(bits)]);
M = 16;
b = log2(M);
l = (M)^1/2;

%% Representación de la señal de info binaria como señal digital
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


%% XXXXXXXXXXXXXXXXXXXXXX modulacion 64QAM  XXXXXXXXXXXXXXXXXXXXXXXXXXX
% Convertimos señal a decimales para modular 
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
sound(x1,fs); % escuchamos la señal

%XXXXXXXXXXXXXXXXXXXXXX Gráficas  XXXXXXXXXXXXXXXXXXXXXXXXXXX
figure(1)
subplot(3,1,1);
plot(t1,bit,'lineWidth',1);grid on;
axis([ 0 bperiodo*length(x) -0.5 1.5]);
ylabel('Amplitud(v)');
xlabel('Tiempo(s)');
title('Señal de informacion');
grid on;
s=length(x);%tamaño del vector X
t=0:bperiodo:bperiodo/4*s-bperiodo;%vector tiempo
f0=fs/length(t); 
f=-fs/2:f0:fs/2-f0; %vector frecuencia

subplot(3,1,2);
stem(t,x1,'lineWidth',1);grid on;
axis([ 0 bperiodo*length(x1) -1 1]);
ylabel('Amplitud(v)');
xlabel('Tiempo(s)');
title('Señal modulada');

subplot(3,1,3);
stem(f,fftshift(ws),'lineWidth',1);grid on;
ylabel('Amplitud(v^2)');
xlabel('Frecuencia(Hz)');
title('Grafica Espectro De Magnitud'); 


scatterplot(yy),grid on;
title('Diagrama de constelaciones 64QAM');
