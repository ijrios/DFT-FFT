%****************************************************
%                SCRIPT PARA ANALISIS DE POTENCIA
%****************************************************

% Comentar y des-comentar cada seccion segun el tipo de senal a analizar.
% Los parametros pueden ser modificados. Sea coherente...

umbralP=input('Indique el umbral de potencia [%]: ')/100;


%% *****Generando senal unipolar*******
%************************************
r=randi([0 1],1,10);%señal generada aleatoriamente
% fp=2000;
% Ts=1/fp;
% Fs=1/Ts;
% t=-0.5:Ts:0.5;
% pulso=rectpuls(t,1);

T=1e-3; % Duracion del pulso
L=100; % Numero de muestras por pulso
Ts=T/L;
Fs=1/Ts;
pulso= ones(1,100);
x1=[];
for i=1:length(r)
    if r(i)==1
        x1=[x1 pulso*1];
    else
        x1=[x1 pulso*0];
    end
end
%si es uno multiplicar con 1 y si es cero multiplicar con 0 
%al fianl concatenar en x
%la seÃñal final tiene que llamarse x
%% *******Generando senal polar********
%************************************
r=randi([0 1],1,10);%seÃ±al generada aleatoriamente
T=1e-3; % Duracion del pulso
L=100; % Numero de muestras por pulso
Ts=T/L;
Fs=1/Ts;
pulso= ones(1,100);
x2=[];
for i=1:length(r)
    if r(i)==1
        x2=[x2 pulso*1];
    else
        x2=[x2 pulso*-1];
    end
end

%% ******Generando senal bipolar*******
%************************************
r=randi([0 1],1,10);%seÃ±al generada aleatoriamente
T=1e-3; % Duracion del pulso
L=100; % Numero de muestras por pulso
Ts=T/L;
Fs=1/Ts;
pulso= ones(1,100);
x3=[];
cont1=0;
a=1;
for i=1:length(r)
    if r(i)==1
        x3=[x3 pulso*a];
        a=-a;
    else
        x3=[x3 pulso*0];
    end

end

%% ****Generando senal Manchester*****
%************************************
r=randi([0 1],1,10);%seÃ±al generada aleatoriamente
T=1e-3; % Duracion del pulso
L=100; % Numero de muestras por pulso
Ts=T/L;
Fs=1/Ts;
pulso=ones(1,100);
pulso1=[pulso -pulso];
x4=[];
for i=1:length(r)
    if r(i)==1
        x4=[x4 pulso1*1];
    else
        x4=[x4 pulso1*-1];
    end
end


%% ***** CALCULOS Y GRAFICAS ****
%************************************
t=0:1/Fs:1/Fs*length(x1)-1/Fs;
t2=0:1/Fs:1/Fs*length(x2)-1/Fs;
t3=0:1/Fs:1/Fs*length(x3)-1/Fs;
t4=0:1/Fs:1/Fs*length(x4)-1/Fs;
% portadora=cos(2*pi*6500*t);
% y=x;
% x=y.*portadora;
s1=fft(x1);
s1=s1(1:floor(length(x1)/2));
df=Fs/length(x1);
f=0:df:Fs/2-df;

s2=fft(x2);
s2=s2(1:floor(length(x2)/2));
df=Fs/length(x2);
f2=0:df:Fs/2-df;

s3=fft(x3);
s3=s3(1:floor(length(x3)/2));
df=Fs/length(x3);
f3=0:df:Fs/2-df;

s4=fft(x4);
s4=s4(1:floor(length(x4)/2));
df=Fs/length(x4);
f4=0:df:Fs/2-df;

figure(1);
subplot(3,1,1);
plot(t,x1,'g','LineWidth',2);
xlabel('Tiempo [s]');
ylabel('Amplitud');
title('FORMA DE ONDA');
grid on;
axis([0 t(end) 1.2*min(x1) 1.2*max(x1)]);

subplot(3,2,3);
plot(f/1000,abs(s1)/length(s1));
xlabel('Frecuencia [KHz]');
ylabel('Magnitud');
title('ESPECTRO DE MAGNITUD');
grid on;
axis([0 f(end)/1000 0 1.2*max(abs(s1)/length(s1))]);

ps2=zeros(1,length(s1));
ps1=(abs(s1)/(length(s1))).^2;
for k=1:length(s1)
    ps2(k)=(1/k)*sum(ps1(1:k));
end

subplot(3,2,4);
plot(f/1000,ps2);
xlabel('Frecuencia [KHz]');
ylabel('Densidad de Potencia [W/Hz]');
title('DENSIDAD DE POTENCIA ACUMULADA RELATIVA');
grid on;
axis([0 max(f/1000) 0 1.2*max(ps2)]);

PSDs=10*log10(s1.*conj(s1)/(length(s1)^2));

subplot(3,2,5)
plot(f/1000,PSDs);
xlabel('Frequency (KHz)')
ylabel('PSD [dB/Hz]');
title('DENSIDAD ESPECTRAL DE POTENCIA');
grid on;
axis([0 max(f/1000) 1.2*min(PSDs) 0.8*max(PSDs)]);

ps3=zeros(1,length(s1));
Pt=sum(ps1);
for k=1:length(s1)
    ps3(k)=(1/Pt)*sum(ps1(1:k));
end
umbral=umbralP*ones(1,length(ps3));
limitef=umbralP*double(ps3>=umbralP);

subplot(3,2,6);
plot(f/1000,100*ps3);
hold on;
plot(f/1000,100*umbral,'r');
plot(f/1000,100*limitef,'r--');
xlabel('Frecuencia [KHz]');
ylabel('Potencia Acumulada [%]');
title('POTENCIA ACUMULADA');
grid on;
axis([0 max(f/1000) 0 1.2*100*max(ps3)]);
pos=find(limitef==umbralP);
text(Fs/20000,110,['La frecuencia umbral es de ' num2str(pos(1)*df-df) ' Hz']);


figure(2);
subplot(3,1,1);
plot(t2,x1,'g','LineWidth',2);
xlabel('Tiempo [s]');
ylabel('Amplitud');
title('FORMA DE ONDA');
grid on;
axis([0 t2(end) 1.2*min(x2) 1.2*max(x2)]);

subplot(3,2,3);
plot(f2/1000,abs(s2)/length(s2));
xlabel('Frecuencia [KHz]');
ylabel('Magnitud');
title('ESPECTRO DE MAGNITUD');
grid on;
axis([0 f2(end)/1000 0 1.2*max(abs(s2)/length(s2))]);

ps2=zeros(1,length(s2));
ps1=(abs(s2)/(length(s2))).^2;
for k=1:length(s2)
    ps2(k)=(1/k)*sum(ps1(1:k));
end

subplot(3,2,4);
plot(f2/1000,ps2);
xlabel('Frecuencia [KHz]');
ylabel('Densidad de Potencia [W/Hz]');
title('DENSIDAD DE POTENCIA ACUMULADA RELATIVA');
grid on;
axis([0 max(f2/1000) 0 1.2*max(ps2)]);

PSDs=10*log10(s2.*conj(s2)/(length(s2)^2));

subplot(3,2,5)
plot(f2/1000,PSDs);
xlabel('Frequency (KHz)')
ylabel('PSD [dB/Hz]');
title('DENSIDAD ESPECTRAL DE POTENCIA');
grid on;
axis([0 max(f2/1000) 1.2*min(PSDs) 0.8*max(PSDs)]);

ps3=zeros(1,length(s2));
Pt=sum(ps1);
for k=1:length(s2)
    ps3(k)=(1/Pt)*sum(ps1(1:k));
end
umbral=umbralP*ones(1,length(ps3));
limitef=umbralP*double(ps3>=umbralP);

subplot(3,2,6);
plot(f2/1000,100*ps3);
hold on;
plot(f2/1000,100*umbral,'r');
plot(f2/1000,100*limitef,'r--');
xlabel('Frecuencia [KHz]');
ylabel('Potencia Acumulada [%]');
title('POTENCIA ACUMULADA');
grid on;
axis([0 max(f/1000) 0 1.2*100*max(ps3)]);
pos=find(limitef==umbralP);
text(Fs/20000,110,['La frecuencia umbral es de ' num2str(pos(1)*df-df) ' Hz']);


figure(3);
subplot(3,1,1);
plot(t3,x3,'g','LineWidth',2);
xlabel('Tiempo [s]');
ylabel('Amplitud');
title('FORMA DE ONDA');
grid on;
axis([0 t(end) 1.2*min(x3) 1.2*max(x3)]);

subplot(3,2,3);
plot(f3/1000,abs(s3)/length(s3));
xlabel('Frecuencia [KHz]');
ylabel('Magnitud');
title('ESPECTRO DE MAGNITUD');
grid on;
axis([0 f3(end)/1000 0 1.2*max(abs(s3)/length(s3))]);

ps2=zeros(1,length(s3));
ps1=(abs(s3)/(length(s3))).^2;
for k=1:length(s3)
    ps2(k)=(1/k)*sum(ps1(1:k));
end

subplot(3,2,4);
plot(f3/1000,ps2);
xlabel('Frecuencia [KHz]');
ylabel('Densidad de Potencia [W/Hz]');
title('DENSIDAD DE POTENCIA ACUMULADA RELATIVA');
grid on;
axis([0 max(f3/1000) 0 1.2*max(ps2)]);

PSDs=10*log10(s3.*conj(s3)/(length(s3)^2));

subplot(3,2,5)
plot(f3/1000,PSDs);
xlabel('Frequency (KHz)')
ylabel('PSD [dB/Hz]');
title('DENSIDAD ESPECTRAL DE POTENCIA');
grid on;
axis([0 max(f3/1000) 1.2*min(PSDs) 0.8*max(PSDs)]);

ps3=zeros(1,length(s3));
Pt=sum(ps1);
for k=1:length(s3)
    ps3(k)=(1/Pt)*sum(ps1(1:k));
end
umbral=umbralP*ones(1,length(ps3));
limitef=umbralP*double(ps3>=umbralP);

subplot(3,2,6);
plot(f3/1000,100*ps3);
hold on;
plot(f3/1000,100*umbral,'r');
plot(f3/1000,100*limitef,'r--');
xlabel('Frecuencia [KHz]');
ylabel('Potencia Acumulada [%]');
title('POTENCIA ACUMULADA');
grid on;
axis([0 max(f3/1000) 0 1.2*100*max(ps3)]);
pos=find(limitef==umbralP);
text(Fs/20000,110,['La frecuencia umbral es de ' num2str(pos(1)*df-df) ' Hz']);


figure(4);
subplot(3,1,1);
plot(t4,x4,'g','LineWidth',2);
xlabel('Tiempo [s]');
ylabel('Amplitud');
title('FORMA DE ONDA');
grid on;
axis([0 t4(end) 1.2*min(x4) 1.2*max(x4)]);

subplot(3,2,3);
plot(f4/1000,abs(s4)/length(s4));
xlabel('Frecuencia [KHz]');
ylabel('Magnitud');
title('ESPECTRO DE MAGNITUD');
grid on;
axis([0 f4(end)/1000 0 1.2*max(abs(s4)/length(s4))]);

ps2=zeros(1,length(s4));
ps1=(abs(s4)/(length(s4))).^2;
for k=1:length(s4)
    ps2(k)=(1/k)*sum(ps1(1:k));
end

subplot(3,2,4);
plot(f4/1000,ps2);
xlabel('Frecuencia [KHz]');
ylabel('Densidad de Potencia [W/Hz]');
title('DENSIDAD DE POTENCIA ACUMULADA RELATIVA');
grid on;
axis([0 max(f4/1000) 0 1.2*max(ps2)]);

PSDs=10*log10(s4.*conj(s4)/(length(s4)^2));

subplot(3,2,5)
plot(f4/1000,PSDs);
xlabel('Frequency (KHz)')
ylabel('PSD [dB/Hz]');
title('DENSIDAD ESPECTRAL DE POTENCIA');
grid on;
axis([0 max(f4/1000) 1.2*min(PSDs) 0.8*max(PSDs)]);

ps3=zeros(1,length(s4));
Pt=sum(ps1);
for k=1:length(s4)
    ps3(k)=(1/Pt)*sum(ps1(1:k));
end
umbral=umbralP*ones(1,length(ps3));
limitef=umbralP*double(ps3>=umbralP);

subplot(3,2,6);
plot(f4/1000,100*ps3);
hold on;
plot(f4/1000,100*umbral,'r');
plot(f4/1000,100*limitef,'r--');
xlabel('Frecuencia [KHz]');
ylabel('Potencia Acumulada [%]');
title('POTENCIA ACUMULADA');
grid on;
axis([0 max(f4/1000) 0 1.2*100*max(ps3)]);
pos=find(limitef==umbralP);
text(Fs/20000,110,['La frecuencia umbral es de ' num2str(pos(1)*df-df) ' Hz']);