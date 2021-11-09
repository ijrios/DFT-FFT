# Transformada Discreta de Fourier (DFT) y Transformada Rápida de Fourier (FFT).


# 1. Análisis de Fourier:
El análisis de Fourier consiste básicamente en la caracterización de señales y sistemas en el tiempo y en la frecuencia utilizando la Transformada de Fourier en cualquiera de sus versiones. 

•	La idea de este punto es combinar funciones ya desarrolladas en prácticas anteriores, para realizar la visualización de una señal de audio en el dominio del tiempo (osciloscopio - forma de onda) y en el dominio de la frecuencia (analizador de espectro - espectro) en tiempo real. Tenga en cuenta que el periodo de refresco (tiempo de barrido) exige mayor capacidad de cómputo en la medida que este se hace más corto. Inicie con periodos de refresco de aproximadamente un segundo y empiece a reducirlo tanto como su computador lo permita. Recuerde, además, que la frecuencia de muestreo también influye en la exigencia computacional y en el scope de frecuencia que tendrá su observación. El script debe preguntar estos datos al usuario antes de ejecutarse (fs y tbarrido). Recuerde graficar adecuadamente, con los ejes bien identificados y unidades precisas.

•	El script para este punto es un código simple que genera formas de onda específicas y presenta los resultados para el análisis de potencia usando la DFT. La idea es completar el script para realizar el análisis de 4 formas de onda adicionales que corresponden a los códigos de línea Unipolar, Polar, Bipolar y Manchester. En la figura siguiente se puede ver un ejemplo de estas formas de onda para una secuencia binaria específica. Pueden usar ese ejemplo para desarrollar el código faltante. Analice los resultados para comparar los diferentes tipos de codificación de línea.


# 2. Síntesis de Fourier
La síntesis de Fourier, por su parte, consiste en emplear la Transformada de Fourier en cualquiera de sus formas para construir (diseñar) señales y sistemas que cumplan con ciertas características deseadas (requerimientos).

•	El script que soluciona este punto es una aplicación directa de la síntesis de señales usando la DFT. El audio generado, correspondiente al número de 7 dígitos, debe ser almacenado en el computador en formato .WAV, de tal manera que se pueda usar el script DecTonos.m para verificar la adecuada construcción del audio. Cabe anotar que, aunque es una aplicación interesante de la DFT, no es el método utilizado en la práctica en las redes telefónicas donde la marcación por tonos se usó o se usa. En ellas, normalmente se implementaba un pequeño banco de filtros en recepción y osciladores con combinadores en transmisión.

•	El script que desarrolle debe generar una señal OFDM simple con una IFFT/FFT de 64 puntos con una numerología adecuada y frecuencias de muestreo y de modulación en “RF” que garanticen que la señal, ya modulada, se encuentra en el rango audible. Utilizando los scripts para mapeo desarrollados en la práctica 12, genere símbolos OFDM que puedan ser observados en el tiempo y en la frecuencia. Genere tramas de cierta duración, visualice y escuche la señal OFDM generada para anotar observaciones y conclusiones. Este script debe permitirle analizar cómo se relacionan los parámetros de la señal OFDM y cómo sus valores (numerología) afectan el desempeño del sistema.

