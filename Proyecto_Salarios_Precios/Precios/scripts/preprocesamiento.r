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

# ------------------------
#  PREPROCESAMIENTO DE DATOS
# ------------------------

# Ejecutar preprocesamiento
data_preprocesado <- preprocesar_datos(data)

# Ejecutar función para promediar las especificaciones
data_promediada <- promediar_especificaciones(data_preprocesado)








