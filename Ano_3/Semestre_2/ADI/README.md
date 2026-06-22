<div align="center">

# 🧠 ADI - Intelligent Learning and Decision-Making

### Intelligent Learning & Decision-Making with Data Mining

![KNIME](https://img.shields.io/badge/KNIME-Analytics-yellow?style=for-the-badge)
![Year](https://img.shields.io/badge/Year-3rd-brightgreen?style=for-the-badge)
![Semester](https://img.shields.io/badge/Semester-2-blue?style=for-the-badge)

*Predictive analytics, data mining workflows, and intelligent decision systems*

[📂 Repository](../..) • [🎓 Course Info](#about) • [🚀 Quick Start](#getting-started)

</div>

---

## 📖 About

**ADI (Aprendizagem e Decisão Inteligentes)** focuses on data mining, machine learning pipelines, and predictive analytics using visual workflow tools. The course covers the full knowledge discovery process from data preprocessing to model evaluation.

This repository contains:
- 📊 Dataset analysis and feature engineering
- 🤖 Predictive models for classification and regression
- 📈 Performance evaluation and deployment workflows
- 📝 Course assignments and project documentation

### 🎯 Learning Objectives

- Understand the Knowledge Discovery in Databases (KDD) process
- Apply data preprocessing and cleaning techniques
- Build and evaluate machine learning models for classification and regression
- Use visual programming tools (KNIME) for data science workflows
- Interpret model results to support intelligent decision-making

---

## 🗂️ Repository Structure

```
ADI/
├── laptop_price_dataset/                 # Laptop pricing analysis
│   └── laptop_price.csv                  # Raw dataset
├── models/                               # KNIME Workflows
│   ├── laptop_prices_model_adi2526.knwf  # Laptop price prediction model
│   └── production_model_adi2526.knwf     # Energy production classification model
├── production_dataset_group/             # Energy production analysis
│   ├── production_dataset.csv            # Energy and weather dataset
│   └── production_explanation.txt        # Dataset column descriptions
├── ADI-2526.pdf                          # Course documentation
└── TG enunciado2526.pdf                  # Group assignment specification
```

---

## 🛠️ Technologies

<div align="center">

| Technology | Purpose | Version |
|------------|---------|---------|
| ![KNIME](https://img.shields.io/badge/KNIME-Analytics-yellow?style=flat) | Data Science Workflow Platform | Latest |
| ![CSV](https://img.shields.io/badge/CSV-Data_Format-green?style=flat) | Dataset Format | N/A |

</div>

---

## 🚀 Getting Started

### Prerequisites

To view and execute the workflows in this repository, you need to install the KNIME Analytics Platform.

1. Download and install [KNIME Analytics Platform](https://www.knime.com/knime-analytics-platform)
2. Ensure you have the necessary KNIME extensions installed (e.g., Machine Learning, Data Manipulation)

### Running the Workflows

1. Open KNIME Analytics Platform.
2. Import the workflows from the `models/` directory:
   - Go to `File` > `Import KNIME Workflow...`
   - Select the `.knwf` files from this repository.
3. Configure the nodes to point to the respective datasets in the `laptop_price_dataset/` or `production_dataset_group/` directories if the paths need updating.
4. Execute the workflows step-by-step or use the "Execute All" option to run the complete pipeline.

---

## 🎯 Skills Acquired

✅ **Data Preprocessing** - Handling missing values, normalization, and feature encoding
✅ **Predictive Modeling** - Building regression and classification models
✅ **Model Evaluation** - Analyzing accuracy, precision, recall, and ROC curves
✅ **Visual Programming** - Constructing complex data pipelines without writing code
✅ **Business Intelligence** - Extracting actionable insights from raw data

---

## 📜 License

Part of UMinho Software Engineering Archives - [Educational Use License](../../../LICENSE)

<div align="center">

**Developed in:** 2025/2026 Academic Year  
**Course Code:** ADI  
**Department:** Informatics Engineering  
**University:** Universidade do Minho

[⬆️ Back to Top](#-adi---intelligent-learning-and-decision-making)

</div>
