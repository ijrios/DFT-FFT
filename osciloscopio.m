%================================================================================
%OSCILOSCOPIO - ESTUDIO DE LA SEÑAL EN EL DOMINIO DE LA FRECUENCIA
%===============================================================================

clear all;
close all;
clc
disp("BIEVENIDOS AL PROGRAMA");
disp("Este programa simula un osciloscopio, estará grabando de forma continua");
Fs=8000;
duracion = 0.5;

while(Fs > 0) 
ObjetoAudio=audiorecorder(Fs,16,1); %Creacion del objeto de grabacion
recordblocking(ObjetoAudio,duracion); %Grabacion del sonido
audio=getaudiodata(ObjetoAudio, 'single');
audio=audio/max(max(abs(audio)));
audio=audio(:,1);
n=8;
q=2^n;
%Hacemos que la señal sea positiva
audio=(audio+1)*0.99;
audio=(q/2)*audio;
audio=floor(audio);
%Realizamos la transformada de fourier del audio
s=fftshift(abs(fft(audio)));

%Convertimos a binario el audio
audio=dec2bin(audio,n);
trendebits=reshape(audio',1,[]);
columnadebits=reshape(trendebits,n,[]);
columnaObtenida = reshape(columnadebits',[],n);
audioRecuperado= bin2dec(columnaObtenida);
audioRecuperado=(audioRecuperado/((2^n)/2))-1;
sr=fftshift(abs(fft(audioRecuperado)));
Ts=1/Fs;

%Construimos el vector de tiempo
t=0:Ts:Ts*length(audioRecuperado)-Ts;
f0=Fs/length(t); %Tamaño de paso
%Se construye el eje de las frecuencias
f=-Fs/2:f0:Fs/2-f0;

%GRAFICAMOS EL AUDIO
figure(2);
subplot(2,1,1);
% Graficando la señal en el tiempo (forma de onda)
plot(t,audioRecuperado,'b'); 
grid on;
xlabel('Tiempo [s]');
ylabel('Amplitud [V]');
title('Forma de onda del audio muestreado');
subplot(2,1,2);
plot(f,sr,'k');
grid on;
xlabel('Frecuencia [KHz]'); ylabel('Magnitud [V^2]');
title('Espectro del audio muestreado');
end

