i# 🌊 Flood Prediction (Houston)

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

