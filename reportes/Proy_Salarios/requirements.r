# Archivo: requirements.R
# Instalación de todas las librerías necesarias para el análisis

packages <- c("readxl", "ggplot2", "dplyr", "tidyr")

# Función para instalar y cargar paquetes automáticamente
install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# Aplicar la función a cada paquete
sapply(packages, install_if_missing)

message("Todas las librerías han sido instaladas y están listas para usar.")

