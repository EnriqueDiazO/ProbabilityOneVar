################################################################################
# SCRIPT 1: LIMPIEZA Y EXPLORACIÓN BÁSICA (ESPECIALISTA EN DATASET)
################################################################################

#####################################
# 1. Cargar bibliotecas necesarias  #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿En qué medida coordinarás la comunicación y validación del uso de estas bibliotecas para el equipo?
# - ESPECIALISTA DE DATASET: ¿Estás familiarizado con los paquetes dplyr y tidyr para la manipulación y limpieza de datos?
# - ESPECIALISTA DE IMÁGENES: ¿Consideras alguna visualización previa de la estructura del dataset que te ayude a planificar tus gráficos?
# - AUXILIAR: ¿Requieres apoyo para instalar o verificar la compatibilidad de estas bibliotecas en el entorno de trabajo?

install.packages("readr", dependencies = TRUE)
install.packages("dplyr", dependencies = TRUE)
install.packages("tidyr", dependencies = TRUE)
install.packages("tidyverse", dependencies = TRUE)

library(readr)
library(dplyr)
library(tidyr)
library(tidyverse)
#####################################
# 2. Leer dataset                   #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Quién definirá los criterios de calidad para asegurar que el archivo CSV sea el correcto?
# - ESPECIALISTA DE DATASET: ¿Necesitas verificar la consistencia del archivo con la descripción de las variables?
# - ESPECIALISTA DE IMÁGENES: ¿Tienes interés en la estructura de datos para planificar tus visualizaciones?
# - AUXILIAR: ¿Tienes claro cómo documentar la carga del archivo y registrar este paso en la bitácora del proyecto?

# Asumiendo que el archivo está en la carpeta 'datasets'
oral_cancer_data <- read_csv("Proy_Oral_Cancer_Prediction/datasets/oral_cancer_prediction_dataset.csv", show_col_types = FALSE)

#####################################
# 3. Explorar estructura general    #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo se distribuirá la responsabilidad de revisar la integridad del dataset?
# - ESPECIALISTA DE DATASET: ¿Revisarás la correspondencia entre el nombre de cada variable y su posible significado?
# - ESPECIALISTA DE IMÁGENES: ¿Anticipas necesidad de gráficos específicos para variables numéricas o categóricas?
# - AUXILIAR: ¿Has registrado la información en el documento de soporte?

options(width = 200)
sink("resultados_preprocesamiento/estructura_oral_cancer_data.txt")
str(oral_cancer_data)
sink()

#####################################
# 4. Mostrar primeras filas         #
#####################################
options(width = 200)
sink("resultados_preprocesamiento/head_oral_cancer_data.txt")
head(oral_cancer_data)
sink()
################################################
# 5. Contar valores NA por variable            #
################################################
options(width = 200)
sink("resultados_preprocesamiento/na_oral_cancer_data.txt")
na_por_variable <- colSums(is.na(oral_cancer_data))
sink()
#################################################################
# 6. Limpieza de datos: eliminación de filas con valores NA     #
#################################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo se comunicarán los criterios de exclusión a todo el equipo?
# - ESPECIALISTA DE DATASET: ¿Has considerado la posibilidad de imputar valores en lugar de eliminarlos?
# - ESPECIALISTA DE IMÁGENES: ¿Deseas alguna visualización de los datos antes y después de la limpieza?
# - AUXILIAR: ¿Estás llevando un registro de cuántas filas se eliminan?

oral_cancer_data_limpio <- oral_cancer_data %>%
  drop_na()

##################################################################################
# 7. Identificación de variables cuantitativas y cualitativas                    #
##################################################################################

variables_cuantitativas <- oral_cancer_data_limpio %>%
  select(where(is.numeric)) %>%
  names()

variables_cualitativas <- oral_cancer_data_limpio %>%
  select(where(is.character)) %>%
  names()

##################################################################################
# 8. Exportación del dataset                                                    #
##################################################################################


# Guardar en formato CSV (limpio)
write_csv(oral_cancer_data_limpio, "resultados_preprocesamiento/oral_cancer_data_limpio.csv")

#####################################
# 9. Almacenar resultados en lista  #
#####################################

resultados_limpieza <- list(
  primeras_filas = head(oral_cancer_data_limpio),
  na_por_variable = na_por_variable,
  variables_cuantitativas = variables_cuantitativas,
  variables_cualitativas = variables_cualitativas
)

########################################
# 10. Mostrar resultados para revisión #
########################################

print(resultados_limpieza)
