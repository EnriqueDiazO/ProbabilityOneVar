################################################################################
# SCRIPT 2: ANÁLISIS EXPLORATORIO DE DATOS (EDA) - Versión Interactiva
################################################################################

#####################################
# 0. Crear carpetas de resultados   #
#####################################

# Creamos la carpeta 'resultados_analisis_estadistico' si no existe.
if (!dir.exists("resultados_analisis_estadistico")) {
  dir.create("resultados_analisis_estadistico", recursive = TRUE)
}

#####################################
# 1. Cargar bibliotecas necesarias  #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cuál es el objetivo principal de este EDA?
# - ESPECIALISTA DE DATASET: ¿Te asegurarás de que no queden NA tras la limpieza?
# - ESPECIALISTA DE IMÁGENES: ¿Qué tipo de gráficos (histogramas, boxplots, etc.) planeas?
# - AUXILIAR: ¿Registrarás en la bitácora cada paquete y función utilizadas?

install.packages("ggplot2", dependencies = TRUE)
install.packages("plotly", dependencies = TRUE)
install.packages("summarytools", dependencies = TRUE)

library(readr)
library(dplyr)
library(ggplot2)
library(plotly)
library(summarytools)

#####################################
# 2. Leer dataset limpio            #
#####################################

oral_cancer_data_limpio <- read_csv(
  "resultados_preprocesamiento/oral_cancer_data_limpio.csv",
  show_col_types = FALSE
)

#########################################
# 3. Estadísticas descriptivas generales #
#########################################

resumen_general <- summary(oral_cancer_data_limpio)

sink("resultados_analisis_estadistico/1_summary_all_columns.txt")
print(resumen_general)
sink()

descr(oral_cancer_data_limpio) 

###########################################################
# 4. EDA Interactivo (ejemplo con columna 'Age')          #
###########################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Por qué es relevante 'Age' para el análisis del cáncer oral?
# - ESPECIALISTA DE DATASET: ¿Necesitas alguna transformación (log, etc.) para la variable 'Age'?
# - ESPECIALISTA DE IMÁGENES: ¿Qué estilo o tema de ggplot se va a usar?
# - AUXILIAR: ¿Archivarás las gráficas interactivas generadas?

# Supongamos que 'Age' es una variable numérica de interés
age_vector <- oral_cancer_data_limpio$Age

mean_age <- mean(age_vector)
median_age <- median(age_vector)
sd_age <- sd(age_vector)
quantiles_age <- quantile(age_vector, probs = c(0.25, 0.5, 0.75, 0.9, 0.95))

estadisticas_age <- list(
  media     = mean_age,
  mediana   = median_age,
  sd        = sd_age,
  quantiles = quantiles_age
)

p_hist_age <- ggplot(oral_cancer_data_limpio, aes(x = Age)) +
  geom_histogram(bins = 15, fill = "lightblue", color = "black") +
  labs(
    title = "Histograma de Age",
    x = "Edad (Años)",
    y = "Frecuencia"
  ) +
  theme_minimal()

hist_age_interactivo <- ggplotly(p_hist_age)

p_box_age <- ggplot(oral_cancer_data_limpio, aes(y = Age)) +
  geom_boxplot(fill = "lightgreen") +
  labs(
    title = "Boxplot de Age",
    y = "Edad (Años)"
  ) +
  theme_minimal()

box_age_interactivo <- ggplotly(p_box_age)

###############################################################
# 5. EDA con barplots (ejemplo con 'TobaccoUse')             #
###############################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Se requiere analizar la prevalencia de 'TobaccoUse'?
# - ESPECIALISTA DE DATASET: ¿Está codificada correctamente la columna 'TobaccoUse' (Sí/No, 1/0, etc.)?
# - ESPECIALISTA DE IMÁGENES: ¿Te interesa una paleta de colores distinta?
# - AUXILIAR: ¿Anotarás en la bitácora las interpretaciones?
tabla_tobacco <- table(oral_cancer_data_limpio$`Tobacco Use`)
df_tobacco <- as.data.frame(tabla_tobacco)
colnames(df_tobacco) <- c("TobaccoUse", "Freq")

p_bar_tobacco <- ggplot(df_tobacco, aes(x = TobaccoUse, y = Freq)) +
  geom_bar(stat = "identity", fill = "orange") +
  labs(
    title = "Frecuencia de TobaccoUse",
    x = "Uso de Tabaco",
    y = "Frecuencia"
  ) +
  theme_minimal()

bar_tobacco_interactivo <- ggplotly(p_bar_tobacco)


#######################################################################################
# 6. Almacenar los resultados de EDA en una lista para posterior uso/presentación     #
#######################################################################################

resultados_eda <- list(
  resumen_general     = resumen_general,
  estadisticas_age    = estadisticas_age,
  tabla_tobacco       = tabla_tobacco
)

print(resultados_eda)

# Mostrar gráficos interactivos
hist_age_interactivo
box_age_interactivo
bar_tobacco_interactivo
