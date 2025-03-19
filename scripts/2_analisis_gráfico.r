crear_boxplot <- function(data, x = NULL, y, fill = NULL, title, xlab, ylab, fill_lab = "Categoría", colores = NULL, rotar_x = FALSE) {
  # Crear el gráfico base
  p <- ggplot(data, aes(y = !!sym(y))) +
    labs(title = title, x = xlab, y = ylab, fill = fill_lab) +
    theme_minimal(base_size = 14) +
    theme(
      plot.title = element_text(hjust = 0.2, size = 12, face = "bold"),
      axis.title = element_text(size = 12, face = "bold"),
      axis.text.x = element_text(angle = ifelse(rotar_x, 45, 0), hjust = ifelse(rotar_x, 1, 0.5), size = 12),
      axis.text.y = element_text(size = 12)
    )
  
  # Agregar el eje X si se proporciona
  if (!is.null(x)) {
    p <- p + aes(x = !!sym(x))
  }
  
  # Agregar el fill si se proporciona
  if (!is.null(fill)) {
    p <- p + aes(fill = !!sym(fill))
  }
  
  # Agregar el boxplot con color personalizado
  if (is.null(fill)) {
    p <- p + geom_boxplot(alpha = 0.7, position = position_dodge(width = 0.8), fill = colores)
  } else {
    p <- p + geom_boxplot(alpha = 0.7, position = position_dodge(width = 0.8))
  }
  
  # Personalizar colores si se proporcionan y se usa fill
  if (!is.null(colores) && !is.null(fill)) {
    p <- p + scale_fill_manual(values = colores)
  }
  
  return(p)
}


crear_boxplot_interactivo <- function(data, x, y, color, colores, title, xlab, ylab, tickangle = -45) {
  # Crear el gráfico interactivo con plotly
  p <- plot_ly(data, 
               x = ~get(x),  # Variable para el eje X
               y = ~get(y),  # Variable para el eje Y
               color = ~get(color),  # Variable para el color (género)
               colors = colores,  # Colores personalizados
               type = "box") %>%  # Tipo de gráfico: boxplot
    layout(
      title = title,  # Título del gráfico
      xaxis = list(title = xlab, tickangle = tickangle),  # Etiqueta del eje X y rotación de etiquetas
      yaxis = list(title = ylab),  # Etiqueta del eje Y
      boxmode = "group"  # Agrupar los boxplots por campo de estudio
    )
  
  return(p)
}


crear_histograma <- function(data, x, fill = NULL, title, xlab, ylab, binwidth = 5, colores = NULL, densidad = FALSE) {
  # Crear el gráfico base
  p <- ggplot(data, aes(x = !!sym(x))) +
    geom_histogram(binwidth = binwidth, alpha = 0.7, position = "identity", color = "black") +
    labs(title = title, x = xlab, y = ylab) +
    theme_minimal(base_size = 14) +
    theme(
      plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
      axis.title = element_text(size = 14, face = "bold"),
      axis.text = element_text(size = 12)
    )
  
  # Agregar fill si no es NULL
  if (!is.null(fill)) {
    p <- p + aes(fill = !!sym(fill))
  }
  
  # Agregar línea de densidad si se solicita
  if (densidad) {
    p <- p + geom_density(aes(y = after_stat(count) * binwidth), color = "red", linetype = "dashed", size = 1.2)
  }
  
  # Personalizar colores si se proporcionan
  if (!is.null(colores)) {
    p <- p + scale_fill_manual(values = colores)
  }
  
  return(p)
}


crear_histograma_filtrado <- function(data, filtro_columna, filtro_valor, x, fill, title, xlab, ylab, binwidth, colores, etiquetas_leyenda) {
  # Filtrar los datos
  data_filtrada <- data %>% filter(!!sym(filtro_columna) == filtro_valor)
  
  # Crear el histograma
  p <- ggplot(data_filtrada, aes(x = !!sym(x), fill = !!sym(fill))) +
    geom_histogram(binwidth = binwidth, alpha = 0.5, position = "identity") +
    scale_fill_manual(name = "Género", values = colores, labels = etiquetas_leyenda) +
    labs(title = title, x = xlab, y = ylab) +
    theme_minimal(base_size = 16) +
    theme(
      plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),
      axis.title = element_text(size = 16, face = "bold"),
      axis.text = element_text(size = 14),
      legend.title = element_text(size = 14, face = "bold"),
      legend.text = element_text(size = 12),
      legend.position = "right"
    )
  
  return(p)
}


crear_barplot <- function(data, x, fill = NULL, title, xlab, ylab, colores = NULL, 
                          dodge = FALSE, voltear = FALSE, legend_position = "right") {
  # Crear el gráfico base
  p <- ggplot(data, aes(x = !!sym(x), fill = !!sym(fill))) +
    geom_bar(position = ifelse(dodge, "dodge", "stack"), alpha = 0.8) +  # Barras agrupadas o apiladas
    labs(title = title, x = xlab, y = ylab, fill = fill) +  # Etiquetas y título
    theme_classic(base_size = 16) +  # Usar theme_classic
    theme(
      plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),  # Título centrado y en negrita
      axis.title = element_text(size = 16, face = "bold"),  # Etiquetas de ejes en negrita
      axis.text = element_text(size = 14),  # Tamaño del texto de los ejes
      legend.title = element_text(size = 14, face = "bold"),  # Título de la leyenda en negrita
      legend.text = element_text(size = 12),  # Texto de la leyenda
      legend.position = legend_position  # Posición de la leyenda
    )
  
  # Voltear el gráfico si es necesario
  if (voltear) {
    p <- p + coord_flip()
  }
  
  # Personalizar colores si se proporcionan
  if (!is.null(colores)) {
    p <- p + scale_fill_manual(values = colores)
  }
  
  return(p)
}

crear_scatterplot <- function(data, x, y, color = NULL, title, xlab, ylab, colores = NULL) {
  # Crear el gráfico base
  p <- ggplot(data, aes(x = !!sym(x), y = !!sym(y))) +
    geom_point(alpha = 0.7) +
    labs(title = title, x = xlab, y = ylab) +
    theme_minimal(base_size = 14) +
    theme(
      plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
      axis.title = element_text(size = 14, face = "bold"),
      axis.text = element_text(size = 12)
    )
  
  # Agregar color si no es NULL
  if (!is.null(color)) {
    p <- p + aes(color = !!sym(color))
  }
  
  # Personalizar colores si se proporcionan
  if (!is.null(colores)) {
    p <- p + scale_color_manual(values = colores)
  }
  
  return(p)
}



convertir_interactivo <- function(grafico) {
  return(ggplotly(grafico))
}


guardar_grafico <- function(grafico, ruta, ancho = 8, alto = 6) {
  ggsave(filename = ruta, plot = grafico, width = ancho, height = alto, bg = "white")
}

guardar_interactivo <- function(grafico, ruta, ancho = 8, alto = 6) {
  # Guardar el gráfico interactivo como un archivo HTML
  htmlwidgets::saveWidget(grafico, file = ruta, selfcontained = TRUE)
}

