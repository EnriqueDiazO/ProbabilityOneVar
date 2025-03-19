# 📌 funciones_utiles.R - Funciones auxiliares para análisis de datos
# Autor: Enrique Díaz Ocampo

library(tidyverse)
library(here)

# 📌 Función para guardar la distribución de variables categóricas
save_categorical_counts <- function(df, proyecto, output_folder = "reportes") {
  # Identificar variables cualitativas (factores o texto)
  qualitative_vars <- df %>%
    select(where(~ is.character(.) | is.factor(.))) %>%
    colnames()
  
  if (length(qualitative_vars) == 0) {
    cat("⚠️ No se encontraron variables cualitativas en el dataset.\n")
    return(NULL)
  }
  
  # Contar los valores únicos de cada variable cualitativa
  qualitative_counts <- df %>%
    select(all_of(qualitative_vars)) %>%
    summarise(across(everything(), ~ list(table(.))), .groups = "drop")
  
  # Crear la ruta dinámica para guardar en `resultados_generados/` del proyecto
  output_path <- here(output_folder, proyecto, "resultados_generados", "1_categorical_variable_counts.txt")
  
  # Crear el directorio de resultados si no existe
  if (!dir.exists(dirname(output_path))) {
    dir.create(dirname(output_path), recursive = TRUE)
  }
  
  # Guardar los resultados en el archivo
  sink(output_path)
  for (var in qualitative_vars) {
    cat("\n------------------------------\n")
    cat("📊 Distribución de valores en:", var, "\n")
    print(qualitative_counts[[var]])    
    }
  sink()
  # Para verlo en consola
  for (var in qualitative_vars) {
    cat("\n------------------------------\n")
    cat("📊 Distribución de valores en:", var, "\n")
    print(qualitative_counts[[var]])    
  }
  }
