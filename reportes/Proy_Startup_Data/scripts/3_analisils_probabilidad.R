################################################################################
# SCRIPT 3: CÁLCULOS DE PROBABILIDAD CONDICIONAL USANDO TABLA DE CONTINGENCIA
################################################################################

#####################################
# 1. Cargar bibliotecas necesarias  #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo se integrará este análisis con los objetivos globales del proyecto?
# - ESPECIALISTA DE DATASET: ¿Podrías requerir una codificación adicional para estandarizar la columna Industry?
# - ESPECIALISTA DE IMÁGENES: ¿Planeas representar los resultados de la tabla de contingencia en algún tipo de gráfico?
# - AUXILIAR: ¿Documentarás cada paso de este procedimiento en el repositorio?

library(readr)
library(dplyr)

#####################################
# 2. Leer dataset limpio            #
#####################################

startup_data_limpio <- read_csv(
  "resultados_preprocesamiento/startup_data_limpio.csv",
  show_col_types = FALSE
)

#############################################
# 3. Tabla de contingencia y probabilidad  #
#############################################

# Queremos: P(Profitable = 1 | Industry = 'IoT').
# Para ello, creamos una tabla de contingencia 2x2:
# Filas: si la startup es IoT o no
# Columnas: si la startup es rentable (Profitable=1) o no (Profitable=0)

# 3.1 Construir una variable lógica para IoT
startup_data_limpio <- startup_data_limpio %>%
  mutate(IsIoT = if_else(Industry == "IoT", "IoT", "No_IoT"))

# 3.2 Crear tabla de contingencia
tabla_contingencia <- table(
  IsIoT = startup_data_limpio$IsIoT,
  Profitable = startup_data_limpio$Profitable
)

# Visualizar la tabla
tabla_contingencia

# La tabla tendrá la forma:

# Leer /resultados_probabilidad/explicacion.txt



########################################
# 4. Calcular la probabilidad condicional
########################################

# P(Profitable=1 | Industry=IoT) = (# de IoT rentables) / (# de IoT totales)

# Extraemos los valores de la tabla:
# - Filas: IoT y No_IoT
# - Columnas: Profitable 0, 1

num_iot_profitable <- tabla_contingencia["IoT", "1"]
num_iot_total      <- sum(tabla_contingencia["IoT", ])

p_profitable_given_iot <- num_iot_profitable / num_iot_total

#########################################################
# 5. (Opcional) Otra probabilidad: P(IoT | Profitable=1)
#########################################################

num_profitable_1 <- sum(tabla_contingencia[, "1"])     # total de rentables
num_iot_rentables<- tabla_contingencia["IoT", "1"]     # ya se obtuvo arriba

p_iot_given_profitable <- num_iot_rentables / num_profitable_1

############################################################
# 6. Almacenar resultados en una lista y mostrar           #
############################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo se integrarán estos resultados en la toma de decisiones?
# - ESPECIALISTA DE DATASET: ¿Te interesaría estandarizar la escritura de 'IoT' vs 'iot' para evitar confusiones?
# - ESPECIALISTA DE IMÁGENES: ¿Crees que un gráfico de barras o un mosaic plot ayudaría a visualizar la tabla de contingencia?
# - AUXILIAR: ¿Registrarás este análisis y sus resultados en un informe final?

resultados_prob_condicional <- list(
  tabla_contingencia          = tabla_contingencia,
  p_profitable_given_iot      = p_profitable_given_iot,
  p_iot_given_profitable      = p_iot_given_profitable
)

print(resultados_prob_condicional)
