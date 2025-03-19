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
