# ------------------------
#  FUNCIÓN DE PREPROCESAMIENTO
# ------------------------

preprocesar_datos <- function(data) {
  # Renombrar columnas para evitar caracteres especiales
  colnames(data) <- make.names(colnames(data))
  
  # Filtrar los productos con al menos 13 observaciones en una única especificación por genérico
  data_filtrada <- data %>%
    group_by(Genérico, Especificación) %>%
    filter(n() >= 13) %>%
    slice_min(order_by = Precio.promedio, n = 1) %>%
    ungroup()
  
  # Seleccionar una única especificación por genérico con el menor precio (excepto electricidad)
  data_final <- data_filtrada %>%
    filter(Genérico != "Electricidad") %>%
    group_by(Genérico) %>%
    slice_min(order_by = Precio.promedio, n = 1) %>%
    ungroup()
  
  # Conservar todas las 13 observaciones de la especificación seleccionada
  data_final <- data %>%
    filter(Genérico %in% data_final$Genérico & Especificación %in% data_final$Especificación)
  
  # Asegurar que Electricidad con la especificación correcta siempre esté presente
  data_electricidad <- data %>%
    filter(Especificación == "CONSUMO DE 250 KWH                                          ")
  
  # Agregar electricidad sin afectar el filtrado de otros productos
  data_final <- bind_rows(data_final, data_electricidad)
  
  # Multiplicar los valores de electricidad por 0.5
  data_final <- data_final %>%
    mutate(Precio.promedio = ifelse(Especificación == "CONSUMO DE 250 KWH                                          ", 
                                    Precio.promedio * 0.5, Precio.promedio))
  
  # Ordenar por Año (ascendente) y luego por Mes (ascendente)
  data_final <- data_final %>%
    arrange(Año, Mes)
  
  # Guardar el dataset preprocesado
  # Eliminar espacios adicionales en la columna Especificación
  data_final <- data_final %>%
    mutate(Especificación = str_trim(Especificación))
  write.csv(data_final, "resultados_preprocesamiento/data_no_promediada.csv", row.names = FALSE)
  
  return(data_final)
}

# ------------------------
#  FUNCIÓN PARA PROMEDIAR REPETICIONES POR MES
# ------------------------

promediar_especificaciones <- function(data) {
  data_promediada <- data %>%
    group_by(Año, Mes, Genérico, Especificación) %>%
    summarise(Precio.promedio = mean(Precio.promedio, na.rm = TRUE), .groups = "drop")
  
  # Guardar el dataset promediado
  write.csv(data_promediada, "resultados_preprocesamiento/data_promediada.csv", row.names = FALSE)
  
  return(data_promediada)
}


# ------------------------
#  GENERACIÓN DE HISTOGRAMAS Y CÁLCULO DE CUARTILES
# ------------------------

# Función para generar histogramas y guardar los cuartiles
generar_histogramas_y_cuartiles <- function(data) {
  cuartiles_list <- list()
  
  for (especificacion in unique(data$Especificación)) {
    df <- data %>% filter(Especificación == especificacion)
    gen <- unique(df$Genérico)[1]  # Tomar solo el primer valor único
    
    # Crear nombre seguro para el archivo
    nombre_archivo <- tolower(str_replace_all(str_trim(str_replace_all(paste(gen, especificacion, sep="_"), "[.,()&]", "")), " ", "_"))
    
    # Manejar casos donde solo hay un valor en Precio.promedio
    if (length(unique(df$Precio.promedio)) < 2) {
      binwidth_value <- 1  # Usar un ancho de bin por defecto
    } else {
      binwidth_value <- diff(range(df$Precio.promedio, na.rm = TRUE)) / 5
    }
    
    # Crear histograma con mejoras visuales y distribución suavizada
    p <- ggplot(df, aes(x = Precio.promedio)) +
      geom_histogram(binwidth = binwidth_value, 
                     fill = "blue", color = "black", alpha = 0.7) +
      geom_density(aes(y = ..count.. * binwidth_value), 
                   color = "red", size = 1) +
      labs(title = paste("Distribución de Precios -", gen, "-", especificacion),
           x = "Precio Promedio",
           y = "Frecuencia") +
      theme_minimal() +
      theme(
        plot.background = element_rect(fill = "white", color = NA),
        axis.title.x = element_text(size = 14, face = "bold"),
        axis.title.y = element_text(size = 14, face = "bold"),
        axis.text = element_text(size = 12)
      )
    
    # Guardar imagen
    ggsave(filename = paste0("images/histograma_", nombre_archivo, ".png"), plot = p)
    
    # Calcular cuartiles
    cuartiles <- quantile(df$Precio.promedio, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE)
    cuartiles_list[[especificacion]] <- data.frame(Genérico = gen,
                                                   Especificación = especificacion,
                                                   MIN = cuartiles[1],
                                                   Q1 = cuartiles[2],
                                                   Mediana = cuartiles[3],
                                                   Q3 = cuartiles[4],
                                                   MAX = cuartiles[5])
  }
  
  # Unir resultados en un dataframe y guardar
  cuartiles_df <- do.call(rbind, cuartiles_list)
  write.csv(cuartiles_df, "results/cuartiles_especificaciones.csv", row.names = FALSE)
  
  return(cuartiles_df)
}


# ------------------------
#  SIMULACIÓN DE GASTO MENSUAL
# ------------------------

sumar_cuartiles <- function(archivo) {
  # Leer el archivo de cuartiles
  data_cuartiles <- read.csv(archivo)
  
  # Simular la compra de 1 a 2 veces de cada producto, excepto "Universidad", "Electricidad", "Cigarrillos", "Otros servicios para el hogar"
  set.seed(123)  # Fijar semilla para reproducibilidad
  data_cuartiles <- data_cuartiles %>%
    rowwise() %>%
    mutate(
      Unidades = ifelse(Genérico %in% c("Universidad", "Electricidad","Cigarrillos","Otros servicios para el hogar"), 1, sample(1:2, 1)),  # Número de unidades compradas
      MIN = ifelse(Genérico %in% c("Universidad", "Electricidad","Cigarrillos","Otros servicios para el hogar"), MIN, MIN * Unidades),
      Q1 = ifelse(Genérico %in% c("Universidad", "Electricidad","Cigarrillos","Otros servicios para el hogar"), Q1, Q1 * Unidades),
      Mediana = ifelse(Genérico %in% c("Universidad", "Electricidad","Cigarrillos","Otros servicios para el hogar"), Mediana, Mediana * Unidades),
      Q3 = ifelse(Genérico %in% c("Universidad", "Electricidad","Cigarrillos","Otros servicios para el hogar"), Q3, Q3 * Unidades),
      MAX = ifelse(Genérico %in% c("Universidad", "Electricidad","Cigarrillos","Otros servicios para el hogar"), MAX, MAX * Unidades)
    ) %>%
    ungroup()
  
  # Sumar cada columna de cuartiles
  suma_min <- sum(data_cuartiles$MIN, na.rm = TRUE)
  suma_q1 <- sum(data_cuartiles$Q1, na.rm = TRUE)
  suma_mediana <- sum(data_cuartiles$Mediana, na.rm = TRUE)
  suma_q3 <- sum(data_cuartiles$Q3, na.rm = TRUE)
  suma_max <- sum(data_cuartiles$MAX, na.rm = TRUE)
  
  # Obtener los 8 genéricos más caros en cada categoría con sus costos y unidades
  top_min <- data_cuartiles %>% arrange(desc(MIN)) %>% slice_head(n = 8) %>% select(Genérico, MIN, Unidades)
  top_q1 <- data_cuartiles %>% arrange(desc(Q1)) %>% slice_head(n = 8) %>% select(Genérico, Q1, Unidades)
  top_mediana <- data_cuartiles %>% arrange(desc(Mediana)) %>% slice_head(n = 8) %>% select(Genérico, Mediana, Unidades)
  top_q3 <- data_cuartiles %>% arrange(desc(Q3)) %>% slice_head(n = 8) %>% select(Genérico, Q3, Unidades)
  top_max <- data_cuartiles %>% arrange(desc(MAX)) %>% slice_head(n = 8) %>% select(Genérico, MAX, Unidades)
  
  # Formatear los resultados con los costos y unidades entre paréntesis
  format_top <- function(df, col) paste(df$Genérico, "(", df[[col]], ",", df$Unidades, "unidades)\n", collapse = ", ")
  
  # Imprimir los resultados
  cat("El costo al mes mín es de", suma_min, "\n - Productos más caros:", format_top(top_min, "MIN"), "\n")
  cat("El costo al mes Q1 es de", suma_q1, "\n - Productos más caros:", format_top(top_q1, "Q1"), "\n")
  cat("El costo al mes mediana es de", suma_mediana, "\n - Productos más caros:", format_top(top_mediana, "Mediana"), "\n")
  cat("El costo al mes Q3 es de", suma_q3, "\n - Productos más caros:", format_top(top_q3, "Q3"), "\n")
  cat("El costo al mes máx es de", suma_max, "\n - Productos más caros:", format_top(top_max, "MAX"), "\n")
}