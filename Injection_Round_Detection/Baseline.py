import os
import numpy as np
from tqdm import tqdm

DATASET_DIR = "dataset"
max_shift = 5

exp_dirs = sorted(
    d for d in os.listdir(DATASET_DIR)
    if d.startswith("exp")
)

rank_success = np.zeros(max_shift + 1, dtype=int)
n_exp = 0

for exp in tqdm(exp_dirs):

    exp_dir = os.path.join(DATASET_DIR, exp)

    X = np.load(os.path.join(exp_dir, "X.npy"))
    y = np.load(os.path.join(exp_dir, "y.npy"))
    true_round = int(np.load(os.path.join(exp_dir, "z.npy")))

    # --------------------------------------------------------
    # Earliest non-zero among all KSDs
    # --------------------------------------------------------

    first_nonzero = []

    for row in X:
        nz = np.nonzero(row)[0]
        if len(nz):
            first_nonzero.append(int(nz[0]))

    if len(first_nonzero) == 0:
        continue

    first_round_trial = min(first_nonzero)

    # --------------------------------------------------------
    # Candidate rounds
    # --------------------------------------------------------

    candidates = []

    for shift in range(max_shift + 1):
        r = first_round_trial - shift
        if r >= 0:
            candidates.append(r)

    # --------------------------------------------------------
    # Rank-wise success
    # --------------------------------------------------------

    for rank, rnd in enumerate(candidates):
        if rnd == true_round:
            rank_success[rank] += 1
            break

    n_exp += 1

# --------------------------------------------------------
# Report
# --------------------------------------------------------

print("\n===================================")
print("Baseline (Earliest Non-zero)")
print("===================================")

for rank in range(len(rank_success)):
    print(
        f"Rank {rank+1}: "
        f"{rank_success[rank]}/{n_exp} = "
        f"{100*rank_success[rank]/n_exp:.2f}%"
    )