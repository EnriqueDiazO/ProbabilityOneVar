################################################################################
# SCRIPT 2: ANÁLISIS EXPLORATORIO DE DATOS (EDA) - Versión Interactiva con Plotly
################################################################################

#####################################
# 1. Cargar bibliotecas necesarias  #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Quién se encargará de validar que las herramientas gráficas y estadísticas cumplan con el propósito del proyecto?
# - ESPECIALISTA DE DATASET: ¿Estás revisando la coherencia de los valores antes de generar visualizaciones?
# - ESPECIALISTA DE IMÁGENES: ¿Qué formatos de visualización se acordaron para presentar los resultados (PDF, diapositivas, etc.)?
# - AUXILIAR: ¿Realizarás pruebas de compatibilidad de paquetes y registrarás la información sobre su uso?

install.packages(plotly, dependencies = TRUE)
install.packages(summarytools, dependencies = TRUE)

library(readr)        # Para lectura de datos
library(dplyr)        # Para manipulación de datos
library(summarytools) # Para estadísticas descriptivas detalladas (opcional)
library(plotly)       # Para gráficos interactivos

#####################################
# 2. Leer dataset limpio            #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Se definió la ruta de almacenamiento de forma clara para todos?
# - ESPECIALISTA DE DATASET: ¿Validarás nuevamente que no existan NA en el dataset limpio?
# - ESPECIALISTA DE IMÁGENES: ¿Necesitas coordinar con el especialista de dataset qué variables son prioritarias para graficar?
# - AUXILIAR: ¿Te encargarás de documentar en la bitácora la confirmación de la lectura exitosa?

startup_data_limpio <- read_csv("resultados_preprocesamiento/startup_data_limpio.csv",
  show_col_types = FALSE
)

#########################################
# 3. Estadísticas descriptivas generales #
#########################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo se definirá el alcance de este análisis en la siguiente reunión?
# - ESPECIALISTA DE DATASET: ¿Identificaste valores extremos que necesiten revisión más detallada?
# - ESPECIALISTA DE IMÁGENES: ¿Hay alguna visualización inicial que quieras proponer para las estadísticas?
# - AUXILIAR: ¿Has considerado la automatización de estos reportes estadísticos?

# 3.1 Generar un resumen rápido de todo el dataset
resumen_general <- summary(startup_data_limpio)
options(width = 800)
sink("resultados_analisis_estadistico/1_summary_all_columns.txt")
print(resumen_general)
sink()

# 3.2 Alternativa más detallada usando summarytools (opcional)
options(width = 400)
sink("resultados_analisis_estadistico/2_descr_all_columns.txt")
descr(startup_data_limpio)
sink()

###########################################################
# 4. EDA para variable principal en industria IoT         #
###########################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Están de acuerdo en que Market Share (%) para IoT sea la variable clave para el análisis de probabilidad?
# - ESPECIALISTA DE DATASET: ¿Filtrarás otras industrias más adelante para compararlas con IoT?
# - ESPECIALISTA DE IMÁGENES: ¿Necesitas un gráfico comparativo entre la industria IoT y otras industrias?
# - AUXILIAR: ¿Mantendrás registros de todas las gráficas generadas para IoT?

# 4.1 Filtramos solo las filas de la industria IoT
iot_data <- startup_data_limpio %>%
  filter(Industry == "IoT")

# 4.2 Cálculo de estadísticas descriptivas (tendencia central, dispersión, percentiles)
market_share_iot <- iot_data$`Market Share (%)`

media_ms_iot     <- mean(market_share_iot)
mediana_ms_iot   <- median(market_share_iot)
sd_ms_iot        <- sd(market_share_iot)
var_ms_iot       <- var(market_share_iot)
quantiles_ms_iot <- quantile(market_share_iot, probs = c(0.25, 0.5, 0.75, 0.9, 0.95))

# Almacenar en una lista
estadisticas_market_share_iot <- list(
  media               = media_ms_iot,
  mediana             = mediana_ms_iot,
  desviacion_estandar = sd_ms_iot,
  varianza            = var_ms_iot,
  quantiles           = quantiles_ms_iot
)

# 4.3 Histograma con ggplot + ggplotly
p_hist_iot <- ggplot(iot_data, aes(x = `Market Share (%)`)) +
  geom_histogram(
    bins = 10,
    fill = "lightblue",
    color = "black"
  ) +
  labs(
    title = "Histograma de Market Share (%) en IoT",
    x = "% de participación de mercado (IoT)",
    y = "Frecuencia"
  ) +
  theme_minimal()

# Para hacerlo interactivo, usamos ggplotly()
hist_iot_interactivo <- ggplotly(p_hist_iot)
print(hist_iot_interactivo)

# 4.4 Boxplot con ggplot + ggplotly
p_box_iot <- ggplot(iot_data, aes(y = `Market Share (%)`)) +
  geom_boxplot(
    fill = "lightgreen"
  ) +
  labs(
    title = "Boxplot de Market Share (%) en IoT",
    y = "% de participación de mercado (IoT)"
  ) +
  theme_minimal()

box_iot_interactivo <- ggplotly(p_box_iot)
print(box_iot_interactivo)


###############################################################
# 5. EDA con barplots y tablas de frecuencia en IoT           #
###############################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Existe algún requerimiento sobre el número o tipo de gráficos que se deben presentar?
# - ESPECIALISTA DE DATASET: ¿Te interesa una tabla de frecuencias para comprender la distribución de otras variables en IoT?
# - ESPECIALISTA DE IMÁGENES: ¿Deseas personalizar los colores o la estética de las gráficas para una presentación?
# - AUXILIAR: ¿Te encargarás de organizar los gráficos producidos en una carpeta compartida?

# 5.1 Tabla de frecuencias para una variable categórica relevante en IoT
#     (por ejemplo, la variable 'Exit Status')
tabla_exit_iot <- table(iot_data$`Exit Status`)
print(tabla_exit_iot)

# 5.2 Creación de un barplot interactivo para 'Exit Status' en la industria IoT
# Convertimos la tabla en data frame para Plotly
df_exit_iot <- as.data.frame(tabla_exit_iot)
colnames(df_exit_iot) <- c("ExitStatus", "Frequency")

bar_exit_iot <- plot_ly(
  data = df_exit_iot,
  x    = ~ExitStatus,
  y    = ~Frequency,
  type = "bar"
) %>%
  layout(
    title = "Frecuencia por Exit Status (IoT)",
    xaxis = list(title = "Tipo de Exit Status"),
    yaxis = list(title = "Frecuencia")
  )

print(bar_exit_iot)

#######################################################################################
# 6. Almacenar los resultados de EDA en una lista para posterior uso/presentación     #
#######################################################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿En qué momento del cronograma se discutirán estos resultados con el equipo?
# - ESPECIALISTA DE DATASET: ¿Necesitas retroalimentación adicional de otro rol para validar la calidad de los datos?
# - ESPECIALISTA DE IMÁGENES: ¿Vas a proponer gráficas adicionales o ajustar las existentes?
# - AUXILIAR: ¿Mantendrás una bitácora de cada gráfico generado y sus interpretaciones?

resumen_iot <- summary(iot_data)

resultados_eda <- list(
  resumen_iot                   = resumen_iot,
  estadisticas_market_share_iot = estadisticas_market_share_iot,
  tabla_exit_iot                = tabla_exit_iot
)



options(width = 800)
sink("resultados_analisis_estadistico/3_resultados_eda.txt")
print(resultados_eda)
sink()

