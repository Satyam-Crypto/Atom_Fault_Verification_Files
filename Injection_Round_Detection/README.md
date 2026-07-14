# Injection Round Estimation from Keystream Difference Sequences (KSDs)

This folder contains the scripts used to generate **Keystream Difference Sequence (KSD)** datasets and evaluate a simple search technique for estimating the **fault injection round**. The code accompanies our work on differential fault analysis of the **Atom** stream cipher.

## Attack Assumption
For a given set of fault injections, the fault injection round is fixed for all faults but remains unknown to the attacker. The target is to retrieve the injection round.

## Repository Contents

```
.
├── KSD_gen_faults.sage          # Generates KSD datasets
├── Find_Injection_Round.py      # Estimates the fault injection round
└── dataset/
    ├── exp000/                  # Experiment 1 containg KSD X, fault y, injection round z
    ├── exp001/                  # Experiment 2 containg KSD X, fault y, injection round z
    ├── ...
```

## Workflow

The experiment consists of two stages:

1. **Dataset Generation**

   * Simulate fault injections in the cipher.
   * Generate the corresponding Keystream Difference Sequences (KSDs).
   * Store each experiment in a separate directory.

2. **Injection Round Estimation**

   * Analyze the generated KSDs.
   * Estimate the injection round using the earliest observed non-zero difference.
   * Evaluate how often the true injection round appears among a small set of candidate rounds.

---

# 1. Dataset Generation

The script

```
KSD_gen_faults.sage
```

generates datasets for multiple independent fault injection experiments.

For each experiment, it stores

* **X.npy** — Keystream Difference Sequences (KSDs)
* **y.npy** — Fault locations
* **z.npy** — True fault injection round

The generated directory structure is

```
dataset/
├── exp000/
│   ├── X.npy
│   ├── y.npy
│   └── z.npy
├── exp001/
│   ├── X.npy
│   ├── y.npy
│   └── z.npy
...
```

Each experiment is independent and can be used to evaluate the efficiency of injection-round estimation.

---

# 2. Injection Round Estimation

The script

```
Find_Injection_Round.py
```

implements a simple baseline for estimating the unknown fault injection round.

For every experiment, the algorithm

1. Loads the generated KSDs.
2. Finds the first non-zero position in every KSD.
3. Uses the earliest observed non-zero position as the initial estimate of the injection round.
4. Generates candidate rounds

```
{r*, r*-1, r*-2, ..., r*-MAX_SHIFT}
```

where `r*` denotes the earliest observed non-zero round.

5. Determines the rank at which the true injection round appears among these candidates.
6. Reports the success rate for every rank over all experiments.

---

# Requirements

## Dataset Generation

* SageMath

## Injection Round Estimation

* Python 3.8 or later
* NumPy
* tqdm

Install the required Python packages using

```bash
pip install numpy tqdm
```

---

# Configuration

The estimation script can be configured by modifying

```python
DATASET_DIR = "dataset"
MAX_SHIFT = 5
```

where

* `DATASET_DIR` specifies the location of the generated experiments.
* `MAX_SHIFT` specifies the maximum number of previous rounds considered during the search.

---

# Running the Code

## Step 1: Generate the Dataset

Run the SageMath script

```bash
sage KSD_gen_faults.sage
```

This creates the `dataset/` directory containing all experiments.

## Step 2: Estimate the Injection Round

Run

```bash
python Find_Injection_Round.py
```

---

# Example Output

```
===================================================
Injection Round Estimation (Earliest Non-zero)
===================================================
Experiments evaluated : 3189
Maximum backward shifts considered : 5

Rank denotes the position of the true injection round
among the candidate rounds {r*, r*-1, ...}.

Rank 1: 2933/3189 = 91.97%
Rank 2: 240/3189 = 7.53%
Rank 3: 16/3189 = 0.50%
Rank 4: ...
```

---

# Interpretation

* **Rank 1** indicates that the earliest observed non-zero difference correctly identifies the injection round, i.e., r* = true round
* **Rank 2** indicates that the true injection round is one round earlier than the initial estimate, i.e., r*-1 = true round
and so on.


These statistics quantify the effectiveness of the injection-round estimation strategy when the exact fault injection round is unknown.

---

## Acknowledgment

The injection-round estimation procedure implemented in `Find_Injection_Round.py` follows the methodology proposed by Mondal *et al.* in:

S. K. Mondal, P. Dey, H. S. Roy, A. Adhikari, and S. Maitra, "Improved Fault Analysis on Subterranean 2.0," *IEEE Transactions on Computers*, vol. 73, no. 6, pp. 1631–1639, June 2024, doi:10.1109/TC.2024.3371784.
