# 📌 Lista de paquetes utilizados en el proyecto
paquetes_necesarios <- c("here", "janitor", "summarytools", "dplyr", 
                         "ggplot2", "plotly", "tidyverse")

# 📌 Verificar qué paquetes faltan y deben instalarse
paquetes_faltantes <- paquetes_necesarios[!(paquetes_necesarios %in% installed.packages()[,"Package"])]

# 📌 Si hay paquetes faltantes, instalarlos
if(length(paquetes_faltantes) > 0){
  install.packages(paquetes_faltantes, dependencies = TRUE)
}

# 📌 Cargar todas las librerías en la sesión
lapply(paquetes_necesarios, require, character.only = TRUE)

# 📌 Mensaje de confirmación
cat("\n✅ Todas las librerías necesarias han sido cargadas correctamente.\n")
