# Cargar librerías necesarias
library(tidyverse)

# Definir la función
save_categorical_counts <- function(df) {
  # Identificar variables cualitativas (factores o texto)
  qualitative_vars <- df %>%
    select(where(is.character)) %>%
    colnames()
  
  if (length(qualitative_vars) == 0) {
    cat("⚠️ No se encontraron variables cualitativas en el dataset.\n")
    return(NULL)
  }
  
  # Contar los valores únicos de cada variable cualitativa
  qualitative_counts <- df %>%
    select(all_of(qualitative_vars)) %>%
    summarise(across(everything(), ~ list(table(.))), .groups = "drop")
  
  # Crear un archivo de salida
  output_file <- "categorical_variable_counts.txt"
  sink(output_file)  # Redirigir la salida al archivo
  
  # Guardar los resultados en el archivo
  for (var in qualitative_vars) {
    cat("\n------------------------------\n")
    cat("📊 Distribución de valores en:", var, "\n")
    print(qualitative_counts[[var]])
  }
  
  sink()  # Cerrar el archivo
  cat("✅ Resultados guardados en", output_file, "\n")  # Mensaje en consola
}

