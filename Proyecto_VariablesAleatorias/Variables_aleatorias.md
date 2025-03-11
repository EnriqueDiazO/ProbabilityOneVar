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

# Mostrar resumen de los datos procesados
summary(data_2024)
```

    ##  inicio_vigencia          zona          
    ##  Min.   :2024-01-01   Length:2          
    ##  1st Qu.:2024-01-01   Class :character  
    ##  Median :2024-01-01   Mode  :character  
    ##  Mean   :2024-01-01                     
    ##  3rd Qu.:2024-01-01                     
    ##  Max.   :2024-01-01                     
    ##  salario_minimo_general  albanileria   
    ##  Min.   :248.9          Min.   :287.2  
    ##  1st Qu.:280.4          1st Qu.:309.1  
    ##  Median :311.9          Median :331.0  
    ##  Mean   :311.9          Mean   :331.0  
    ##  3rd Qu.:343.4          3rd Qu.:353.0  
    ##  Max.   :374.9          Max.   :374.9  
    ##     boticas         buldozer    
    ##  Min.   :253.8   Min.   :300.8  
    ##  1st Qu.:284.1   1st Qu.:319.4  
    ##  Median :314.4   Median :337.9  
    ##  Mean   :314.4   Mean   :337.9  
    ##  3rd Qu.:344.6   3rd Qu.:356.4  
    ##  Max.   :374.9   Max.   :374.9  
    ##      cajero        cantinero    
    ##  Min.   :258.2   Min.   :263.5  
    ##  1st Qu.:287.4   1st Qu.:291.4  
    ##  Median :316.6   Median :319.2  
    ##  Mean   :316.6   Mean   :319.2  
    ##  3rd Qu.:345.7   3rd Qu.:347.1  
    ##  Max.   :374.9   Max.   :374.9  
    ##  carpintero_muebles    cocinero    
    ##  Min.   :282.4      Min.   :290.8  
    ##  1st Qu.:305.6      1st Qu.:311.8  
    ##  Median :328.7      Median :332.9  
    ##  Mean   :328.7      Mean   :332.9  
    ##  3rd Qu.:351.8      3rd Qu.:353.9  
    ##  Max.   :374.9      Max.   :374.9  
    ##    colchones        mosaico     
    ##  Min.   :266.1   Min.   :281.4  
    ##  1st Qu.:293.3   1st Qu.:304.8  
    ##  Median :320.5   Median :328.2  
    ##  Mean   :320.5   Mean   :328.2  
    ##  3rd Qu.:347.7   3rd Qu.:351.5  
    ##  Max.   :374.9   Max.   :374.9  
    ##      yesero      cortador_calzado
    ##  Min.   :268.0   Min.   :261.0   
    ##  1st Qu.:294.7   1st Qu.:289.5   
    ##  Median :321.5   Median :317.9   
    ##  Mean   :321.5   Mean   :317.9   
    ##  3rd Qu.:348.2   3rd Qu.:346.4   
    ##  Max.   :374.9   Max.   :374.9   
    ##  costurero_taller costurero_domicilio
    ##  Min.   :257.9    Min.   :264.6      
    ##  1st Qu.:287.1    1st Qu.:292.2      
    ##  Median :316.4    Median :319.8      
    ##  Mean   :316.4    Mean   :319.8      
    ##  3rd Qu.:345.6    3rd Qu.:347.3      
    ##  Max.   :374.9    Max.   :374.9      
    ##  chofer_acomodador chofer_camion  
    ##  Min.   :269.8     Min.   :293.1  
    ##  1st Qu.:296.1     1st Qu.:313.5  
    ##  Median :322.3     Median :334.0  
    ##  Mean   :322.3     Mean   :334.0  
    ##  3rd Qu.:348.6     3rd Qu.:354.4  
    ##  Max.   :374.9     Max.   :374.9  
    ##  chofer_camioneta  chofer_grua   
    ##  Min.   :284.8    Min.   :273.9  
    ##  1st Qu.:307.3    1st Qu.:299.2  
    ##  Median :329.8    Median :324.4  
    ##  Mean   :329.8    Mean   :324.4  
    ##  3rd Qu.:352.4    3rd Qu.:349.6  
    ##  Max.   :374.9    Max.   :374.9  
    ##      draga          ebanista    
    ##  Min.   :303.6   Min.   :286.5  
    ##  1st Qu.:321.4   1st Qu.:308.6  
    ##  Median :339.2   Median :330.7  
    ##  Mean   :339.2   Mean   :330.7  
    ##  3rd Qu.:357.1   3rd Qu.:352.8  
    ##  Max.   :374.9   Max.   :374.9  
    ##  electricista_instalaciones
    ##  Min.   :281.4             
    ##  1st Qu.:304.8             
    ##  Median :328.2             
    ##  Mean   :328.2             
    ##  3rd Qu.:351.5             
    ##  Max.   :374.9             
    ##  electricista_autos electricista_motores
    ##  Min.   :284.2      Min.   :273.9       
    ##  1st Qu.:306.8      1st Qu.:299.2       
    ##  Median :329.5      Median :324.4       
    ##  Mean   :329.5      Mean   :324.4       
    ##  3rd Qu.:352.2      3rd Qu.:349.6       
    ##  Max.   :374.9      Max.   :374.9       
    ##     gondola          bodega     
    ##  Min.   :253.1   Min.   :262.1  
    ##  1st Qu.:283.5   1st Qu.:290.3  
    ##  Median :314.0   Median :318.5  
    ##  Mean   :314.0   Mean   :318.5  
    ##  3rd Qu.:344.4   3rd Qu.:346.7  
    ##  Max.   :374.9   Max.   :374.9  
    ##   ferreterias       fogonero    
    ##  Min.   :267.4   Min.   :275.9  
    ##  1st Qu.:294.2   1st Qu.:300.7  
    ##  Median :321.1   Median :325.4  
    ##  Mean   :321.1   Mean   :325.4  
    ##  3rd Qu.:348.0   3rd Qu.:350.1  
    ##  Max.   :374.9   Max.   :374.9  
    ##    gasolinero       herreria    
    ##  Min.   :257.9   Min.   :277.8  
    ##  1st Qu.:287.1   1st Qu.:302.1  
    ##  Median :316.4   Median :326.3  
    ##  Mean   :316.4   Mean   :326.3  
    ##  3rd Qu.:345.6   3rd Qu.:350.6  
    ##  Max.   :374.9   Max.   :374.9  
    ##   hojalateria      lubricador   
    ##  Min.   :282.4   Min.   :259.8  
    ##  1st Qu.:305.6   1st Qu.:288.6  
    ##  Median :328.7   Median :317.4  
    ##  Mean   :328.7   Mean   :317.4  
    ##  3rd Qu.:351.8   3rd Qu.:346.1  
    ##  Max.   :374.9   Max.   :374.9  
    ##    manejador     maquinaria_agricola
    ##  Min.   :250.4   Min.   :288.6      
    ##  1st Qu.:281.5   1st Qu.:310.2      
    ##  Median :312.6   Median :331.7      
    ##  Mean   :312.6   Mean   :331.7      
    ##  3rd Qu.:343.8   3rd Qu.:353.3      
    ##  Max.   :374.9   Max.   :374.9      
    ##  maquina_madera  mecanico_autos 
    ##  Min.   :275.9   Min.   :296.6  
    ##  1st Qu.:300.7   1st Qu.:316.2  
    ##  Median :325.4   Median :335.7  
    ##  Mean   :325.4   Mean   :335.7  
    ##  3rd Qu.:350.1   3rd Qu.:355.3  
    ##  Max.   :374.9   Max.   :374.9  
    ##  montador_calzado    peinador    
    ##  Min.   :261.0    Min.   :269.8  
    ##  1st Qu.:289.5    1st Qu.:296.1  
    ##  Median :317.9    Median :322.3  
    ##  Mean   :317.9    Mean   :322.3  
    ##  3rd Qu.:346.4    3rd Qu.:348.6  
    ##  Max.   :374.9    Max.   :374.9  
    ##   pintor_autos    pintor_casas  
    ##  Min.   :277.8   Min.   :275.9  
    ##  1st Qu.:302.1   1st Qu.:300.7  
    ##  Median :326.3   Median :325.4  
    ##  Mean   :326.3   Mean   :325.4  
    ##  3rd Qu.:350.6   3rd Qu.:350.1  
    ##  Max.   :374.9   Max.   :374.9  
    ##    planchador       plomero     
    ##  Min.   :258.2   Min.   :276.4  
    ##  1st Qu.:287.4   1st Qu.:301.0  
    ##  Median :316.6   Median :325.7  
    ##  Mean   :316.6   Mean   :325.7  
    ##  3rd Qu.:345.7   3rd Qu.:350.3  
    ##  Max.   :374.9   Max.   :374.9  
    ##  radiotecnico_electrico   recamarero   
    ##  Min.   :286.5          Min.   :253.1  
    ##  1st Qu.:308.6          1st Qu.:283.5  
    ##  Median :330.7          Median :314.0  
    ##  Mean   :330.7          Mean   :314.0  
    ##  3rd Qu.:352.8          3rd Qu.:344.4  
    ##  Max.   :374.9          Max.   :374.9  
    ##  refaccionaria_autos reparador_hogar
    ##  Min.   :262.1       Min.   :272.9  
    ##  1st Qu.:290.3       1st Qu.:298.4  
    ##  Median :318.5       Median :323.9  
    ##  Mean   :318.5       Mean   :323.9  
    ##  3rd Qu.:346.7       3rd Qu.:349.4  
    ##  Max.   :374.9       Max.   :374.9  
    ##    reportero     reportero_grafico
    ##  Min.   :557.4   Min.   :557.4    
    ##  1st Qu.:557.4   1st Qu.:557.4    
    ##  Median :557.4   Median :557.4    
    ##  Mean   :557.4   Mean   :557.4    
    ##  3rd Qu.:557.4   3rd Qu.:557.4    
    ##  Max.   :557.4   Max.   :557.4    
    ##    repostero     sastreria_domicilio
    ##  Min.   :287.2   Min.   :288.6      
    ##  1st Qu.:309.1   1st Qu.:310.2      
    ##  Median :331.0   Median :331.7      
    ##  Mean   :331.0   Mean   :331.7      
    ##  3rd Qu.:353.0   3rd Qu.:353.3      
    ##  Max.   :374.9   Max.   :374.9      
    ##    secretaria    soldador_soplete
    ##  Min.   :296.0   Min.   :284.2   
    ##  1st Qu.:315.7   1st Qu.:306.8   
    ##  Median :335.4   Median :329.5   
    ##  Mean   :335.4   Mean   :329.5   
    ##  3rd Qu.:355.2   3rd Qu.:352.2   
    ##  Max.   :374.9   Max.   :374.9   
    ##    tablajero     tapicero_autos 
    ##  Min.   :269.8   Min.   :273.9  
    ##  1st Qu.:296.1   1st Qu.:299.2  
    ##  Median :322.3   Median :324.4  
    ##  Mean   :322.3   Mean   :324.4  
    ##  3rd Qu.:348.6   3rd Qu.:349.6  
    ##  Max.   :374.9   Max.   :374.9  
    ##  tapicero_muebles trabajador_social
    ##  Min.   :273.9    Min.   :320.6    
    ##  1st Qu.:299.2    1st Qu.:334.2    
    ##  Median :324.4    Median :347.8    
    ##  Mean   :324.4    Mean   :347.8    
    ##  3rd Qu.:349.6    3rd Qu.:361.3    
    ##  Max.   :374.9    Max.   :374.9    
    ##     vaquero         velador     
    ##  Min.   :253.1   Min.   :257.9  
    ##  1st Qu.:283.5   1st Qu.:287.1  
    ##  Median :314.0   Median :316.4  
    ##  Mean   :314.0   Mean   :316.4  
    ##  3rd Qu.:344.4   3rd Qu.:345.6  
    ##  Max.   :374.9   Max.   :374.9  
    ##  vendedor_piso      zapatero    
    ##  Min.   :264.6   Min.   :261.0  
    ##  1st Qu.:292.2   1st Qu.:289.5  
    ##  Median :319.8   Median :317.9  
    ##  Mean   :319.8   Mean   :317.9  
    ##  3rd Qu.:347.3   3rd Qu.:346.4  
    ##  Max.   :374.9   Max.   :374.9

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
