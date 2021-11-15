# Transformada Discreta de Fourier (DFT) y Transformada Rápida de Fourier (FFT).


# 1. Análisis de Fourier:
El análisis de Fourier consiste básicamente en la caracterización de señales y sistemas en el tiempo y en la frecuencia utilizando la Transformada de Fourier en cualquiera de sus versiones. 

•	La idea de este punto es combinar funciones ya desarrolladas en prácticas anteriores, para realizar la visualización de una señal de audio en el dominio del tiempo (osciloscopio - forma de onda) y en el dominio de la frecuencia (analizador de espectro - espectro) en tiempo real. Tenga en cuenta que el periodo de refresco (tiempo de barrido) exige mayor capacidad de cómputo en la medida que este se hace más corto. Inicie con periodos de refresco de aproximadamente un segundo y empiece a reducirlo tanto como su computador lo permita. Recuerde, además, que la frecuencia de muestreo también influye en la exigencia computacional y en el scope de frecuencia que tendrá su observación. El script debe preguntar estos datos al usuario antes de ejecutarse (fs y tbarrido). Recuerde graficar adecuadamente, con los ejes bien identificados y unidades precisas.

•	El script para este punto es un código simple que genera formas de onda específicas y presenta los resultados para el análisis de potencia usando la DFT. La idea es completar el script para realizar el análisis de 4 formas de onda adicionales que corresponden a los códigos de línea Unipolar, Polar, Bipolar y Manchester. En la figura siguiente se puede ver un ejemplo de estas formas de onda para una secuencia binaria específica. Pueden usar ese ejemplo para desarrollar el código faltante. Analice los resultados para comparar los diferentes tipos de codificación de línea.


# 2. Síntesis de Fourier
La síntesis de Fourier, por su parte, consiste en emplear la Transformada de Fourier en cualquiera de sus formas para construir (diseñar) señales y sistemas que cumplan con ciertas características deseadas (requerimientos).

•	El script que soluciona este punto es una aplicación directa de la síntesis de señales usando la DFT. El audio generado, correspondiente al número de 7 dígitos, debe ser almacenado en el computador en formato .WAV, de tal manera que se pueda usar el script DecTonos.m para verificar la adecuada construcción del audio. Cabe anotar que, aunque es una aplicación interesante de la DFT, no es el método utilizado en la práctica en las redes telefónicas donde la marcación por tonos se usó o se usa. En ellas, normalmente se implementaba un pequeño banco de filtros en recepción y osciladores con combinadores en transmisión.

•	El script que desarrolle debe generar una señal OFDM simple con una IFFT/FFT de 64 puntos con una numerología adecuada y frecuencias de muestreo y de modulación en “RF” que garanticen que la señal, ya modulada, se encuentra en el rango audible. Utilizando los scripts para mapeo desarrollados en la práctica 12, genere símbolos OFDM que puedan ser observados en el tiempo y en la frecuencia. Genere tramas de cierta duración, visualice y escuche la señal OFDM generada para anotar observaciones y conclusiones. Este script debe permitirle analizar cómo se relacionan los parámetros de la señal OFDM y cómo sus valores (numerología) afectan el desempeño del sistema.


# Conclusiones: 

Osciloscopio
•	En el osciloscopio visualizamos el comportamiento de la señal en el dominio de la frecuencia y a partir de esto podemos extraer la información de cómo se distribuye la energía dependiendo del tipo de señal. Por ejemplo, entre más pura sea la señal o sonido la energía tiende a concentrarse en un solo punto con su respectiva frecuencia, pero si la señal no es tan pura entonces se crean más réplicas espectrales (cosenos) a lo largo del eje de frecuencias, la energía tiende a concentrarse en diferentes puntos.
Este script graba la señal de voz durante 0.5 segundos con una frecuencia de muestreo de 8KHz, luego realiza el tratamiento de señales para obtener la forma de onda de la señal de voz de la persona. Para mostrar en espectro de frecuencia se realiza la FFT (transformada rápida de Fourier) y al final muestra la gráfica de la señal de voz y el espectro de frecuencia.

Señal Unipolar
•Esta señal unipolar tiene únicamente una sola polaridad, hay un nivel de tensión para cero binario y el otro para el 1 binario, para cero, tensión 0V y para 1, tensión 1V. En el espectro de magnitud la señal unipolar para una potencia de 50Wtts ingresada tiene frecuencias que se concentran mayormente en el rango de 0 a 5KHz. La señal unipolar tiene un problema, pues tiene un nivel DC bastante alto, lo cual indica que la potencia se acumula en un ancho de banda muy pequeño. Teniendo en cuanta esto hay una utilización de ancho de banda bastante corta.

Señal Polar
• Esta señal también tiene dos niveles de tensión uno positivo y otro negativo, para 1 la tensión es de 1V, y para cero la tensión es de -1V. En el espectro de magnitud la señal polar para una potencia de 50Wtts ingresada tiene frecuencias que se concentran mayormente en el rango de 0 a 7KHz, con mayor magnitud que la señal unipolar, concentra mucha más energía en este rango, aumenta el número de portadoras. En esta señal polar hay formas de reducir los componentes DC presentes en la señal unipolar e incluso tener un componente DC igual a cero. En el espectro de magnitud las frecuencias se pueden visualizar un poco distribuidas y la densidad de potencia aculada es aproximadamente el doble de la señal unipolar. 

Señal Bipolar
• En esta señal hay 3 niveles de tensión: positivo, nulo, y negativo. La tensión cero se representa con un nivel de tensión nulo, pero el bit 1 se representa alternando la tensión. En el espectro de magnitud la señal bipolar para una potencia de 50Wtts ingresada tiene frecuencias que se concentran mayormente en el rango de 0 a 12KHz, aumenta el número de portadoras, la densidad de potencia aculada es mucho más grande que a comparación de otras señales como el unipolar y polar.

Señal Manchester
• Una señal Manchester si un 0 empieza siempre en un valor de +V, a mitad del intervalo se produce la inversión a -V (lo que indica que el bit era un 0), si el siguiente bit es un 1, el nivel empieza el intervalo en -V y, a mitad del intervalo se produce la transición de -V a +V (lo que indica que el bit era un 1), si el siguiente bit hubiera sido un 0, se produciría una transición al principio para que al comienzo del intervalo la tensión fuera +V, de forma que en el medio del intervalo se produce la transición que indica el 0 (de +V a -V), de la misma manera si tras un 1 hay otro 1, se produce una transición de +V a -V para que en medio del intervalo se produzca la transición del bit 1 (de -V a +V) (Sistemas de Multiplexado - Codificación Manchester, n.d.). Esta señal tiene una desventaja, ocupa un ancho de banda muy amplio. La densidad espectral de esta señal es mucho más grande, es decir, la energía presente es mayor en cada frecuencia. La señal Manchester acumula bastante la energía a comparación de otras señales. 

Generador de tonos
• El script para generar tonos con los teclados de 0 a 9 incluidos *,#, de 7 dígitos simulando a un teléfono real se encuentra con el nombre AudioTonos.m, este script permite escuchar el audio de las teclas digitadas y lo guarda en un archivo llamado audiograbado.wav. Genera una señal con diferentes frecuencias (altas y bajas), posteriormente se suman y arman la señal correspondiente para cada teclado, se debe generar con un determinado tiempo (1/f) que muestrea y reconstruye la señal para ser escuchada con el comando sound. Se copia parte del script DecTonos.m generado por el docente para verificar la adecuada construcción del audio, por lo tanto, al finalizar se imprime en pantalla los dígitos que se generaron anteriormente. Una vez ingresado el archivo audiograbado.wav muestrea a la frecuencia que se ha guardado la señal en el archivo, luego realiza una transformada rápida de Fourier, de esta forma se sabe a qué teclado pertenece cada frecuencia, luego muestra por pantalla exactamente los teclados que se digitaron en el anterior script.

OFDM
• Como nos piden 64 portadoras se debe implementar la modulación 64QAM y generar una señal de información binaria de 256 símbolos (4*64 = 256), pero antes de generar la modulación debemos dividir la señal en 4 columnas y 16 filas, pues la modulación 64QAM solo permite un índice de modulación (M) de 16. Luego de haber dividido la señal entrante, debemos convertirla a caracteres y decimales antes de ingresarla al bloque de la modulación y realizar el mapeo, este nos entrega el vector x(k) y debemos aplicar la transformada inversa de Fourier (IFFT) para obtener nuestro vector x(n) y modular la portadora de alta frecuencia, después teniendo esto podemos aplicar nuevamente la FFT y obtener la magnitud de cada coeficiente para poder graficar nuestra señal en el dominio del tiempo. 
