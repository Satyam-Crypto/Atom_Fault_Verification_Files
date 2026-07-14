import os
import numpy as np
from tqdm import tqdm

# Directory containing all generated experiments
DATASET_DIR = "dataset"

# Maximum number of previous rounds considered during search
MAX_SHIFT = 5

# Collect all experiment folders
exp_dirs = sorted(
    d for d in os.listdir(DATASET_DIR)
    if d.startswith("exp")
)

# rank_success[i] stores the number of experiments in which the
# correct injection round appears at rank (i+1).
rank_success = np.zeros(MAX_SHIFT + 1, dtype=int)

n_exp = 0  # a counter for the number of independent experiments

for exp in tqdm(exp_dirs):

    exp_dir = os.path.join(DATASET_DIR, exp)

    # Load KSDs, fault locations and the true injection round
    X = np.load(os.path.join(exp_dir, "X.npy"))
    y = np.load(os.path.join(exp_dir, "y.npy"))
    true_round = int(np.load(os.path.join(exp_dir, "z.npy")))

    # --------------------------------------------------------
    # Estimate the earliest possible injection round
    # --------------------------------------------------------

    # Find the first non-zero bit in every KSD.
    # The minimum of these values is taken as the initial estimate
    # of the fault injection round.
    first_nonzero = []

    for row in X:
        nz = np.nonzero(row)[0]
        if len(nz):
            first_nonzero.append(int(nz[0]))

    if len(first_nonzero) == 0:
        continue

    first_round_trial = min(first_nonzero)

    # --------------------------------------------------------
    # Generate candidate injection rounds
    # --------------------------------------------------------

    # Following the key recovery strategy, also try a few
    # rounds preceding the earliest observed non-zero.

    candidates = []

    for shift in range(MAX_SHIFT + 1):
        r = first_round_trial - shift
        if r >= 0:
            candidates.append(r)

    # --------------------------------------------------------
    # Evaluate the rank of the true injection round
    # --------------------------------------------------------

    # Record the rank at which the correct injection round appears.

    for rank, rnd in enumerate(candidates):
        if rnd == true_round:
            rank_success[rank] += 1
            break

    n_exp += 1

# --------------------------------------------------------
# Report statistics
# --------------------------------------------------------

print("\n===================================================")
print("Injection Round Estimation (Earliest Non-zero)")
print("===================================================")
print(f"Experiments evaluated : {n_exp}")
print(f"Maximum backward shifts considered : {MAX_SHIFT}")

print("\n\nRank denotes the position of the true injection round")
print("among the candidate rounds {r*, r*-1, ...}.")

for rank in range(len(rank_success)):
    print(
        f"Rank {rank+1}: "
        f"{rank_success[rank]}/{n_exp} = "
        f"{100*rank_success[rank]/n_exp:.2f}%"
    )