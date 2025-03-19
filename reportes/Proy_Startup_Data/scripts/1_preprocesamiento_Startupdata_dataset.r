# Script de Limpieza y Exploración Básica del Dataset (Especialista en Dataset)

#####################################
# 1. Cargar bibliotecas necesarias  #
#####################################

# Preguntas para:
# - LÍDER DE PROYECTO: ¿En qué medida coordinarás la comunicación y validación del uso de estas bibliotecas para el equipo?
# - ESPECIALISTA DE DATASET: ¿Estás familiarizado con los paquetes dplyr y tidyr para la manipulación y limpieza de datos?

# Instalaciones previas
install.packages(readr,dependencies = TRUE)
install.packages(dplyr,dependencies = TRUE)
install.packages(tidyr,dependencies = TRUE)

# Importación
library(readr)
library(dplyr)
library(tidyr)

#####################################
# 2. Leer dataset                   #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Quién definirá los criterios de calidad para asegurar que el archivo CSV sea el correcto?
# - ESPECIALISTA DE DATASET: ¿Necesitas verificar la consistencia del archivo con la descripción de las variables?
# - ESPECIALISTA DE IMÁGENES: ¿Tienes interés en la estructura de datos (por ejemplo, cantidad de categorías) para planificar tus visualizaciones?
# - AUXILIAR: ¿Tienes claro cómo documentar la carga del archivo y registrar este paso en la bitácora del proyecto?

startup_data <- read_csv("datasets/startup_data.csv", show_col_types = FALSE)

#####################################
# 3. Explorar estructura general    #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo se distribuirá la responsabilidad de revisar la integridad del dataset?
# - ESPECIALISTA DE DATASET: ¿Revisarás la correspondencia entre el nombre de cada variable y su posible significado?
# - ESPECIALISTA DE IMÁGENES: ¿Anticipas la necesidad de gráficos específicos para variables numéricas o categóricas?
# - AUXILIAR: ¿Has registrado la información en el documento de soporte para que el equipo la consulte luego?

# Para asegurarnos de guardar la salida de str() en un archivo de texto completo
options(width = 600)
sink("resultados_preprocesamiento/1_estructura_dataset.txt")
str(startup_data)
sink()

#####################################
# 4. Mostrar primeras filas         #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo verificarás que la muestra inicial del dataset cumple con el objetivo del proyecto?
# - ESPECIALISTA DE DATASET: ¿Qué variables saltan a la vista como candidatas a limpieza?
# - ESPECIALISTA DE IMÁGENES: ¿Notas algún patrón que requiera una representación gráfica inmediata?
# - AUXILIAR: ¿Has anotado las observaciones relevantes para el reporte final?

options(width = 600)
sink("resultados_preprocesamiento/2_head_dataset.txt")
head(startup_data)
sink()


################################################
# 5. Contar valores NA por variable            #
################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Planearás una reunión para discutir el impacto de los valores NA en el análisis?
# - ESPECIALISTA DE DATASET: ¿Cuál es tu criterio para decidir la eliminación o imputación de valores NA?
# - ESPECIALISTA DE IMÁGENES: ¿Ves la necesidad de un gráfico que muestre la proporción de valores faltantes por columna?
# - AUXILIAR: ¿Cómo documentarás cada decisión de limpieza en el repositorio?

na_por_variable <- colSums(is.na(startup_data))

options(width = 200)
sink("resultados_preprocesamiento/3_na_por_variable.txt")
print(na_por_variable)
sink()


#################################################################
# 6. Limpieza de datos: eliminación de filas con valores NA     #
#################################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo se comunicarán los criterios de exclusión a todo el equipo?
# - ESPECIALISTA DE DATASET: ¿Has considerado la posibilidad de imputar valores en lugar de eliminarlos?
# - ESPECIALISTA DE IMÁGENES: ¿Deseas alguna visualización de los datos antes y después de la limpieza?
# - AUXILIAR: ¿Estás llevando un registro de cuántas filas se eliminan para el informe final?

startup_data_limpio <- startup_data %>%
  drop_na()

##################################################################################
# 7. Identificación de variables cuantitativas y cualitativas                    #
##################################################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cuál será la importancia de diferenciar variables para el plan de análisis general?
# - ESPECIALISTA DE DATASET: ¿Considerarás recodificar alguna variable de texto en factor para facilitar análisis futuros?
# - ESPECIALISTA DE IMÁGENES: ¿Qué tipos de gráficos podrías usar para las variables cuantitativas vs. cualitativas?
# - AUXILIAR: ¿Registarás las decisiones sobre clasificación de variables en el documento final?

variables_cuantitativas <- startup_data_limpio %>%
  select(where(is.numeric)) %>%
  names()

print(variables_cuantitativas)

variables_cualitativas <- startup_data_limpio %>%
  select(where(is.character)) %>%
  names()

print(variables_cualitativas)


##################################################################################
# 8. Exportación del dataset
##################################################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Han acordado con el equipo si es posible abrir el CSV en otro software (por ejemplo, Excel o Google Sheets) para validación externa?
# - ESPECIALISTA DE DATASET: ¿Se considerará guardar el archivo en otro formato facilitar el análisis en entornos ajenos a R?
# - ESPECIALISTA DE IMÁGENES: ¿Crees conveniente revisar cómo se verán las categorías y valores para confirmar que las columnas no se descuadren?
# - AUXILIAR: ¿Te encargarás de probar la apertura de este archivo en un software externo y documentar los resultados?


# Exportamos el dataset sin valores NA
write_csv(startup_data_limpio, "resultados_preprocesamiento/startup_data_limpio.csv")
