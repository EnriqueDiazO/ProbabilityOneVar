# Función para calcular probabilidades condicionales y generar tabla de contingencia
calcular_probabilidad_condicional <- function(data, condicionante, objetivo, valor_condicionante = "Yes", valor_objetivo = "Yes") {
  # Filtrar datos según la condición
  subconjunto <- data %>%
    filter(!!sym(condicionante) == valor_condicionante)
  
  # Calcular total de casos que cumplen la condición
  n_total <- nrow(subconjunto)
  
  # Calcular casos que cumplen la condición y tienen el valor objetivo
  n_objetivo <- subconjunto %>%
    filter(!!sym(objetivo) == valor_objetivo) %>%
    nrow()
  
  # Calcular probabilidad condicional
  probabilidad <- n_objetivo / n_total
  
  # Crear tabla de contingencia
  tabla_contingencia <- data %>%
    group_by(!!sym(condicionante), !!sym(objetivo)) %>%
    summarise(n = n(), .groups = 'drop')
  
  # Retornar resultados
  return(list(
    probabilidad = probabilidad,
    tabla_contingencia = tabla_contingencia
  ))
}


calcular_probabilidades <- function(data, condicionante, objetivo, bins = NULL) {
  # Verificar si la variable condicionante es numérica
  if (is.numeric(data[[condicionante]])) {
    if (is.null(bins)) {
      stop("La variable condicionante es numérica. Debes proporcionar el número de intervalos (bins).")
    }
    # Dividir la variable numérica en intervalos de clase
    data <- data %>%
      mutate(!!sym(condicionante) := cut(!!sym(condicionante), breaks = bins, include.lowest = TRUE))
  }
  
  # Verificar si la variable objetivo es numérica
  if (is.numeric(data[[objetivo]])) {
    if (is.null(bins)) {
      stop("La variable objetivo es numérica. Debes proporcionar el número de intervalos (bins).")
    }
    # Dividir la variable numérica en intervalos de clase
    data <- data %>%
      mutate(!!sym(objetivo) := cut(!!sym(objetivo), breaks = bins, include.lowest = TRUE))
  }
  
  # Crear tabla de contingencia
  tabla_contingencia <- data %>%
    group_by(!!sym(condicionante), !!sym(objetivo)) %>%
    summarise(n = n(), .groups = 'drop')
  
  # Calcular probabilidades condicionales para cada valor de la variable condicionante
  probabilidades_condicionales <- tabla_contingencia %>%
    group_by(!!sym(condicionante)) %>%
    mutate(prob_condicional = n / sum(n)) %>%
    ungroup()
  
  # Calcular probabilidades marginales de la variable objetivo
  probabilidades_marginales <- tabla_contingencia %>%
    group_by(!!sym(objetivo)) %>%
    summarise(n = sum(n), .groups = 'drop') %>%
    mutate(prob_marginal = n / sum(n))
  
  # Retornar resultados
  return(list(
    tabla_contingencia = tabla_contingencia,
    probabilidades_condicionales = probabilidades_condicionales,
    probabilidades_marginales = probabilidades_marginales
  ))
}


# Función para visualizar probabilidades condicionales
visualizar_probabilidad_condicional <- function(data, condicionante, objetivo, titulo, xlab, ylab = "Probabilidad Condicional", guardar = TRUE, ruta_guardado = NULL, bins = NULL) {
  # Verificar si la variable condicionante es numérica
  if (is.numeric(data[[condicionante]])) {
    if (is.null(bins)) {
      stop("La variable condicionante es numérica. Debes proporcionar el número de intervalos (bins).")
    }
    # Dividir la variable numérica en intervalos de clase
    data <- data %>%
      mutate(!!sym(condicionante) := cut(!!sym(condicionante), breaks = bins, include.lowest = TRUE))
  }
  
  # Verificar si la variable objetivo es numérica
  if (is.numeric(data[[objetivo]])) {
    if (is.null(bins)) {
      stop("La variable objetivo es numérica. Debes proporcionar el número de intervalos (bins).")
    }
    # Dividir la variable numérica en intervalos de clase
    data <- data %>%
      mutate(!!sym(objetivo) := cut(!!sym(objetivo), breaks = bins, include.lowest = TRUE))
  }
  
  # Calcular probabilidades condicionales
  probabilidades <- data %>%
    group_by(!!sym(condicionante), !!sym(objetivo)) %>%
    summarise(n = n(), .groups = 'drop') %>%
    group_by(!!sym(condicionante)) %>%
    mutate(prob_condicional = n / sum(n)) %>%
    ungroup()
  
  # Crear gráfico
  p <- ggplot(probabilidades, aes(x = !!sym(condicionante), y = prob_condicional, fill = !!sym(objetivo))) +
    geom_bar(stat = "identity", position = "dodge") +  # Barras separadas
    labs(title = titulo, x = xlab, y = ylab, fill = objetivo) +
    theme_minimal(base_size = 14) +
    theme(
      plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
      axis.title = element_text(size = 14, face = "bold"),
      axis.text = element_text(size = 12),
      legend.title = element_text(size = 12, face = "bold"),
      legend.text = element_text(size = 10)
    )
  
  # Guardar gráfico si es necesario
  if (guardar && !is.null(ruta_guardado)) {
    ggsave(ruta_guardado, plot = p, width = 8, height = 6, bg = "white")
  }
  
  # Convertir a gráfico interactivo
  p_interactivo <- ggplotly(p)
  
  return(p_interactivo)
}