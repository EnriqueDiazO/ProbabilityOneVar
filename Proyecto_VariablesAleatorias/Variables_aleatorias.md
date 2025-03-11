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
variable aleatoria $X$, donde $X$ representa el salario mínimo asociado
a una profesión y una zona geográfica específica. El objetivo es
estudiar la distribución de $X$ y analizar cómo varía en diferentes
contextos.

# Aplicación de Variables Aleatorias al Estudio de Salarios

Una variable aleatoria puede ser discreta o continua. En el caso de los
salarios mínimos, $X$ es una variable aleatoria continua, ya que los
salarios pueden tomar cualquier valor dentro de un rango específico. La
distribución de $X$ se puede modelar utilizando funciones de densidad de
probabilidad (PDF) y funciones de distribución acumulativa (CDF).

La función de densidad de probabilidad $f_{X}(x)$ describe la
probabilidad de que $X$ tome un valor cercano a xx. Para un intervalo
$[a,b]$, la probabilidad de que $X$ esté en ese intervalo se calcula
como:

$$P (a\leq X \leq b) = \int_{a}^{b}f(x) dx$$

En este análisis, utilizaremos histogramas y gráficos de densidad para
visualizar $f_{X}(x)$ y entender la distribución de los salarios mínimos
en México. El script salarios.R te ayudará a comprender los siguientes
puntos

1.  Carga de Datos y Preprocesamiento de un dataset real.

Para iniciar con el análisis, requerimos instalar las paqueterias
necesarias.

``` r
source("requirements.r")
```

    ## Todas las librerías han sido instaladas y están listas para usar.

``` r
# Cargar librerías
library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)

# Cargar datos desde el archivo Excel
data <- read_excel("datasets/Salarios_Minimos_Generales_y_Profesionales_2009_2024_Zonas.xlsx", 
                   sheet = "Salarios_Minimos_Generales_y_Pr")

# Convertir la columna de fechas a formato Date
data$inicio_vigencia <- as.Date(data$inicio_vigencia)

# Mostrar las primeras filas
head(data)
```

    ## # A tibble: 6 × 89
    ##   inicio_vigencia zona 
    ##   <date>          <chr>
    ## 1 2009-01-01      a    
    ## 2 2009-01-01      b    
    ## 3 2009-01-01      c    
    ## 4 2010-01-01      a    
    ## 5 2010-01-01      b    
    ## 6 2010-01-01      c    
    ## # ℹ 87 more variables:
    ## #   salario_minimo_general <dbl>,
    ## #   albanileria <dbl>, archivista <chr>,
    ## #   boticas <dbl>, buldozer <dbl>,
    ## #   cajero <dbl>, cajista <chr>,
    ## #   cantinero <dbl>,
    ## #   carpintero_obra <chr>, …

2.  Transformación de Datos.

``` r
# Reemplazar valores "." por NA
data <- data %>% mutate(across(where(is.character), ~na_if(., ".")))

# Convertir todas las columnas (excepto 'zona') a numérico
data <- data %>% mutate(across(-c(inicio_vigencia, zona), as.numeric))

# Eliminar columnas que contengan al menos un valor NA
data <- data %>% select(where(~!any(is.na(.))))

# Filtrar datos para el año 2024
data_2024 <- data %>% filter(format(inicio_vigencia, "%Y") == "2024")
```

3.  Análisis de Distribución.

- Histogramas de Distribución de Salarios

``` r
# Filtrar datos por zona geográfica: Zona Fronteriza
data_2024_frontera <- data_2024 %>% filter(zona == "zlfn")  # Zona de la frontera

# Convertir datos a formato largo
data_2024_long_frontera <- data_2024_frontera %>% pivot_longer(cols = -c(inicio_vigencia, zona),
                                                               names_to = "profesion",
                                                               values_to = "salario")

# Graficar histograma para la zona fronteriza
hist_salarios_frontera <- ggplot(data_2024_long_frontera, aes(x = salario)) +
  geom_histogram(binwidth = 10, fill = "red", alpha = 0.7, color = "black") +
  scale_x_continuous(breaks = seq(0, max(data_2024_long_frontera$salario, na.rm = TRUE), by = 20)) +
  labs(title = "Distribución del salario en la zona fronteriza (2024)",
       x = "Salario Mínimo",
       y = "Frecuencia") +
  theme_classic() +  # Fondo blanco
  theme(
    axis.text = element_text(size = 14),   
    axis.title = element_text(size = 16)   
  )

# Guardar la imagen con fondo blanco
ggsave("images/hist_salarios_frontera.png", plot = hist_salarios_frontera, width = 8, height = 8, bg = "white")
```

![Distribución del salario en la zona fronteriza](ProbabilityOneVar/Proyecto_VariablesAleatorias/images/hist_salarios_frontera.png)


### Nota: No hay variación significativa en los salarios de la zona fronteriza.

Los salarios en la zona fronteriza no muestran una variación
significativa. Por esta razón, el análisis se enfocará únicamente en los
salarios fuera de la frontera.

``` r
# Filtrar datos por zona geográfica
data_2024_rest <- data_2024 %>% filter(zona == "restodelpais")

# Convertir datos a formato largo
data_2024_long_rest <- data_2024_rest %>% pivot_longer(cols = -c(inicio_vigencia, zona),
                                                       names_to = "profesion",
                                                       values_to = "salario")

# Graficar histograma con etiquetas más grandes y división en montos de 10
hist_salarios <- ggplot(data_2024_long_rest, aes(x = salario)) +
  geom_histogram(binwidth = 10, fill = "blue", alpha = 0.7, color = "black") +
  scale_x_continuous(breaks = seq(0, max(data_2024_long_rest$salario, na.rm = TRUE), by = 20)) +
  labs(title = "Distribución del salario en el resto de los estados no fronterizos (2024)",
       x = "Salario Mínimo",
       y = "Frecuencia") +
  theme_classic() +  # Fondo blanco
  theme(
    axis.text = element_text(size = 14),   
    axis.title = element_text(size = 16)   
  )

# Guardar la imagen con fondo blanco
ggsave("images/hist_salarios.png", plot = hist_salarios, width = 8, height = 8, bg = "white")
```

![Distribución del salario en el resto del país](ProbabilityOneVar/Proyecto_VariablesAleatorias/images/hist_salarios.png)


- Profesiones Mejor Pagadas

``` r
# Crear el gráfico con fondo blanco
top_10_professions <- data_2024_long_rest %>%
  group_by(profesion) %>%
  summarise(salario_promedio = mean(salario, na.rm = TRUE)) %>%
  arrange(desc(salario_promedio)) %>%
  slice_head(n = 10)

plot_top_10 <- ggplot(top_10_professions, aes(x = reorder(profesion, salario_promedio), y = salario_promedio)) +
  geom_bar(stat = "identity", fill = "darkgreen", alpha = 0.7) +
  geom_text(aes(label = round(salario_promedio, 2)), hjust = 0.1, size = 4) +
  coord_flip() +
  labs(title = "Top 10 oficios mejor pagados (2024)",
       x = "Oficio",
       y = "Salario Promedio") +
  theme_classic()  # Usa un tema con fondo blanco

# Guardar la imagen con fondo blanco
ggsave("images/top_10_plot.png", plot = plot_top_10, width = 8, height = 8, bg = "white")
```

![Top 10 oficios mejor pagados](ProbabilityOneVar/Proyecto_VariablesAleatorias/images/top_10_plot.png)


# Probabilidad de Ganar un Salario Específico

La probabilidad de que un trabajador gane un salario dentro de un rango
específico $[a,b]$ se puede calcular utilizando la función de densidad
de probabilidad $f_X(x)$. En este caso, aproximamos esta probabilidad
utilizando los datos empíricos:

$$ P(a \leq X \leq b) = \frac{\mbox{N\'umero de observaciones en $[a,b]$}}{\mbox{Total de observaciones}} $$

``` r
# Función para calcular la probabilidad de ganar entre 200 y 300 pesos
calcular_probabilidad <- function(min_val = 200, max_val = 300, region = "restodelpais") {
  data_2024_long <- data_2024 %>% pivot_longer(cols = -c(inicio_vigencia, zona),
                                               names_to = "profesion",
                                               values_to = "salario")
  data_rest <- data_2024_long %>% filter(zona == region)
  total <- nrow(data_rest)
  en_rango <- nrow(data_rest %>% filter(salario >= min_val & salario <= max_val))
  probabilidad <- en_rango / total
  return(probabilidad)
}

# Ejemplo de cálculo
calcular_probabilidad(min_val = 200, max_val = 350, region = "restodelpais")
```

    ## [1] 0.9661017

``` r
library(knitr)

summary_data <- data_2024_long_rest %>%
  group_by(profesion) %>%
  summarise(Avg_Salary = mean(salario, na.rm = TRUE),
            Min_Salary = min(salario, na.rm = TRUE),
            Max_Salary = max(salario, na.rm = TRUE)) %>%
  arrange(desc(Avg_Salary)) %>%
  slice_head(n = 30)

kable(summary_data, format = "html", caption = "Rango de salarios en oficios (2024)")
```

<table>
<caption>
Rango de salarios en oficios (2024)
</caption>
<thead>
<tr>
<th style="text-align:left;">
profesion
</th>
<th style="text-align:right;">
Avg_Salary
</th>
<th style="text-align:right;">
Min_Salary
</th>
<th style="text-align:right;">
Max_Salary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
reportero
</td>
<td style="text-align:right;">
557.41
</td>
<td style="text-align:right;">
557.41
</td>
<td style="text-align:right;">
557.41
</td>
</tr>
<tr>
<td style="text-align:left;">
reportero_grafico
</td>
<td style="text-align:right;">
557.41
</td>
<td style="text-align:right;">
557.41
</td>
<td style="text-align:right;">
557.41
</td>
</tr>
<tr>
<td style="text-align:left;">
trabajador_social
</td>
<td style="text-align:right;">
320.65
</td>
<td style="text-align:right;">
320.65
</td>
<td style="text-align:right;">
320.65
</td>
</tr>
<tr>
<td style="text-align:left;">
draga
</td>
<td style="text-align:right;">
303.61
</td>
<td style="text-align:right;">
303.61
</td>
<td style="text-align:right;">
303.61
</td>
</tr>
<tr>
<td style="text-align:left;">
buldozer
</td>
<td style="text-align:right;">
300.84
</td>
<td style="text-align:right;">
300.84
</td>
<td style="text-align:right;">
300.84
</td>
</tr>
<tr>
<td style="text-align:left;">
mecanico_autos
</td>
<td style="text-align:right;">
296.58
</td>
<td style="text-align:right;">
296.58
</td>
<td style="text-align:right;">
296.58
</td>
</tr>
<tr>
<td style="text-align:left;">
secretaria
</td>
<td style="text-align:right;">
295.98
</td>
<td style="text-align:right;">
295.98
</td>
<td style="text-align:right;">
295.98
</td>
</tr>
<tr>
<td style="text-align:left;">
chofer_camion
</td>
<td style="text-align:right;">
293.06
</td>
<td style="text-align:right;">
293.06
</td>
<td style="text-align:right;">
293.06
</td>
</tr>
<tr>
<td style="text-align:left;">
cocinero
</td>
<td style="text-align:right;">
290.81
</td>
<td style="text-align:right;">
290.81
</td>
<td style="text-align:right;">
290.81
</td>
</tr>
<tr>
<td style="text-align:left;">
maquinaria_agricola
</td>
<td style="text-align:right;">
288.59
</td>
<td style="text-align:right;">
288.59
</td>
<td style="text-align:right;">
288.59
</td>
</tr>
<tr>
<td style="text-align:left;">
sastreria_domicilio
</td>
<td style="text-align:right;">
288.59
</td>
<td style="text-align:right;">
288.59
</td>
<td style="text-align:right;">
288.59
</td>
</tr>
<tr>
<td style="text-align:left;">
albanileria
</td>
<td style="text-align:right;">
287.17
</td>
<td style="text-align:right;">
287.17
</td>
<td style="text-align:right;">
287.17
</td>
</tr>
<tr>
<td style="text-align:left;">
repostero
</td>
<td style="text-align:right;">
287.17
</td>
<td style="text-align:right;">
287.17
</td>
<td style="text-align:right;">
287.17
</td>
</tr>
<tr>
<td style="text-align:left;">
ebanista
</td>
<td style="text-align:right;">
286.51
</td>
<td style="text-align:right;">
286.51
</td>
<td style="text-align:right;">
286.51
</td>
</tr>
<tr>
<td style="text-align:left;">
radiotecnico_electrico
</td>
<td style="text-align:right;">
286.51
</td>
<td style="text-align:right;">
286.51
</td>
<td style="text-align:right;">
286.51
</td>
</tr>
<tr>
<td style="text-align:left;">
chofer_camioneta
</td>
<td style="text-align:right;">
284.76
</td>
<td style="text-align:right;">
284.76
</td>
<td style="text-align:right;">
284.76
</td>
</tr>
<tr>
<td style="text-align:left;">
electricista_autos
</td>
<td style="text-align:right;">
284.16
</td>
<td style="text-align:right;">
284.16
</td>
<td style="text-align:right;">
284.16
</td>
</tr>
<tr>
<td style="text-align:left;">
soldador_soplete
</td>
<td style="text-align:right;">
284.16
</td>
<td style="text-align:right;">
284.16
</td>
<td style="text-align:right;">
284.16
</td>
</tr>
<tr>
<td style="text-align:left;">
carpintero_muebles
</td>
<td style="text-align:right;">
282.44
</td>
<td style="text-align:right;">
282.44
</td>
<td style="text-align:right;">
282.44
</td>
</tr>
<tr>
<td style="text-align:left;">
hojalateria
</td>
<td style="text-align:right;">
282.44
</td>
<td style="text-align:right;">
282.44
</td>
<td style="text-align:right;">
282.44
</td>
</tr>
<tr>
<td style="text-align:left;">
electricista_instalaciones
</td>
<td style="text-align:right;">
281.44
</td>
<td style="text-align:right;">
281.44
</td>
<td style="text-align:right;">
281.44
</td>
</tr>
<tr>
<td style="text-align:left;">
mosaico
</td>
<td style="text-align:right;">
281.44
</td>
<td style="text-align:right;">
281.44
</td>
<td style="text-align:right;">
281.44
</td>
</tr>
<tr>
<td style="text-align:left;">
herreria
</td>
<td style="text-align:right;">
277.80
</td>
<td style="text-align:right;">
277.80
</td>
<td style="text-align:right;">
277.80
</td>
</tr>
<tr>
<td style="text-align:left;">
pintor_autos
</td>
<td style="text-align:right;">
277.80
</td>
<td style="text-align:right;">
277.80
</td>
<td style="text-align:right;">
277.80
</td>
</tr>
<tr>
<td style="text-align:left;">
plomero
</td>
<td style="text-align:right;">
276.42
</td>
<td style="text-align:right;">
276.42
</td>
<td style="text-align:right;">
276.42
</td>
</tr>
<tr>
<td style="text-align:left;">
fogonero
</td>
<td style="text-align:right;">
275.93
</td>
<td style="text-align:right;">
275.93
</td>
<td style="text-align:right;">
275.93
</td>
</tr>
<tr>
<td style="text-align:left;">
maquina_madera
</td>
<td style="text-align:right;">
275.93
</td>
<td style="text-align:right;">
275.93
</td>
<td style="text-align:right;">
275.93
</td>
</tr>
<tr>
<td style="text-align:left;">
pintor_casas
</td>
<td style="text-align:right;">
275.93
</td>
<td style="text-align:right;">
275.93
</td>
<td style="text-align:right;">
275.93
</td>
</tr>
<tr>
<td style="text-align:left;">
chofer_grua
</td>
<td style="text-align:right;">
273.92
</td>
<td style="text-align:right;">
273.92
</td>
<td style="text-align:right;">
273.92
</td>
</tr>
<tr>
<td style="text-align:left;">
electricista_motores
</td>
<td style="text-align:right;">
273.92
</td>
<td style="text-align:right;">
273.92
</td>
<td style="text-align:right;">
273.92
</td>
</tr>
</tbody>
</table>

# Conclusión

Este análisis ha permitido visualizar la distribución de los salarios
mínimos en México utilizando el concepto de variable aleatoria continua.
A través de histogramas y gráficos de densidad, hemos observado cómo los
salarios varían entre diferentes zonas geográficas y profesiones.
Además, hemos calculado la probabilidad de que un trabajador reciba un
salario dentro de un rango específico, lo que puede ser útil para
políticas laborales y análisis económicos.

Fuente:
