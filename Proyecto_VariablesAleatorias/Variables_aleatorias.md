Variables Aleatorias y Distribución de Salarios Mínimos en México
================
Enrique Díaz Ocampo
2025-03-10

# Introducción

En estadística, una variable aleatoria es una función que asigna un
valor numérico a cada resultado posible de un experimento aleatorio.
Formalmente, si $\Omega$ es el espacio muestral de un experimento
aleatorio, una variable aleatoria $X$ es una función:

$$X : \Omega \rightarrow R$$

En este análisis, consideramos los salarios mínimos en México como una
variable aleatoria XX, donde XX representa el salario mínimo asociado a
una profesión y una zona geográfica específica. El objetivo es estudiar
la distribución de XX y analizar cómo varía en diferentes contextos.

# Aplicación de Variables Aleatorias al Estudio de Salarios

Una variable aleatoria puede ser discreta o continua. En el caso de los
salarios mínimos, $X$ es una variable aleatoria continua, ya que los
salarios pueden tomar cualquier valor dentro de un rango específico. La
distribución de $X$ se puede modelar utilizando funciones de densidad de
probabilidad (PDF) y funciones de distribución acumulativa (CDF).

La función de densidad de probabilidad $f_{X}(x)$ describe la
probabilidad de que $X$ tome un valor cercano a xx. Para un intervalo
\[a,b\]\[a,b\], la probabilidad de que $X$ esté en ese intervalo se
calcula como:

$$P (a\leq X \leq b) = \int_{a}^{b}f(x) dx$$

En este análisis, utilizaremos histogramas y gráficos de densidad para
visualizar $f_{X}(x)$ y entender la distribución de los salarios mínimos
en México. El script salarios.R te ayudará a comprender los siguientes
puntos

1.  Carga de Datos y Preprocesamiento de un dataset real.

2.  Transformación de Datos.

3.  Análisis de Distribución.

- Histogramas de Distribución de Salarios

- Profesiones Mejor Pagadas

# Probabilidad de Ganar un Salario Específico

La probabilidad de que un trabajador gane un salario dentro de un rango
específico $[a,b]$ se puede calcular utilizando la función de densidad
de probabilidad $f_X(x)$. En este caso, aproximamos esta probabilidad
utilizando los datos empíricos:

$$ P(a \leq X \leq b) = \frac{\mbox{N\'umero de observaciones en $[a,b]$}}{\mbox{Total de observaciones}} $$

# Conclusión

Este análisis ha permitido visualizar la distribución de los salarios
mínimos en México utilizando el concepto de variable aleatoria continua.
A través de histogramas y gráficos de densidad, hemos observado cómo los
salarios varían entre diferentes zonas geográficas y profesiones.
Además, hemos calculado la probabilidad de que un trabajador reciba un
salario dentro de un rango específico, lo que puede ser útil para
políticas laborales y análisis económicos.

Fuente:
