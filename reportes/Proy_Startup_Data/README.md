# 📊 Análisis Exploratorio y Probabilidad en *Startup Data*

Este repositorio contiene un análisis detallado del conjunto de datos **Startup Data**, el cual explora factores clave en el éxito de startups.  
El objetivo principal del análisis es identificar patrones en la industria, financiamiento, métricas de crecimiento y factores que determinan la rentabilidad y el éxito de una startup.

---

## 📌 Descripción del Dataset

El dataset incluye información sobre la industria, número de empleados, inversión recibida, ingresos, valoración de la empresa y su estado de salida del mercado (*exit status*).  
Para facilitar su análisis, las variables han sido agrupadas en las siguientes categorías:

---

## **1️⃣ Información General de la Startup**  
📌 Información básica sobre cada startup en el dataset.

| **Variable** | **Descripción** |**Tipo**|**Rango de Valores**|
|-------------|----------------|-------------|----------------|
| `startup_name` | Nombre de la startup | Categórica | Variado |
| `industry` | Sector de la industria al que pertenece la startup | Categórica | EdTech, FinTech, AI, E-Commerce, Gaming, IoT, etc. |
| `year_founded` | Año en que se fundó la startup | Numérica | 1990 - 2023 |
| `region` | Región geográfica de operación principal | Categórica | Asia, Australia, Europa, Norteamérica, Sudamérica |

---

## **2️⃣ Financiamiento y Valoración**  
📌 Factores relacionados con la inversión en la startup y su valoración en el mercado.

| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `funding_rounds` | Número de rondas de financiamiento recibidas | Categórica | 1 - 5 |
| `funding_amount_m_usd` | Monto total de financiamiento recibido (millones USD) | Numérica | 0.57 - 299.81 |
| `valuation_m_usd` | Valoración de la startup en el mercado (millones USD) | Numérica | 2.43 - 4,357.49 |

---

## **3️⃣ Crecimiento y Operación**  
📌 Métricas relacionadas con el crecimiento de la startup y su desempeño en el mercado.

| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `employees` | Número de empleados en la startup | Numérica | 12 - 4,984 |
| `market_share_percent` | Porcentaje de mercado capturado | Numérica | 0.1 - 10.0 |

---

## **4️⃣ Desempeño Financiero**  
📌 Factores clave sobre la rentabilidad y los ingresos de la startup.

| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `revenue_m_usd` | Ingresos anuales generados por la startup (millones USD) | Numérica | 0.12 - 99.71 |
| `profitable` | Indica si la startup es rentable | Categórica | Yes (1)/ No (0) |

---

## **5️⃣ Factores de Éxito y Estado de Salida**  
📌 Variables que determinan si la startup tuvo éxito y cómo terminó su participación en el mercado.

| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `exit_status` | Estado final de la startup en el mercado | Categórica | Acquired, IPO, Private |

---

## 🔬 Objetivos del Análisis

El análisis del dataset busca responder las siguientes preguntas:

1️⃣ **Factores de Éxito**: ¿Qué características diferencian a una startup exitosa de una que fracasa?  
2️⃣ **Importancia del Financiamiento**: ¿Cómo afecta la inversión inicial al crecimiento y rentabilidad de la startup?  
3️⃣ **Industria y Crecimiento**: ¿Cuáles son los sectores con mayores tasas de éxito?  
4️⃣ **Región y Rentabilidad**: ¿Existen diferencias en el desempeño de startups según la región donde operan?  
5️⃣ **Desempeño Financiero**: ¿Cómo se relacionan ingresos, rentabilidad y valoración de la startup?  

---

## 🛠️ Requisitos para Ejecutar el Análisis

Para replicar el análisis, asegúrate de tener **R y RStudio** instalados, junto con las siguientes librerías:

```r
install.packages(c("tidyverse", "ggplot2", "dplyr", "readr"))
```

# 📂 Estructura del Proyecto Startup Data Analysis

El proyecto Startup Data Analysis examina cómo diversos factores como financiamiento, industria, rentabilidad y crecimiento influyen en el éxito de una startup. Se desarrolla un Análisis Exploratorio de Datos (EDA), un Análisis Estadístico y un Estudio de Probabilidad para identificar patrones clave en el ecosistema emprendedor.

```bash
reportes/Proy_Startup_Data/
│── 00_CONFIGURACION.r                          # Archivo de configuración del proyecto
│
│── 01_Exploracion_datos.Rmd                    # Análisis Exploratorio de Datos (EDA)
│── 01_Exploracion_datos.html                   # Versión HTML del análisis exploratorio
│
│── 02_Analisis_Estadistico.Rmd                 # Análisis estadístico detallado
│── 02_Analisis_Estadistico.html                # Versión HTML del análisis estadístico
│
│── 03_Analisis_Probabilidad.Rmd                # Análisis de probabilidad
│── 03_Analisis_Probabilidad.html               # Versión HTML del análisis de probabilidad
│
│── README.md                                   # Documentación principal del proyecto
│
│── resultados_generados/                       # Carpeta con gráficos y resultados generados
│   ├── 1_categorical_variable_counts.txt       # Distribución de variables categóricas
│   ├── barplot_exit_status.png                 # Gráfico de barras del estado de salida de startups
│   ├── barplot_industria.png                   # Gráfico de barras por industria
│   ├── boxplot_empleados.png                   # Boxplot de número de empleados
│   ├── boxplot_financiamiento_industria.png    # Boxplot de financiamiento por industria
│   ├── histograma_financiamiento.png           # Histograma de montos de financiamiento
│   ├── probabilidad_condicional_empleados_vs_rentabilidad.png  # Probabilidad condicional de rentabilidad según empleados
│   ├── probabilidad_condicional_financiamiento_vs_rentabilidad.png  # Probabilidad condicional de rentabilidad según financiamiento
│   ├── probabilidad_condicional_marketshare_vs_revenue.png  # Probabilidad condicional de market share vs revenue
│   ├── scatter_valuacion_vs_financiamiento.png  # Scatterplot de valuación vs financiamiento
```

