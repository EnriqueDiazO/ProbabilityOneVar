Exploración de Precios en un Subgrupo de Productos y Servicios
================
Enrique Díaz Ocampo
2025-03-17

# Contexto General

El presente análisis tiene como propósito explorar un subgrupo de servicios y productos básicos con el fin de aproximar su impacto en el gasto de una persona promedio en México. Sin embargo, es importante recalcar que los valores utilizados son aproximados y no representan una evaluación concluyente sobre la suficiencia del salario mínimo o el costo de vida general.

Para este ejercicio, se han considerado datos disponibles del Instituto Nacional de Estadística y Geografía (INEGI) y la Comisión Nacional de los Salarios Mínimos (CONASAMI), con el fin de obtener un panorama exploratorio de algunos gastos recurrentes.

# Variables Seleccionadas

Para este análisis, se han seleccionado productos y servicios
representativos del gasto diario de una persona promedio. Estas
categorías incluyen:

- Alimentos y bebidas: Pollo, Refrescos, frutas y verduras y leche.

- Transporte: Gasolina, transporte público.

- Vivienda y servicios: Renta de vivienda, electricidad, gas LP.

- Colegiaturas de Universidad.

La selección de estos elementos permite una aproximación al gasto mensual de un individuo, aunque sin ser una representación exhaustiva de todos los posibles costos en su vida cotidiana.


# Criterios de Selección de Datos

Para realizar el análisis, se aplicarán los siguientes criterios de
selección a los datos de precios promedio del INEGI:

1.  Selección de un único genérico por cada categoría de producto: Se
    elegirá el producto con el precio más bajo que tenga al menos 13
    observaciones registradas.

2.  Selección de una única especificación por cada genérico: Se
    seleccionará la especificación con el menor precio dentro del
    genérico elegido, simulando un consumo conservador.

3.  Generación de histogramas individuales: Se visualizará la
    distribución de los precios de cada especificación seleccionada
    mediante histogramas individuales.

4.  Cálculo de los cuartiles de cada histograma: Se calculará los
    cuartiles de los valores registrados en cada histograma como una
    medida representativa del costo del producto o servicio.

5.  Cálculo del gasto total: Se sumarán los valores esperados de todos
    los productos y servicios seleccionados para obtener una estimación
    del gasto mensual de un individuo promedio.

# Alcance y Limitaciones

Este análisis busca proporcionar un panorama general de la distribución de precios dentro del subgrupo de servicios evaluado. Sin embargo, las conclusiones no deben considerarse determinantes, debido a las siguientes razones:

- Valores Aproximados: Los precios utilizados son promedios y pueden no reflejar las variaciones regionales o temporales.

- Subconjunto Limitado: Solo se está considerando un subgrupo de productos y servicios, lo que no abarca la totalidad de los gastos de un individuo.

- Factores Externos: No se consideran otros elementos relevantes, como el acceso a subsidios, descuentos, o cambios económicos inesperados que puedan influir en los precios y salarios.

Este análisis no solo permitirá entender la capacidad adquisitiva de los
trabajadores, sino también identificar áreas de mejora en términos de
política salarial y estrategias de apoyo económico.

# Metodología

## Preprocesamiento de Datos

El preprocesamiento de los datos incluyó los siguientes pasos:

- Limpieza de datos: Se eliminaron valores faltantes y se normalizaron
  los nombres de las columnas para facilitar el análisis.

- Filtrado de productos: Se seleccionaron productos con al menos 13
  observaciones para garantizar robustez estadística.

- Cálculo de precios promedio: Se promediaron los precios de cada
  especificación para obtener una medida representativa.

## Análisis Estadístico

Se utilizaron las siguientes técnicas estadísticas:

- **Histogramas**: Un histograma es una representación gráfica de la
  distribución de un conjunto de datos continuos. Para un conjunto de
  datos $X={x_1,x_2,…,x_n}$, el histograma divide el rango de $X$ en
  intervalos (*bins*) y cuenta el número de observaciones que caen en
  cada intervalo. Formalmente, la altura de cada barra en el histograma
  se define como:
  $$h_k = \frac{\mbox{Número de observaciones en el intervalo k}}{\mbox{Ancho del intervalo k }}$$

En este análisis, los histogramas se utilizaron para visualizar la
distribución de los precios de cada producto, lo que permitió
identificar patrones, tendencias y valores atípicos.

- **Cuartiles**: Los cuartiles son medidas de posición que dividen un
  conjunto de datos ordenados en cuatro partes iguales. Para un conjunto
  de datos $X={x_1,x_2,…,x_n}$ ordenado de menor a mayor, los cuartiles
  se definen como:

- Mínimo:El valor más pequeño de la serie de datos.

- Primer cuartil ($Q_1$): El valor que deja el 25% de los datos por
  debajo de él.

- Segundo cuartil (Mediana): El valor que deja el 50% de los datos por
  debajo de él.

- Tercer cuartil ($Q_3$): El valor que deja el 75% de los datos por
  debajo de él.

- Máximo: El valor más grande de la serie de datos.

# Resultados Esperados

Se espera que los resultados muestren:

- Gasto mensual promedio: Una estimación del gasto mensual basado en los
  precios del INEGI.

# Preprocesamiento

```r
# Fuente:
# https://www.inegi.org.mx/app/preciospromedio/

# ------------------------
#  INSTALACIÓN
# ------------------------
install.packages("ggplot2",dependencies=TRUE)
install.packages("dplyr",dependencies=TRUE)
install.packages("stringr",dependencies=TRUE)
# ------------------------
#  CARGAR LIBRERÍAS Y DATOS
# ------------------------

# Cargar librerías necesarias
library(ggplot2)
library(dplyr)
library(stringr)
source("utils/utils.r")

# Cargar los datos
data <- read.csv("datasets/INP_PP_CAB18.CSV", sep = ",", header = TRUE, fileEncoding = "latin1")
```

```r
# ------------------------
#  EXPLORACIÓN INICIAL
# ------------------------

# Ver estructura del dataset
str(data)

# Resumen estadístico del dataset
summary(data)

# Primeras filas del dataset
head(data, n = 5)

# Renombrar columnas para eliminar caracteres especiales y espacios
colnames(data) <- make.names(colnames(data))

# Verificación de valores faltantes
a_count <- sapply(data, function(x) sum(is.na(x)))
print(a_count)

# Conteo de productos genéricos más frecuentes
gen_count <- data %>%  count(Genérico, sort = TRUE)
print(gen_count)
# Crear tabla con el número de especificaciones por cada genérico
tabla_especificaciones <- data %>%
  group_by(Genérico, Especificación) %>%
  summarise(Frecuencia = n(), .groups = "drop") %>%
  arrange(desc(Frecuencia))

# Imprimir la tabla de frecuencias
print(tabla_especificaciones)
```

```r
# ------------------------
#  PREPROCESAMIENTO DE DATOS
# ------------------------

# Ejecutar preprocesamiento
data_preprocesado <- preprocesar_datos(data)

# Ejecutar función para promediar las especificaciones
data_promediada <- promediar_especificaciones(data_preprocesado)
```

# Generación de gráficos

```r
# Cargar librerías necesarias
library(ggplot2)
library(dplyr)
library(stringr)
source("utils/utils.r")

# Cargar los datos
data_promediada <- read.csv("resultados_preprocesamiento/data_promediada.csv",
                 sep = ",", 
                 header = TRUE)


# Ejecutar la función para generar histogramas y calcular cuartiles
cuartiles_resultados <- generar_histogramas_y_cuartiles(data_promediada)


# Ejecutar la función para sumar cuartiles y mostrar costos
sumar_cuartiles("results/cuartiles_especificaciones.csv")
```

# Resultados del Análisis de Costos Mensuales

|                                                       |Genérico                      |Especificación                                         |        MIN|         Q1|    Mediana|         Q3|        MAX|
|:------------------------------------------------------|:-----------------------------|:------------------------------------------------------|----------:|----------:|----------:|----------:|----------:|
|HASS, A GRANEL                                         |Aguacate                      |HASS, A GRANEL                                         |   48.73375|   49.81375|   58.06875|   63.80375|   80.57875|
|ESTANDAR, A GRANEL                                     |Azúcar                        |ESTANDAR, A GRANEL                                     |   22.91143|   23.38571|   26.91143|   30.25000|   32.96429|
|BLANCA, A GRANEL                                       |Cebolla                       |BLANCA, A GRANEL                                       |   16.96000|   19.45125|   21.18500|   28.17000|   48.48500|
|TECATE, CLARA, ORIGINAL, BOTELLA DE 1200 ML            |Cerveza                       |TECATE, CLARA, ORIGINAL, BOTELLA DE 1200 ML            |   27.39000|   28.33000|   28.33000|   29.37000|   30.83000|
|PALL MALL , C/FILTRO, RED, CAJETILLA DE 25 PZAS        |Cigarrillos                   |PALL MALL , C/FILTRO, RED, CAJETILLA DE 25 PZAS        |   65.00000|   68.00000|   68.00000|   68.00000|   75.00000|
|CONSUMO DE 250 KWH                                     |Electricidad                  |CONSUMO DE 250 KWH                                     |  286.55000|  291.90000|  297.42500|  303.08000|  308.01000|
|MP, PINTO, BOLSA DE 900 GR                             |Frijol                        |MP, PINTO, BOLSA DE 900 GR                             |   22.22000|   25.00000|   33.33000|   33.33000|   39.44000|
|INDICE DE LA CIUDAD                                    |Gasolina de bajo octanaje     |INDICE DE LA CIUDAD                                    |   89.27000|   89.30000|  107.14000|  115.51000|  118.10000|
|BLANCO, A GRANEL                                       |Huevo                         |BLANCO, A GRANEL                                       |   36.37667|   39.54333|   42.82000|   47.89750|   49.40750|
|SALADETTE, A GRANEL                                    |Jitomate                      |SALADETTE, A GRANEL                                    |   20.81250|   22.33750|   25.74375|   29.58750|   53.66000|
|FORTI LECHE, RECONSTITUIDA, BOTE DE 1 LT               |Leche pasteurizada y fresca   |FORTI LECHE, RECONSTITUIDA, BOTE DE 1 LT               |   19.50000|   20.50000|   20.50000|   20.55000|   21.50000|
|GREAT VALUE MP, ULTRAPASTEURIZADA, BOTE DE 1 LT        |Leche pasteurizada y fresca   |GREAT VALUE MP, ULTRAPASTEURIZADA, BOTE DE 1 LT        |   19.50000|   20.50000|   20.50000|   23.45000|   23.50000|
|PERSA, A GRANEL                                        |Limón                         |PERSA, A GRANEL                                        |   17.97000|   21.88000|   26.43000|   30.51000|   43.83000|
|VALENCIA, A GRANEL                                     |Naranja                       |VALENCIA, A GRANEL                                     |   15.97333|   18.53333|   19.69222|   22.49556|   26.71889|
|CUOTAS DE ADMINISTRACION, DE UNIDAD HAB                |Otros servicios para el hogar |CUOTAS DE ADMINISTRACION, DE UNIDAD HAB                |  100.00000|  100.00000|  100.00000|  100.00000|  100.00000|
|MARADOL, A GRANEL                                      |Papaya                        |MARADOL, A GRANEL                                      |   24.21625|   25.24750|   26.11500|   26.51000|   30.20000|
|TABASCO, A GRANEL                                      |Plátanos                      |TABASCO, A GRANEL                                      |   17.22400|   18.95200|   20.49600|   21.81600|   24.57000|
|BACHOCO, ENTERO, A GRANEL                              |Pollo                         |BACHOCO, ENTERO, A GRANEL                              |   37.50000|   40.00000|   42.25000|   44.00000|   49.00000|
|JARRITOS, REFRESCO, BOTELLA DE 2000 ML                 |Refrescos envasados           |JARRITOS, REFRESCO, BOTELLA DE 2000 ML                 |    9.75000|    9.75000|   10.50000|   11.00000|   11.00000|
|COLEGIATURAS, INSCRIPCION Y OTRAS CUOTAS PARA UN CICLO |Universidad                   |COLEGIATURAS, INSCRIPCION Y OTRAS CUOTAS PARA UN CICLO | 4600.47167| 4668.26333| 4743.26333| 4759.93000| 4794.00000|




## Conclusión Final

Este análisis proporciona una estimación aproximada del costo mensual de
los productos y servicios esenciales en México, considerando tanto
gastos fijos como variables. Los resultados destacan la importancia de
gestionar adecuadamente los gastos fijos y optimizar los gastos
variables para mejorar el poder adquisitivo de los trabajadores.

# Fuentes

- INEGI: 

- CONASAMI: 
