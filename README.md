# Accuracy Evaluation of XGBoost, MLP and Ensemble Models

This repository contains the accompanying side-channel datasets and source code for the paper  
**“Differential Fault Attack on Atom: Bypassing the Double Key Filter using Filtered Faults”**.

It provides the experimental setup and evaluation framework used to compute the classification
accuracy of the following machine learning models:

- **XGBoost model**
- **Multi-Layer Perceptron (MLP)**
- **Weighted Soft-Voting Ensemble (XGBoost + MLP)**

The evaluation is performed on pre-generated Key Stream Difference (KSD) datasets for the Atom
cipher fault identification task.
---


## 📁 Directory Structure

```
├── Accuracy_Calculator.ipynb
├── Atom_KSD_Data
│   ├── X_test.npy
│   ├── X_train.npy
│   ├── X_val.npy
│   ├── y_test.npy
│   ├── y_train.npy
│   └── y_val.npy
├── CSV_Files
│   ├── Ensemble_output_analysis.csv
│   └── Rank_SuccessPr_analysis.csv
├── Injection_Round_Detection/
├── LFSR+NFSR_Injection/
├── README.md
└── saved_models
    ├── mlp_model_fault-69_KSD-70.keras
    └── xgboost_model_fault-69_KSD-70.json
```

---
---

## 📄 File and Folder Descriptions

### 📂 Atom_KSD_Data/
Contains the preprocessed dataset used for training and evaluation.

- **X_train.npy** – Training feature matrix.
- **y_train.npy** – Training labels.
- **X_val.npy** – Validation feature matrix.
- **y_val.npy** – Validation labels.
- **X_test.npy** – Test feature matrix.
- **y_test.npy** – Test labels.

Each feature vector corresponds to a Keystream Difference (KSD) of length 70, and labels correspond to fault locations (0–68).

---

### 📂 CSV_Files/
Contains CSV files used for statistical analysis and visualization.

- **Ensemble_output_analysis.csv** – Per-sample ensemble prediction results, including predicted fault locations, confidence scores, and correctness indicators. Used for analyzing ensemble behavior and confidence-threshold filtering.

- **Rank_SuccessPr_analysis.csv** – Aggregated statistics for fault-wise average rank and success probability under Top-1 selection. Used to generate plots and tables in the paper.


### 📁 saved_models/
Contains pretrained machine learning models used in the experiments under the assumption of single-bit fault model on LFSR register i.e., 69 classes.

- **mlp_model_fault-69_KSD-70.keras** – Trained Multi-Layer Perceptron (MLP) model.
- **xgboost_model_fault-69_KSD-70.json** – Trained XGBoost model.

These models are loaded directly by the notebook for evaluation.

---

### 📂 Injection_Round_Detection/
Contains scripts for the search of the fault injection round under the assumption that it is unknown to the attacker. A separate README.md file is inside that folder for the explanation of the scripts.

### 📂 LFSR+NFSR_Injection/
Contains a trained multi-layer perceptron model to detect fault location for the case when fault can be injected anywhere in the entire internal state (LFSR + NFSR) of the Atom cipher, i.e., 159 classes.

---

## ⚙️ Requirements
```

- **Python:** ≥ 3.8  
- **TensorFlow:** 2.20 (Keras 3.12)  
- **XGBoost:** 3.1.2  
- **Optuna:** 4.6.0  
- **SAT Solver:** Kissat 4.0.4  
- **Other Libraries:** NumPy, Scikit-learn, tqdm, Jupyter Notebook

```
To install the required Python dependencies:

```bash
pip install numpy scikit-learn tqdm \
            xgboost==3.1.2 \
            tensorflow==2.20 \
            optuna==4.6.0

git clone https://github.com/arminbiere/kissat.git
cd kissat
make
sudo cp build/kissat /usr/local/bin/

```

## ⚠️ Memory Requirement Notice

Training the XGBoost model may require **around 16 GB of RAM**, depending on the system configuration and dataset loading strategy. Systems with insufficient memory may experience slowdowns, out-of-memory errors, or crashes during training.

If your system has limited memory, consider:
- Reducing batch sizes or dataset size.
- Running only inference using the provided pretrained models.
- Using machines with higher memory capacity.


## ▶️ How to Run

1. Navigate to the project directory:

```bash
cd IEEE-TC_Model
```

2. Launch Jupyter Notebook or JupyterLab:

```bash
jupyter notebook
```

3. Open the notebook:

```
Accuracy_Calculator.ipynb
```

4. Run all cells sequentially.

The notebook will display:

- Accuracy on **training**, **validation**, and **test** sets.
- Inference time for each model.
- Progress bars for batched prediction.

---

## 🧪 Evaluation Methodology

- **XGBoost**
  - Predictions are computed in batches using `xgboost.DMatrix`.
  - CPU parallelism is enabled using all available cores.

- **MLP**
  - Evaluated using Keras' optimized `model.evaluate()` function.
  - Automatic batching and progress display.

- **Ensemble**
  - Weighted soft-voting strategy:

  P_ensemble = 0.65 × P_XGB + 0.35 × P_MLP

  - Final class label is selected using argmax over the combined probability vector.

---

## 📊 Output

The notebook prints:

- Accuracy for each model on:
  - Training set
  - Validation set
  - Test set
- Total inference time per evaluation.

No intermediate files are generated during evaluation.

---

## 📌 Notes

- All input features are converted to float32 for faster inference.
- Batch sizes can be adjusted inside the notebook depending on available memory.
- The CSV files included in the repository are supplementary analysis artifacts and
  are not required for running the accuracy evaluation notebook.

---


