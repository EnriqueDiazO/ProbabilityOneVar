# Fuente:
# https://www.gob.mx/conasami/documentos/consulta-de-salarios-minimos
# Instalación de paqueterías
install.packages("readxl", dependencies=TRUE)
install.packages("ggplot2", dependencies=TRUE)
install.packages("dplyr", dependencies=TRUE)
install.packages("tidyr", dependencies=TRUE)

# Cargar librerías
library(readxl)
library(ggplot2)
library(dplyr)
library(tidyr)

# Cargar datos desde el archivo Excel
data <- read_excel("datasets/Salarios_Minimos_Generales_y_Profesionales_2009_2024_Zonas.xlsx", 
                   sheet = "Salarios_Minimos_Generales_y_Pr")

# Convertir la columna de fechas a formato Date
data$inicio_vigencia <- as.Date(data$inicio_vigencia)

# Información básica del dataset
str(data)  # Desglose por columnas
summary(data)  # Resumen por columnas
head(data)  # Primeras 5 filas

# Preprocesamiento de datos
# Reemplazar valores '.' por NA
data <- data %>% mutate(across(where(is.character), ~na_if(., ".")))

# Convertir todas las columnas (excepto 'zona') a numérico
data <- data %>% mutate(across(-c(inicio_vigencia, zona), as.numeric))

# Eliminar columnas que contengan al menos un valor NA
data <- data %>% select(where(~!any(is.na(.))))

# Filtrar datos para el año 2024
data_2024 <- data %>% filter(format(inicio_vigencia, "%Y") == "2024")

# Filtrar por zonas (Resto del País y Zona Fronteriza)
data_2024_rest <- data_2024 %>% filter(zona == "restodelpais")
data_2024_frontera <- data_2024 %>% filter(zona == "zlfn")

# Convertir los datos a formato largo
## Para el resto del país
data_2024_long_rest <- data_2024_rest %>% pivot_longer(cols = -c(inicio_vigencia, zona),
                                                       names_to = "profesion",
                                                       values_to = "salario")
data_2024_long_rest$salario <- as.numeric(data_2024_long_rest$salario)

## Para la zona fronteriza
data_2024_long_frontera <- data_2024_frontera %>% pivot_longer(cols = -c(inicio_vigencia, zona),
                                                               names_to = "profesion",
                                                               values_to = "salario")
data_2024_long_frontera$salario <- as.numeric(data_2024_long_frontera$salario)

# Gráficos de los 10 oficios mejor pagados
## En el resto del país
top_10_profesiones <- data_2024_long_rest %>%
  group_by(profesion) %>%
  summarise(salario_promedio = mean(salario, na.rm = TRUE)) %>%
  arrange(desc(salario_promedio)) %>%
  slice_head(n = 10)

bar_plot_top_10 <- ggplot(top_10_profesiones, aes(x = reorder(profesion, salario_promedio), y = salario_promedio)) +
  geom_bar(stat = "identity", fill = "blue", alpha = 0.7) +
  geom_text(aes(label = round(salario_promedio, 2)), hjust = -0.2, size = 4) +
  coord_flip() +
  labs(title = "Top 10 Oficios Mejor Pagados en 2024 en el resto del país",
       x = "Profesión",
       y = "Salario Promedio") +
  theme_minimal()

print(bar_plot_top_10)

## En la frontera
top_10_profesiones_frontera <- data_2024_long_frontera %>%
  group_by(profesion) %>%
  summarise(salario_promedio = mean(salario, na.rm = TRUE)) %>%
  arrange(desc(salario_promedio)) %>%
  slice_head(n = 10)

bar_plot_top_10_frontera <- ggplot(top_10_profesiones_frontera, aes(x = reorder(profesion, salario_promedio), y = salario_promedio)) +
  geom_bar(stat = "identity", fill = "blue", alpha = 0.7) +
  geom_text(aes(label = round(salario_promedio, 2)), hjust = -0.2, size = 4) +
  coord_flip() +
  labs(title = "Top 10 Oficios Mejor Pagados en 2024 en la frontera",
       x = "Profesión",
       y = "Salario Promedio") +
  theme_minimal()

print(bar_plot_top_10_frontera)

# Histogramas de distribución de salarios
## En el resto del país
hist_general_rest <- ggplot(data_2024_long_rest, aes(x = salario, fill = zona)) +
  geom_histogram(binwidth = 10, alpha = 0.7, color = "black", position = "identity") +
  geom_density(aes(y = ..count.. * 10), alpha = 0.5, color = "red", size = 1) +
  scale_x_continuous(breaks = seq(floor(min(data_2024_long_rest$salario, na.rm = TRUE)),
                                  ceiling(max(data_2024_long_rest$salario, na.rm = TRUE)),
                                  by = 10)) +
  labs(title = "Distribución de Salarios Mínimos en el resto del país (2024)",
       x = "Salario Mínimo",
       y = "Frecuencia") +
  theme_minimal()

print(hist_general_rest)

## En la frontera
hist_general_frontera <- ggplot(data_2024_long_frontera, aes(x = salario, fill = zona)) +
  geom_histogram(binwidth = 10, alpha = 0.7, color = "black", fill = "cyan", position = "identity") +
  geom_density(aes(y = ..count.. * 10), alpha = 0.2, color = "blue", fill = "cyan", size = 1) +
  scale_x_continuous(breaks = seq(floor(min(data_2024_long_frontera$salario, na.rm = TRUE)),
                                  ceiling(max(data_2024_long_frontera$salario, na.rm = TRUE)),
                                  by = 10)) +
  labs(title = "Distribución de Salarios Mínimos en la frontera (2024)",
       x = "Salario Mínimo",
       y = "Frecuencia") +
  theme_minimal()

print(hist_general_frontera)

# Función para calcular la probabilidad de ganar entre 200 y 300 pesos en una región específica
calcular_probabilidad <- function(min_val = 200, max_val = 300, region = "restodelpais") {
  data_2024_long <- data_2024 %>% pivot_longer(cols = -c(inicio_vigencia, zona),
                                               names_to = "profesion",
                                               values_to = "salario")
  data_rest <- data_2024_long %>% filter(zona == region)
  total <- nrow(data_rest)
  en_rango <- nrow(data_rest %>% filter(salario >= min_val & salario <= max_val))
  probabilidad <- en_rango / total
  print(probabilidad)
}

# Ejemplo de uso de la función calcular_probabilidad
calcular_probabilidad(min_val = 200, max_val = 900, region = "restodelpais")


