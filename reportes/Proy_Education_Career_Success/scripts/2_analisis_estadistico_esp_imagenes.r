################################################################################
# SCRIPT 2 (MODIFICADO): ANÁLISIS EXPLORATORIO INTERACTIVO CON FILTROS ESPECÍFICOS
################################################################################

#####################################
# 1. Cargar bibliotecas necesarias  #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Quién validará la pertinencia de estas librerías para el objetivo del proyecto?
# - ESPECIALISTA DE DATASET: ¿Confirmarás la coherencia de los datos antes de generar visualizaciones?
# - ESPECIALISTA DE IMÁGENES: ¿Te interesan temas específicos para las gráficas (e.g., theme_minimal, theme_light)?
# - AUXILIAR: ¿Llevarás un registro de compatibilidad e instalación de estas librerías?

install.packages("plotly", dependencies = TRUE)
install.packages("ggplot2", dependencies = TRUE)

library(dplyr)
library(ggplot2)
library(plotly)

#####################################
# 2. Leer dataset limpio            #
#####################################

# (Sustituye la ruta o el nombre del CSV según corresponda)
# Se asume que ya se encuentra en la carpeta de resultados_preprocesamiento

education_data_limpio <- read.csv("resultados_preprocesamiento/education_data_limpio.csv")

#########################################
# 3. Estadísticas descriptivas generales #
#########################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo se definirá el alcance de este análisis en la siguiente reunión?
# - ESPECIALISTA DE DATASET: ¿Identificaste valores extremos que necesiten revisión más detallada?
# - ESPECIALISTA DE IMÁGENES: ¿Hay alguna visualización inicial que quieras proponer para las estadísticas?
# - AUXILIAR: ¿Has considerado la automatización de estos reportes estadísticos?

# 3.1 Generar un resumen rápido de todo el dataset
resumen_general <- summary(education_data_limpio)
options(width = 800)
sink("resultados_analisis_estadistico/1_summary_all_columns.txt")
print(education_data_limpio)
sink()

# 3.2 Alternativa más detallada usando summarytools (opcional)
install.packages("summarytools")
library(summarytools) # Para estadísticas descriptivas detalladas (opcional)
options(width = 400)
sink("resultados_analisis_estadistico/2_descr_all_columns.txt")
descr(education_data_limpio)
sink()

###########################################################
# 4. EDA para variable principal con filtros específicos  #
###########################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Está alineado con el proyecto enfocarse en 'Starting_Salary' como variable clave?
# - ESPECIALISTA DE DATASET: ¿Revisarás si existen transformaciones necesarias (log, etc.)?
# - ESPECIALISTA DE IMÁGENES: ¿Qué estilo de gráficos se prefiere?
# - AUXILIAR: ¿Archivarás las salidas gráficas generadas?

# 4.1 Filtrar el dataset según SEXO, RANGO DE EDAD, ÁREA DE ESTUDIO, NIVEL DE PUESTO ACTUAL

# Ejemplo:
#   - Queremos el sexo 'Female'
#   - Edad entre 21 y 28
#   - Área de estudio 'Medicine'
#   - Nivel de puesto 'Entry'

sub_education_data <- education_data_limpio %>%
  filter(
    Gender == "Male",         
    Age >= 21,
    Age <= 28,
    Field_of_Study == "Medicine", 
    Current_Job_Level == "Entry"
  )

# 4.2 Cálculo de estadísticas descriptivas para 'Starting_Salary' en este subdataset
salary_sub <- sub_education_data$Starting_Salary

media_salary     <- mean(salary_sub)
mediana_salary   <- median(salary_sub)
sd_salary        <- sd(salary_sub)
quantiles_salary <- quantile(salary_sub, probs = c(0.25, 0.5, 0.75, 0.9, 0.95))

estadisticas_salary <- list(
  media     = media_salary,
  mediana   = mediana_salary,
  sd        = sd_salary,
  quantiles = quantiles_salary
)

####################################
# 4.3 Histograma de 'Starting_Salary' (Subset) con ggplotly
####################################
p_hist <- ggplot(sub_education_data, aes(x = Starting_Salary)) +
  geom_histogram(
    bins = 15,
    fill = "lightblue",
    color = "black"
  ) +
  labs(
    title = "Histograma de Starting_Salary (Subset Filtrado)",
    x = "Monto de Salario (Subset)",
    y = "Frecuencia"
  ) +
  theme_minimal()

hist_interactivo <- ggplotly(p_hist)

####################################
# 4.4 Boxplot de 'Starting_Salary' (Subset) con ggplotly
####################################
p_box <- ggplot(sub_education_data, aes(y = Starting_Salary)) +
  geom_boxplot(fill = "lightgreen") +
  labs(
    title = "Boxplot de Salario (Subset Filtrado)",
    y = "Monto de Salario (Subset)"
  ) +
  theme_minimal()

box_interactivo <- ggplotly(p_box)

###################################
# 4.5 Barplot: Job_offers vs Starting_Salary (Subset)
###################################
# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo se relacionan las Job_offers con el sueldo inicial para este subset?
# - ESPECIALISTA DE DATASET: ¿Verificarás si Job_offers es numérico o categórico para elegir la gráfica adecuada?
# - ESPECIALISTA DE IMÁGENES: ¿Te interesa un color diferente o un tema distinto?
# - AUXILIAR: ¿Documentarás la fecha/hora de creación de la gráfica?

p_job_offers <- ggplot(sub_education_data, aes(x = factor(Job_Offers), y = Starting_Salary)) +
  geom_bar(stat = "identity", fill = "coral") +
  labs(
    title = "Job_offers vs Starting_Salary (Subset)",
    x = "Número de Job Offers",
    y = "Salario Inicial"
  ) +
  theme_minimal()

job_offers_interactivo <- ggplotly(p_job_offers)

###################################
# 4.6 Barplot: Interships_Completed vs Starting_Salary (Subset)
###################################
p_internships <- ggplot(sub_education_data, aes(x = factor(Internships_Completed), y = Starting_Salary)) +
  geom_bar(stat = "identity", fill = "violet") +
  labs(
    title = "Interships_Completed vs Starting_Salary (Subset)",
    x = "Número de Internships Completados",
    y = "Salario Inicial"
  ) +
  theme_minimal()

internships_interactivo <- ggplotly(p_internships)

###############################################################
# 5. EDA comparativo en dataset limpio (Field_of_Study vs. Starting_Salary)
###############################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Interesa comparar todas las áreas de estudio entre sí?
# - ESPECIALISTA DE DATASET: ¿Verificarás outliers en las distintas áreas?
# - ESPECIALISTA DE IMÁGENES: ¿Qué tipo de visualización te gustaría (boxplot, barplot...)?
# - AUXILIAR: ¿Registrarás cada gráfica en un repositorio con capturas?

# EJEMPLO: Boxplot comparando Field_of_Study vs Starting_Salary en TODO el dataset

p_field_box <- ggplot(education_data_limpio, aes(x = Field_of_Study, y = Starting_Salary)) +
  geom_boxplot(fill = "lightgray") +
  labs(
    title = "Field_of_Study vs Starting_Salary (Dataset Limpio)",
    x = "Área de Estudio",
    y = "Salario Inicial"
  ) +
  theme_minimal()

field_box_interactivo <- ggplotly(p_field_box)

#######################################################################################
# 6. Almacenar los resultados de EDA en una lista para posterior uso/presentación     #
#######################################################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿En qué fase del proyecto discutirán estos resultados?
# - ESPECIALISTA DE DATASET: ¿Requieres confirmación de otro rol sobre la calidad de los datos filtrados?
# - ESPECIALISTA DE IMÁGENES: ¿Propondrás gráficas adicionales o ajustes en el diseño?
# - AUXILIAR: ¿Mantendrás una bitácora con fecha y hora de cada gráfica generada?

resultados_eda <- list(
  estadisticas_salary_sub      = estadisticas_salary,
  hist_interactivo_obj         = hist_interactivo,
  box_interactivo_obj          = box_interactivo,
  job_offers_interactivo_obj   = job_offers_interactivo,
  internships_interactivo_obj  = internships_interactivo,
  field_box_interactivo_obj    = field_box_interactivo
)

print(resultados_eda)

###################################################
# 7. Mostrar gráficos interactivos (en consola)   #
###################################################

# En RStudio, podrás verlos en la pestaña 'Viewer' o en tu navegador.
hist_interactivo
box_interactivo
job_offers_interactivo
internships_interactivo
field_box_interactivo

