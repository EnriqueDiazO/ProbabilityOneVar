# 📊 Análisis Exploratorio y Probabilidad en *Education Career Success Dataset*

Este repositorio contiene un análisis detallado del conjunto de datos **Education Career Success**, el cual explora la relación entre la educación y el éxito profesional.  
El objetivo principal del análisis es identificar patrones en factores educativos, habilidades, oportunidades de empleo y crecimiento profesional.

## 📌 Descripción del Dataset

El dataset incluye información sobre datos educativos, nivel de estudios, experiencia laboral, habilidades, industria, ingresos y satisfacción profesional.  
Para facilitar su análisis, las variables han sido agrupadas en las siguientes categorías:

---

## **1️⃣ Datos Personales**  

📌 Información básica sobre los individuos en el dataset.

| **Variable** | **Descripción** |**Tipo**|**Rango de Valores**|
|-------------|----------------|-------------|----------------|
| `student_id` | Clave única del estudiante | Categórica | S00001 - S05000 |
| `age` | Edad del estudiante | Numérica | 18 - 29 |
| `gender` | Género del estudiante | Categórica | Male / Female / Other |

---

## **2️⃣ Educación y Formación Académica**  
📌 Factores relacionados con el rendimiento académico y formación.

| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `high_school_gpa` | Promedio de calificaciones en *High School* | Numérica | 2.00 - 4.00 |
| `sat_score` | Puntaje obtenido en el examen SAT | Numérica | 900 - 1600 |
| `university_ranking` | Ranking de la universidad donde estudió | Numérica | 1 - 1000 |
| `university_gpa` | Promedio de calificaciones en la universidad | Numérica | 2.00 - 4.00 |
| `field_of_study` | Área de estudio o especialización | Categórica | Arts, Business, Computer Science, Engineering, Law, Mathematics, Medicine |

---

## **3️⃣ Experiencia Práctica y Habilidades**  
📌 Actividades extracurriculares y habilidades adquiridas.

| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `internships_completed` | Número de pasantías realizadas | Numérica | 0 - 4 |
| `projects_completed` | Cantidad de proyectos completados | Numérica | 0 - 9 |
| `certifications` | Cantidad de certificaciones obtenidas | Numérica | 0 - 5 |
| `soft_skills_score` | Puntaje en habilidades blandas (comunicación, trabajo en equipo, etc.) | Numérica | 1 - 10 |
| `networking_score` | Nivel de habilidades de networking (relaciones profesionales) | Numérica | 1 - 10 |

---

## **4️⃣ Inserción Laboral y Primer Empleo**  
📌 Factores relacionados con la transición al mundo laboral.

| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `job_offers` | Número de ofertas de trabajo recibidas | Numérica | 0 - 5 |
| `starting_salary` | Salario inicial al ingresar al mercado laboral (USD) | Numérica | 25,000 - 101,000 |

---

## **5️⃣ Desarrollo Profesional y Crecimiento**  
📌 Variables que indican la evolución en la carrera.

| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `years_to_promotion` | Años hasta la primera promoción laboral | Numérica | 1 - 5 |
| `current_job_level` | Nivel actual en la empresa (jerarquía laboral) | Categórica | Entry-level, Mid-level, Senior, Executive |

---

## **6️⃣ Calidad de Vida y Satisfacción Profesional**  
📌 Factores que reflejan la percepción del éxito en la carrera.

| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `career_satisfaction` | Nivel de satisfacción con la carrera | Categórica | 1 - 10 |
| `work_life_balance` | Percepción del balance entre vida y trabajo | Categórica | 1 - 10 |
| `entrepreneurship` | Indica si el individuo ha emprendido un negocio propio | Categórica | Yes / No |

---


## 🔬 Objetivos del Análisis

El análisis del dataset busca responder las siguientes preguntas:

1️⃣ **Impacto de la educación**: ¿Cómo influye el nivel educativo en los ingresos y la satisfacción laboral?  
2️⃣ **Tendencias de la industria**: ¿Cuáles son las industrias que mejor pagan y qué habilidades demandan?  
3️⃣ **Crecimiento profesional**: ¿Existe una correlación entre la experiencia laboral y el salario?  
4️⃣ **Educación vs. Habilidades**: ¿Cuáles son las habilidades clave que permiten avanzar en una carrera, independientemente del nivel educativo?  

---

## 🛠️ Requisitos para Ejecutar el Análisis

Para replicar el análisis, asegúrate de tener **R y RStudio** instalados, junto con las siguientes librerías:

```r
install.packages(c("tidyverse", "ggplot2", "dplyr", "readr"))
```