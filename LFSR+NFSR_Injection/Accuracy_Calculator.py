# Generated from: Accuracy_Calculator.ipynb
# Converted at: 2026-07-16T08:54:05.880Z
# Next step (optional): refactor into modules & generate tests with RunCell
# Quick start: pip install runcell

# # Load Data and Model

import numpy as np
from tqdm import tqdm
from sklearn.metrics import accuracy_score
from tensorflow.keras.models import load_model


import numpy as np

LOGIT_CLIP_EPS = 1e-4

def logit_transform(X, eps=LOGIT_CLIP_EPS):
    X_clipped = np.clip(X, eps, 1.0 - eps)
    return np.log(X_clipped / (1.0 - X_clipped)).astype(np.float32)

# Loading Data
data_path = "../Atom_KSD_Data_r70_c159"

X_train = np.load(f"{data_path}/X_train.npy")
y_train = np.load(f"{data_path}/y_train.npy")

X_val = np.load(f"{data_path}/X_val.npy")
y_val = np.load(f"{data_path}/y_val.npy")

X_test = np.load(f"{data_path}/X_test.npy")
y_test = np.load(f"{data_path}/y_test.npy")

print("Shapes:")
print("X_train:", X_train.shape)
print("y_train:", y_train.shape)
print("X_val:", X_val.shape)
print("y_val:", y_val.shape)
print("X_test:", X_test.shape)
print("y_test:", y_test.shape)


from tensorflow.keras.utils import to_categorical

NUM_CLASSES = 159
X_train = logit_transform(X_train)
X_val   = logit_transform(X_val)
X_test  = logit_transform(X_test)
y_train = to_categorical(y_train, NUM_CLASSES)
y_val   = to_categorical(y_val, NUM_CLASSES)
y_test  = to_categorical(y_test, NUM_CLASSES)

# ============================================================
# Load models
# ============================================================


# ANN model
print("Loading MLP Model")
mlp_model = load_model(
    "best_model_v2.keras"
)
print("Completed")




# # MLP Accuracy Computation


# ==================================================== MLP Accuracy computation =========================================

import tensorflow as tf
import time
import numpy as np
import pandas as pd
import os

import numpy as np


mlp_model.summary()

# -------------------------------------------------
# Helper: evaluate with timing + progress
# -------------------------------------------------
def eval_split(name, X, y, batch_size=4096):
    print("\n" + "=" * 60)
    print(f"Evaluating {name}")
    print("=" * 60)

    start = time.time()
    loss, acc = mlp_model.evaluate(
        X, y,
        batch_size=batch_size,
        verbose=1      # progress bar
    )
    elapsed = time.time() - start

    print(f"{name} Loss     : {loss:.6f}")
    print(f"{name} Accuracy : {acc:.6f}")
    print(f"{name} Time     : {elapsed:.2f} sec")

    return loss, acc

# -------------------------------------------------
# Run evaluations
# -------------------------------------------------
train_loss, train_acc = eval_split("Train", X_train, y_train)
val_loss, val_acc     = eval_split("Validation", X_val, y_val)
test_loss, test_acc   = eval_split("Test", X_test, y_test)

# -------------------------------------------------
# Final summary
# -------------------------------------------------
print("\n" + "=" * 60)
print("FINAL SUMMARY")
print("=" * 60)
print(f"Train Accuracy      : {train_acc:.6f}")
print(f"Validation Accuracy : {val_acc:.6f}")
print(f"Test Accuracy       : {test_acc:.6f}")




