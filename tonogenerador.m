%% Generacion de tonos dependiendo de la marcación de un # de 7 digitos
clc;
close all;
clear all;
fs=8000; 
Ts=1/fs; %Periodo de muestreo
t=0:Ts:0.3; %vector de tiempos
Ncifras=7; % Los tonos corresponden a 7 cifras marcadas (0-9, *, #)
teclado='123456789*0#';
Frecuencias=[697 697 697 770 770 770 852 852 852 941 941 941 ; 1209 1336 1477 1209 1336 1477 1209 1336 1477 1209 1336 1477]';


%% Ingresamos los digitos caracter por caracter
NumeroMarcado = input('Ingrese los digitos de la marcación: ', 's'); 

%% Definimos los tonos bajos
tnb1=sin(2*pi*697*t);
tnb2=sin(2*pi*770*t);
tnb3=sin(2*pi*852*t);
tnb4=sin(2*pi*941*t);

%% Definimos los tonos altos
tna1=sin(2*pi*1209*t);
tna2=sin(2*pi*1336*t);
tna3=sin(2*pi*1477*t);

y1 = tnb1+tna1; %Marcacion del numero 1 
y2 = tnb1+tna2;%Marcacion del numero 2 
y3 = tnb1+tna3;%Marcacion del numero 3 
y4 = tnb2+tna1; %Marcacion del numero 4  
y5 = tnb2+tna2; %Marcacion del numero 5 
y6 = tnb2+tna3; %Marcacion del numero 6 
y7 = tnb3+tna1; %Marcacion del numero 7 
y8 = tnb3+tna2; %Marcacion del numero 8 
y9 = tnb3+tna3; %Marcacion del numero 9 
y10 = tnb4+tna1; %Marcacion del numero * 
y11 = tnb4+tna2; %Marcacion del numero 0 
y12 = tnb4+tna3; %Marcacion del numero #

audio = [];

for i=1:Ncifras
    
    switch NumeroMarcado(i)
        
        case '1'
            audio = [audio y1/2];
        case '2'
            audio = [audio y2/2];
        case '3'
            audio = [audio y3/2];
        case '4'
            audio = [audio y4/2];
        case '5'
            audio = [audio y5/2];
        case '6'
            audio = [audio y6/2];
        case '7'
            audio = [audio y7/2];
        case '8'
            audio = [audio y8/2];
        case '9'
            audio = [audio y9/2];
        case '0'
            audio = [audio y10/2];
        case '#'
            audio = [audio y11/2];
        case '*'
            audio = [audio y12/2];
      end
                
end
    

%Verificacion grafica
plot(audio); %Grafico discreto
title('Generador de funciones');
xlabel('Tiempo [s]'); 
ylabel('Amplitud [v]'); 

%Verificacion auditiva
sound(audio,fs);
%player=audioplayer(y,fs),sound=(y,fs),wavplay=(y,fs)


%% Guardamos el audio del tono
audiowrite('audiograbado.wav',audio,fs); %Graba y guarda la señal

disp('Grabaci?n terminada. El archivo ha sido guardado como "audiograbado.wav"...');

%% Verificamos los digitos
archivo=input('Escriba el nombre del audio con los tonos: ','s');
[ondas,fs]=audioread(archivo);
NumeroMarcado=[];

La=length(ondas);
Lc=La/Ncifras;
cifras=reshape(ondas,Lc,Ncifras)';
dfs=fs/Lc;
f=0:dfs:fs/2;
espectros=zeros(Ncifras,length(f));
tonos=[];
for k=1:Ncifras
    s=abs(fft(cifras(k,:)));
    s=s(1:length(f));
    pos=s>70*mean(s);
    frec=f(pos);
    dist=zeros(1,12);
    for r=1:12
        dist(r)=sqrt((Frecuencias(r,1)-frec(1))^2+(Frecuencias(r,2)-frec(2))^2);
    end
    loc=dist==min(dist);
    NumeroMarcado=[NumeroMarcado teclado(loc)];
end

%plot(f,espectros');
%tonos
disp(['El numero marcado fue: ' NumeroMarcado]);
