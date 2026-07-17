import numpy as np
from tqdm import tqdm
from sklearn.metrics import accuracy_score
from tensorflow.keras.models import load_model
import tensorflow as tf
import time
from tensorflow.keras.utils import to_categorical


# ============================================================
# Logit transformation
# Converts input features from the probability domain to the
# log-odds domain. Values are clipped to avoid infinities.
# ============================================================

LOGIT_CLIP_EPS = 1e-4

def logit_transform(X, eps=LOGIT_CLIP_EPS):
    X_clipped = np.clip(X, eps, 1.0 - eps)
    return np.log(X_clipped / (1.0 - X_clipped)).astype(np.float32)


# ============================================================
# Load the test dataset
# ============================================================

data_path = "dataset"

X_test = np.load(f"{data_path}/X_test.npy")
y_test = np.load(f"{data_path}/y_test.npy")

print("Shapes:")
print("X_test:", X_test.shape)
print("y_test:", y_test.shape)


# ============================================================
# Preprocess the test dataset
#   1. Apply the logit transformation to the input features.
#   2. Convert class labels to one-hot encoded vectors.
# ============================================================


NUM_CLASSES = 159

X_test = logit_transform(X_test)
y_test = to_categorical(y_test, NUM_CLASSES)


# ============================================================
# Load the trained MLP model
# ============================================================

print("Loading MLP Model")

mlp_model = load_model("best_model_v2.keras")

print("Completed")


# ============================================================
# Display the model architecture
# ============================================================

mlp_model.summary()


# ============================================================
# Evaluate the model on the test dataset
#
# Computes:
#   - Cross-entropy loss
#   - Classification accuracy
#   - Inference time
# ============================================================


def eval_split(name, X, y, batch_size=4096):
    print("\n" + "=" * 60)
    print(f"Evaluating {name}")
    print("=" * 60)

    start = time.time()

    loss, acc = mlp_model.evaluate(
        X,
        y,
        batch_size=batch_size,
        verbose=1      # Display evaluation progress
    )

    elapsed = time.time() - start

    print(f"{name} Loss     : {loss:.6f}")
    print(f"{name} Accuracy : {acc:.6f}")
    print(f"{name} Time     : {elapsed:.2f} sec")

    return loss, acc


# ============================================================
# Evaluate the trained model on the test dataset
# ============================================================

test_loss, test_acc = eval_split("Test", X_test, y_test)


# ============================================================
# Print the final evaluation summary
# ============================================================

print("\n" + "=" * 60)
print("FINAL SUMMARY")
print("=" * 60)
print(f"Test Accuracy : {test_acc:.6f}")