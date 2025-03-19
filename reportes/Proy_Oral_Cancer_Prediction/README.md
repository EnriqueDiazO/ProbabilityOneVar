# 📊 Análisis Exploratorio y Probabilidad en *Oral Cancer Prediction Dataset*

Este repositorio contiene un análisis detallado del conjunto de datos **Oral Cancer Prediction Dataset**, el cual está compuesto por **84,922 registros** y **25 variables**.  
El objetivo principal del análisis es identificar patrones en los factores de riesgo, síntomas y características de los pacientes diagnosticados con cáncer oral.

## 📌 Descripción del Dataset

El dataset incluye información sobre datos demográficos, hábitos, factores de riesgo, características del tumor, diagnóstico, tratamiento e impacto económico del cáncer oral.  
Para facilitar su análisis, las variables han sido agrupadas en las siguientes categorías:

### **1️⃣ Datos Personales**
| **Variable** | **Descripción** |**Tipo**|**Rango de Valores**|
|-------------|----------------|-------------|----------------|
| `Age` | Edad del paciente |  numérica | 15-101
| `Gender` | Género del paciente | categórica | Male / Female|
| `ID` | Clave única del paciente | numérica | 1-84922  |

---

### **2️⃣ Demografía**
| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `Country` | País del paciente | Categórica | 17 países |

#### 📊 **Distribución de `Country`**
| Country      | Conteo |
|-------------|--------|
| Australia   | 3,189  |
| Brazil      | 4,762  |
| Egypt       | 3,263  |
| France      | 4,783  |
| Germany     | 4,909  |
| India       | 8,079  |
| Italy       | 4,834  |
| Japón       | 3,152  |
| Kenia       | 3,171  |
| Nigeria     | 3,256  |
| Pakistán    | 8,001  |
| Rusia       | 4,711  |
| Sudáfrica   | 3,086  |
| Sri Lanka   | 8,000  |
| Taiwán      | 7,905  |
| Reino Unido | 4,930  |
| EE.UU.      | 4,891  |

---

### **3️⃣ Hábitos**
| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `Diet (Fruits & Vegetables Intake)` | Frecuencia de ingesta de frutas y verduras | Categórica | High / Moderate / Low |


#### 📊 **Distribución de `Diet (Fruits & Vegetables Intake)`**
| Diet | Conteo |
|------|--------|
| High | 17,112 |
| Low  | 33,896 |
| Moderate | 33,914 |

---

### **4️⃣ Factores de Riesgo**
| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `Tobacco Use` | Consumo de tabaco | Categórica | Yes / No |
| `Alcohol Consumption` | Consumo de alcohol | Categórica | Yes / No |
| `Chronic Sun Exposure` | Exposición crónica al sol | Categórica | Yes / No |
| `Family History of Cancer` | Antecedentes familiares de cáncer | Categórica | Yes / No |
| `HPV Infection` | Infección por VPH | Categórica | Yes / No |
| `Betel Quid Use` | Consumo de betel quid | Categórica | Yes / No |
| `Compromised Immune System` | Sistema inmunológico comprometido | Categórica | Yes / No |


---

### **5️⃣ Síntomas**
| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `Oral Lesions` | Presencia de lesiones en la cavidad oral | Categórica | Yes / No |
| `Unexplained Bleeding` | Sangrado sin causa aparente | Categórica | Yes / No |
| `Difficulty Swallowing` | Dificultad para tragar | Categórica | Yes / No |
| `White or Red Patches in Mouth` | Aparición de parches blancos o rojos en la boca | Categórica | Yes / No |


---

### **6️⃣ Características del Tumor**
| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `Tumor Size (cm)` | Tamaño del tumor en cm | Numérica | 0.0 - 6.0 |
| `Cancer Stage` | Etapa del cáncer en el diagnóstico | Categórica | 0-4 |

---

### **7️⃣ Diagnóstico**
| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `Early Diagnosis` | Indica si el diagnóstico fue temprano o tardío | Categórica | Yes / No |
| `Oral Cancer (Diagnosis)` | Confirmación de diagnóstico de cáncer oral | Categórica | Yes / No |
---

### **8️⃣ Tratamiento**
| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `Treatment Type` | Tipo de tratamiento administrado | Categórica | Chemotherapy / No Treatment / Radiation / Surgery / Targeted Therapy |


---

### **9️⃣ Impacto Económico y Social**
| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|----------|----------------------|
| `Cost of Treatment (USD)` | Costo del tratamiento en dólares | Numérica | 0-159988 |
| `Economic Burden (Lost Workdays per Year)` | Días de trabajo perdidos al año | Numérica | 0 - 179 |


---

### **🔟 Pronóstico**
| **Variable** | **Descripción** | **Tipo** | **Rango de Valores** |
|-------------|----------------|-------------|----------------|
| `Survival Rate (5-Year, %)` | Tasa de supervivencia a 5 años en porcentaje | numérico | 10-100|

---

## 🔬 Objetivos del Análisis

El análisis del dataset busca responder las siguientes preguntas:

1️⃣ **Factores de Riesgo**: ¿Cuáles son los factores que más influyen en el desarrollo del cáncer oral?  
2️⃣ **Diagnóstico Temprano**: ¿Qué características diferencian a los pacientes diagnosticados temprano y tardíamente?  
3️⃣ **Pronóstico**: ¿Cómo varía la tasa de supervivencia en función del tratamiento y otros factores?  
4️⃣ **Impacto Económico**: ¿Cuál es el costo estimado del tratamiento y la carga económica en términos de días de trabajo perdidos?  
5️⃣ **Correlaciones y Patrones**: ¿Qué relaciones existen entre los síntomas, factores de riesgo y etapas del cáncer?

---

## 🛠️ Requisitos para Ejecutar el Análisis

Para replicar el análisis, asegúrate de tener **R y RStudio** instalados, junto con las siguientes librerías:

```r
install.packages(c("tidyverse", "ggplot2", "dplyr", "readr"))
```
--- 


## Desglose del Proyecto *Oral Cancer Prediction*

## 📂 Estructura del Proyecto *Oral Cancer Prediction*

```bash
reportes/Proy_Oral_Cancer_Prediction/
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
│── resultados_generados/                       # Carpeta con gráficos generados
│   ├── 1_categorical_variable_counts.txt       # Distribución de variables categóricas
│   ├── barplot_country.png                     # Gráfico de barras por país
│   ├── barplot_genero.png                      # Gráfico de barras por género
│   ├── barplot_tabaco_genero.png               # Gráfico de barras consumo de tabaco por género
│   ├── boxplot_edad.png                        # Boxplot de edad
│   ├── boxplot_tumor_cancer_stage.png          # Boxplot tamaño de tumor por etapa del cáncer
│   ├── histograma_edad_genero.png              # Histograma de edad por género
│   ├── histograma_tamano_tumor.png             # Histograma tamaño del tumor
│   ├── probabilidad_alcohol.png                # Cálculo de probabilidad con alcohol
│   ├── probabilidad_tobacco.png                # Cálculo de probabilidad con tabaco
│   ├── scatter_edad_tumor.png                  # Scatterplot edad vs tamaño del tumor
│
```