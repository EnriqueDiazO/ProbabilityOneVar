################################################################################
# SCRIPT 1: LIMPIEZA Y EXPLORACIÓN BÁSICA DEL DATASET
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

library(readr)
library(dplyr)
library(tidyr)

#####################################
# 2. Leer dataset                   #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Quién definirá los criterios de calidad para asegurar que el archivo CSV sea el correcto?
# - ESPECIALISTA DE DATASET: ¿Necesitas verificar la consistencia del archivo con la descripción de las variables?
# - ESPECIALISTA DE IMÁGENES: ¿Tienes interés en la estructura de datos (ej. cantidad de categorías) para planificar tus visualizaciones?
# - AUXILIAR: ¿Tienes claro cómo documentar la carga del archivo y registrar este paso en la bitácora del proyecto?

education_data <- read_csv("datasets/education_career_success.csv", show_col_types = FALSE)

#####################################
# 3. Explorar estructura general    #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo se distribuirá la responsabilidad de revisar la integridad del dataset?
# - ESPECIALISTA DE DATASET: ¿Revisarás la correspondencia entre el nombre de cada variable y su posible significado?
# - ESPECIALISTA DE IMÁGENES: ¿Anticipas la necesidad de gráficos específicos para variables numéricas o categóricas?
# - AUXILIAR: ¿Has registrado la información en el documento de soporte para que el equipo la consulte luego?

options(width = 600)
sink("resultados_preprocesamiento/1_estructura_education_dataset.txt")
str(education_data)
sink()

#####################################
# 4. Mostrar primeras filas         #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo verificarás que la muestra inicial del dataset cumple con el objetivo del proyecto?
# - ESPECIALISTA DE DATASET: ¿Qué variables saltan a la vista como candidatas a limpieza?
# - ESPECIALISTA DE IMÁGENES: ¿Notas algún patrón que requiera una representación gráfica inmediata?
# - AUXILIAR: ¿Has anotado las observaciones relevantes para el reporte final?

head(education_data)

################################################
# 5. Contar valores NA por variable            #
################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Planearás una reunión para discutir el impacto de los valores NA en el análisis?
# - ESPECIALISTA DE DATASET: ¿Cuál es tu criterio para decidir la eliminación o imputación de valores NA?
# - ESPECIALISTA DE IMÁGENES: ¿Te gustaría un gráfico que muestre la proporción de valores faltantes por columna?
# - AUXILIAR: ¿Cómo documentarás cada decisión de limpieza en el repositorio?

na_por_variable <- colSums(is.na(education_data))


options(width = 200)
sink("resultados_preprocesamiento/2_na_por_variable.txt")
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

education_data_limpio <- education_data %>%
  drop_na()

##################################################################################
# 7. Identificación de variables cuantitativas y cualitativas                    #
##################################################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cuál será la importancia de diferenciar variables para el plan de análisis general?
# - ESPECIALISTA DE DATASET: ¿Considerarás recodificar alguna variable de texto en factor para facilitar análisis futuros?
# - ESPECIALISTA DE IMÁGENES: ¿Qué tipos de gráficos podrías usar para las variables cuantitativas vs. cualitativas?
# - AUXILIAR: ¿Registarás las decisiones sobre clasificación de variables en el documento final?

variables_cuantitativas <- education_data_limpio %>%
  select(where(is.numeric)) %>%
  names()

print(variables_cuantitativas)

variables_cualitativas <- education_data_limpio %>%
  select(where(is.character)) %>%
  names()

print(variables_cualitativas)
##################################################################################
# 8. Exportación del dataset                                                    #
##################################################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Han acordado con el equipo si es posible abrir el CSV en otro software (Excel, Google Sheets) para validación externa?
# - ESPECIALISTA DE DATASET: ¿Se considerará recodificar variables para facilitar el análisis en entornos ajenos a R?
# - ESPECIALISTA DE IMÁGENES: ¿Crees conveniente revisar cómo se verán las categorías y valores para confirmar que las columnas no se descuadren?
# - AUXILIAR: ¿Probarás la apertura de este archivo en un software externo y documentarás los resultados?


# 1. Guardar dataset limpio en un CSV
write_csv(education_data_limpio, "resultados_preprocesamiento/education_data_limpio.csv")

# 2. Almacenar los resultados en una lista
resultados_limpieza <- list(
  primeras_filas = head(education_data_limpio),
  na_por_variable = na_por_variable,
  variables_cuantitativas = variables_cuantitativas,
  variables_cualitativas = variables_cualitativas
)

########################################
# 9. Mostrar resultados para revisión  #
########################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo se evaluará y distribuirá esta información en la próxima reunión?
# - ESPECIALISTA DE DATASET: ¿Necesitas apoyo de otro rol para validar las conclusiones de la limpieza?
# - ESPECIALISTA DE IMÁGENES: ¿Te resulta útil este resumen para planificar cuáles gráficos elaborar?
# - AUXILIAR: ¿Vas a generar un reporte automatizado con estos resultados?

print(resultados_limpieza)
