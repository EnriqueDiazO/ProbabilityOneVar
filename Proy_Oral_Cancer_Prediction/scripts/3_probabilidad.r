################################################################################
# SCRIPT 3: CÁLCULO DE PROBABILIDADES EN ORAL_CANCER_DATA_LIMPIO
################################################################################

#####################################
# 0. Crear carpetas de resultados   #
#####################################

# Si deseas guardar resultados de probabilidad en algún directorio específico, créalo:
if (!dir.exists("resultados_probabilidad")) {
  dir.create("resultados_probabilidad", recursive = TRUE)
}

#####################################
# 1. Cargar bibliotecas necesarias  #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo se integrarán estos resultados con las decisiones de salud o diagnóstico?
# - ESPECIALISTA DE DATASET: ¿Verificarás la consistencia de la variable 'Diagnosis' (Malignant/Benign)?
# - ESPECIALISTA DE IMÁGENES: ¿Planeas representar las probabilidades en un diagrama de barras?
# - AUXILIAR: ¿Registrarás en la bitácora cada paso realizado?

library(readr)
library(dplyr)

#####################################
# 2. Leer dataset limpio            #
#####################################

oral_cancer_data_limpio <- read_csv(
  "resultados_preprocesamiento/oral_cancer_data_limpio.csv",
  show_col_types = FALSE
)

#############################################
# 3. Calcular Probabilidades Condicionales  #
#############################################

# Ejemplo 1: P(Diagnosis = 'Yes' | TobaccoUse = 'Yes')
sub_tobacco <- oral_cancer_data_limpio %>%
  filter(`Tobacco Use` == "Yes")

n_tobacco_total <- nrow(sub_tobacco)
n_tobacco_malignant <- sub_tobacco %>%
  filter(`Early Diagnosis` == "Yes") %>%
  nrow()

p_malignant_given_tobacco <- n_tobacco_malignant / n_tobacco_total

# Ejemplo 2: P(Diagnosis = 'Yes' | AlcoholUse = 'Yes')
sub_alcohol <- oral_cancer_data_limpio %>%
  filter(`Alcohol Consumption` == "Yes")

n_alcohol_total <- nrow(sub_alcohol)
n_alcohol_malignant <- sub_alcohol %>%
  filter(`Early Diagnosis` == "Yes") %>%
  nrow()

p_malignant_given_alcohol <- n_alcohol_malignant / n_alcohol_total

############################################################
# 4. Almacenar y mostrar los resultados en una lista       #
############################################################

resultados_probabilidad <- list(
  p_malignant_given_tobacco  = p_malignant_given_tobacco,
  n_tobacco_total            = n_tobacco_total,
  p_malignant_given_alcohol  = p_malignant_given_alcohol,
  n_alcohol_total            = n_alcohol_total
)

print(resultados_probabilidad)

# (Opcional) Guardar estos resultados en un archivo de texto
sink("resultados_probabilidad/probabilidades_oral_cancer.txt")
print(resultados_probabilidad)
sink()
