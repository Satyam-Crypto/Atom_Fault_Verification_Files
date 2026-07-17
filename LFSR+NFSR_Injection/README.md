# Fault Identification Model (159 Classes)

This repository contains the trained fault identification model and evaluation script for the **159-class fault model** for Differential Fault Analysis on the stream cipher Atom.

The model is trained under the **single-bit fault model**, where the injected fault may occur at **any single bit of the Atom internal state**, including both the **LFSR** and **NFSR**. Consequently, the classification task consists of **159 output classes**, with each class corresponding to one possible fault location.

This repository includes:

```text
.
├── dataset/
│   ├── X_test.npy
│   └── y_test.npy
├── best_model_v2.keras
├── Accuracy_Calculator.py
└── README.md
```

## Contents

* **`best_model_v2.keras`** – Trained MLP model for 159-class fault identification.
* **`dataset/`** – Test dataset used for model evaluation.
* **`Accuracy_Calculator.py`** – Script for evaluating the trained model on the provided test dataset.

## Requirements

* Python >= 3.10
* TensorFlow (Keras)
* NumPy
* scikit-learn
* tqdm

Install the required packages using:

```bash
pip install tensorflow numpy scikit-learn tqdm
```

## Running the Evaluation

Run the evaluation script as follows:

```bash
python Accuracy_Calculator.py
```

The script loads the trained model and the test dataset, and reports the test classification accuracy.
