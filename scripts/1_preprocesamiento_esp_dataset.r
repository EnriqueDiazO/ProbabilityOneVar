# 📌 preprocesamiento.R - Limpieza y transformación de datos para todos los proyectos
# Autor: [Tu Nombre]
# Fecha: [Fecha]
# Descripción: Script unificado para cargar y limpiar datasets de distintos proyectos.

library(tidyverse)
library(janitor)

# 📌 Función para preprocesar cualquier dataset
preprocesar_datos <- function(ruta_dataset, proyecto) {
  cat("📥 Cargando datos del proyecto:", proyecto, "\n")
  
  # Leer el dataset
  datos <- read_csv(ruta_dataset, show_col_types = FALSE)
  
  # --- Limpieza General ---
  cat("🧹 Realizando limpieza de datos...\n")
  
  # Eliminar filas con valores faltantes críticos
  datos <- datos %>% drop_na() 
  
  # Limpiar nombres de columnas (elimina paréntesis, espacios y caracteres especiales)
  colnames(datos) <- make_clean_names(colnames(datos))

  # Convertir variables categóricas a factor
  datos <- datos %>%
    mutate_if(is.character, as.factor)

  # Convertir nombres de columnas a formato estándar
  colnames(datos) <- tolower(gsub(" ", "_", colnames(datos)))

  # --- Limpieza Específica por Proyecto ---
  if (proyecto == "Oral Cancer") {
    cat("📊 Aplicando preprocesamiento específico para Oral Cancer...\n")
    datos <- datos %>%
      mutate(
        gender = factor(gender, levels = c("Male", "Female")),
        country = factor(country),  # Países como factores
        tobacco_use = factor(tobacco_use, levels = c("No", "Yes")),
        alcohol_consumption = factor(alcohol_consumption, levels = c("No", "Yes")),
        hpv_infection = factor(hpv_infection, levels = c("No", "Yes")),
        betel_quid_use = factor(betel_quid_use, levels = c("No", "Yes")),
        chronic_sun_exposure = factor(chronic_sun_exposure, levels = c("No", "Yes")),
        poor_oral_hygiene = factor(poor_oral_hygiene, levels = c("No", "Yes")),
        diet_fruits_vegetables_intake = factor(diet_fruits_vegetables_intake, levels = c("Low", "Moderate", "High")),
        family_history_of_cancer = factor(family_history_of_cancer, levels = c("No", "Yes")),
        compromised_immune_system = factor(compromised_immune_system, levels = c("No", "Yes")),
        oral_lesions = factor(oral_lesions, levels = c("No", "Yes")),
        unexplained_bleeding = factor(unexplained_bleeding, levels = c("No", "Yes")),
        difficulty_swallowing = factor(difficulty_swallowing, levels = c("No", "Yes")),
        white_or_red_patches_in_mouth = factor(white_or_red_patches_in_mouth, levels = c("No", "Yes")),
        treatment_type = factor(treatment_type, levels = c("No Treatment", "Chemotherapy", "Radiation", "Surgery", "Targeted Therapy")),
        early_diagnosis = factor(early_diagnosis, levels = c("No", "Yes")),
        oral_cancer_diagnosis = factor(oral_cancer_diagnosis, levels = c("No", "Yes")),
        cancer_stage = factor(cancer_stage, levels = c("0","1", "2", "3", "4"))  # Convertir en factor numérico-categórico
      )
  }
  
  if (proyecto == "Startup Data") {
    cat("📊 Aplicando preprocesamiento específico para Startup Data...\n")
    datos <- datos %>%
      mutate_if(is.numeric, ~ replace(., is.na(.), median(., na.rm = TRUE))) %>%  # Reemplazar NA con mediana
      mutate(
             funding_rounds = factor(funding_rounds, levels = c("0","1", "2", "3", "4","5")),
             profitable = factor(profitable, levels = c("0","1")),
             year_founded = factor(year_founded)
             )
  }

  if (proyecto == "Education Success") {
    cat("📊 Aplicando preprocesamiento específico para Education Success...\n")
    datos <- datos %>%
      filter(!is.na(education_level)) %>%
      mutate(education_level = factor(education_level))
  }

  cat("✅ Preprocesamiento completado para:", proyecto, "\n")
  return(datos)
}

