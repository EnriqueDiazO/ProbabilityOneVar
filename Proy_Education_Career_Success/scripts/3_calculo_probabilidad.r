################################################################################
# SCRIPT 3: CÁLCULO DE PROBABILIDADES EN EDUCATION_DATA_LIMPIO (verificación)
################################################################################

#####################################
# 1. Cargar bibliotecas necesarias  #
#####################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo se integrarán estos resultados con las decisiones del proyecto?
# - ESPECIALISTA DE DATASET: ¿Revisarás la correspondencia entre las columnas (ej. GPA, Internships_Completed) y la documentación del dataset?
# - ESPECIALISTA DE IMÁGENES: ¿Planeas representar estas probabilidades en algún tipo de visual (barras, diagrama de Venn, etc.)?
# - AUXILIAR: ¿Registrarás cada paso y sus resultados en la bitácora o informe final?

library(readr)
library(dplyr)

#####################################
# 2. Leer dataset limpio            #
#####################################

# Ajusta la ruta si es necesario
education_data_limpio <- read_csv(
  "resultados_preprocesamiento/education_data_limpio.csv",
  show_col_types = FALSE
)

#############################################
# 3. Definir valores umbral                #
#############################################

# Ajusta estos umbrales según tu proyecto
salary_threshold <- 70000   # Ejemplo: Salario mayor a 20,000
gpa_threshold    <- 3.5     # Ejemplo: GPA a partir de 3.5

#############################################
# 4. Probabilidad: P(Salary > X | Internships <= 2)
#############################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Explica por qué es relevante conocer esta probabilidad en el contexto del proyecto?
# - ESPECIALISTA DE DATASET: ¿Verificarás si existen errores o valores atípicos en 'Internships_Completed'?
# - ESPECIALISTA DE IMÁGENES: ¿Quieres visualizar la distribución de salarios de quienes tienen <=2 internships vs. >2?
# - AUXILIAR: ¿Registrarás este cálculo y su interpretación en el repositorio?

# 4.1 Filtrar quienes tienen 2 o menos internships
sub_internships <- education_data_limpio %>%
  filter(Internships_Completed <= 2)

# 4.2 Número total de estudiantes con <= 2 internships (B)
n_internships_total <- nrow(sub_internships)

# 4.3 Número de estudiantes con <= 2 internships y salary > X (A y B)
n_internships_salary <- sub_internships %>%
  filter(Starting_Salary > salary_threshold) %>%
  nrow()

# 4.4 Probabilidad condicional P(A|B) = #(A∩B)/#(B)
p_salary_given_internships <- n_internships_salary / n_internships_total

# Mensajes de verificación
cat("------------------------------------------------------------\n")
cat("Cálculo de P(Salary > ", salary_threshold, " | Internships <= 2 )\n", sep="")
cat("Total con <=2 internships (B):           ", n_internships_total, "\n")
cat("Total con <=2 internships y Salary > X: ", n_internships_salary, "\n")
cat("Probabilidad condicional:               ", p_salary_given_internships, "\n")
cat("------------------------------------------------------------\n\n")

#############################################
# 5. Probabilidad: P(Salary > X | GPA >= gpa_threshold)
#############################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Cómo ayuda esta probabilidad a tomar decisiones (becas, contrataciones, etc.)?
# - ESPECIALISTA DE DATASET: ¿Necesitas garantizar que GPA esté en una escala consistente (0-4, 0-5, etc.)?
# - ESPECIALISTA DE IMÁGENES: ¿Te gustaría un boxplot comparando Salary en distintos rangos de GPA?
# - AUXILIAR: ¿Anotarás en el reporte las conclusiones y limitaciones de este cálculo?

# 5.1 Filtrar quienes tienen GPA >= gpa_threshold
sub_gpa <- education_data_limpio %>%
  filter(University_GPA >= gpa_threshold)

# 5.2 Número total de estudiantes con GPA >= gpa_threshold (B)
n_gpa_total <- nrow(sub_gpa)

# 5.3 Número de estudiantes con GPA >= gpa_threshold y salary > X (A y B)
n_gpa_salary <- sub_gpa %>%
  filter(Starting_Salary > salary_threshold) %>%
  nrow()

# 5.4 Probabilidad condicional P(A|B) = #(A∩B)/#(B)
p_salary_given_gpa <- n_gpa_salary / n_gpa_total

# Mensajes de verificación
cat("Cálculo de P(Salary > ", salary_threshold, " | GPA >= ", gpa_threshold, " )\n", sep="")
cat("Total con GPA >= threshold (B):          ", n_gpa_total, "\n")
cat("Total con GPA >= threshold y Salary > X: ", n_gpa_salary, "\n")
cat("Probabilidad condicional:               ", p_salary_given_gpa, "\n")
cat("------------------------------------------------------------\n\n")

############################################################
# 6. Almacenar y mostrar los resultados en una lista       #
############################################################

# Preguntas para cada rol:
# - LÍDER DE PROYECTO: ¿Quién interpretará estos hallazgos y en qué momento se discutirán en equipo?
# - ESPECIALISTA DE DATASET: ¿Validarás con otros roles si es necesario profundizar en regresiones o test estadísticos?
# - ESPECIALISTA DE IMÁGENES: ¿Propondrás graficar estas probabilidades o usar un diagrama comparativo?
# - AUXILIAR: ¿Te encargarás de archivar estos resultados en un informe o repositorio?

resultados_probabilidad <- list(
  salario_threshold                  = salary_threshold,
  gpa_threshold                      = gpa_threshold,
  n_internships_total                = n_internships_total,
  n_internships_salary               = n_internships_salary,
  p_salary_given_internships         = p_salary_given_internships,
  n_gpa_total                        = n_gpa_total,
  n_gpa_salary                       = n_gpa_salary,
  p_salary_given_gpa                 = p_salary_given_gpa
)

cat("\nRESULTADOS FINALES:\n")
print(resultados_probabilidad)
cat("\nVerifica que p_salary_given_internships = n_internships_salary / n_internships_total\n")
cat("y que p_salary_given_gpa = n_gpa_salary / n_gpa_total.\n")
