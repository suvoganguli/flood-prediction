# 🌊 Flood Prediction (Houston)

A minimal, physically grounded approach to modeling flood risk using real-world data.

This project explores a simple idea:

> **Can flood-prone conditions be captured using only elevation and rainfall?**

Instead of directly predicting sparse and noisy flood events, we define a proxy for flood risk based on terrain and recent precipitation, validate it against observed data, and test whether it can be predicted.

---

## 🧠 Key Idea

Flood risk at a regional scale is driven by two primary factors:

- **Terrain (where water accumulates)** → low elevation  
- **Rainfall (when flooding is triggered)** → recent precipitation  

We define a proxy label:

> A grid cell is flood-prone if it is **low-lying** and experiencing **high recent rainfall**

---

## 📊 Results

- Flood events occur **~1.66× more frequently** in low-elevation regions  
- A simple model predicts next-day flood-prone conditions with:
  - **Recall:** ~0.96  
  - **Precision:** ~0.49  
  - **ROC AUC:** ~0.996  

Despite its simplicity, the model captures meaningful structure in real-world data.

---

## 🗺️ Study Area

- **City:** Houston, TX  
- **Spatial Resolution:** 5 km × 5 km grid  
- **Total Grid Cells:** ~378  

This coarse spatial scale helps reveal regional patterns that are not visible at the point level.

---

## 🧱 Project Structure
flood-prediction/
│
├── notebooks/
│ ├── 01_study_area_and_grid.ipynb
│ ├── 02_target_variable_design.ipynb
│ ├── 03_features_and_proxy.ipynb
│ └── 04_modeling.ipynb
│
├── data/
│ ├── raw/ # external datasets (ignored)
│ ├── interim/ # intermediate outputs
│ └── processed/ # modeling tables
│
├── outputs/
│ └── figures/ # saved visualizations
│
├── config.py # project configuration
└── README.md


---

## ⚙️ Method Overview

1. **Grid Construction**
   - Houston divided into a 5 km spatial grid

2. **Target Variable Challenge**
   - Flood events are extremely sparse (~0.07%)
   - Direct modeling is not feasible

3. **Proxy Definition**
   - Low elevation → susceptibility  
   - High rainfall → trigger  
   - Combined → flood-prone condition (~2.1%)

4. **Validation**
   - Higher flood event density in susceptible regions

5. **Modeling**
   - Predict next-day proxy label (t+1)
   - Random Forest classifier

---

## 📦 Data Sources

- **NOAA Storm Events** – flood event records  
- **Open-Meteo** – daily precipitation  
- **USGS 3DEP** – elevation data  

---

## ⚠️ Limitations

This is a **coarse-scale model** and does not account for:

- urban drainage infrastructure  
- land use / impervious surfaces  
- localized hydrological effects  

It is intended as a **baseline, interpretable model**, not a full flood prediction system.

---

## 💡 Takeaway

> The physics may be simple.  
> The challenge is making it work with real data.

---

## 📝 Article

Full write-up available on Medium:  
👉 [Add your Medium link here]

---

## 👤 Author

Suvo Ganguli  
AI for Humanity Tech
