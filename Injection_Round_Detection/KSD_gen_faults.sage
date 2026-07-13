
def h(x0,x1,x2,x3,x4,x5,x6,x7,x8):
    a1 = x0*x1*x2*x7*x8 + x0*x1*x2*x7 + x0*x1*x2*x8 + x0*x1*x2 + x0*x1*x3*x7*x8 + x0*x1*x3*x7 + \
    x0*x1*x4*x7*x8 + x0*x1*x4*x7 + x0*x1*x4*x8 + x0*x1*x4 + x0*x1*x5*x7*x8 + x0*x1*x5*x7 + x0*x1*x6*x7*x8 + x0*x1*x6*x8
    
    b1 = x0*x1*x7*x8 + x0*x1*x8 + x0*x2*x3*x7*x8 + x0*x2*x3*x7 + x0*x2*x3*x8 + x0*x2*x3 \
    + x0*x2*x4*x7*x8 + x0*x2*x4*x8 + x0*x2*x5*x7*x8\
    + x0*x2*x5*x7 + x0*x2*x5*x8 + x0*x2*x5 + x0*x2*x6*x7*x8 + x0*x2*x6*x8 + x0*x2*x7*x8  
    
    c1 = x0*x2*x8 + x0*x3*x4*x7*x8 + x0*x3*x4*x7 + x0*x3*x5*x7*x8 + x0*x3*x5*x7 + x0*x3*x6*x7*x8\
    + x0*x3*x6*x7 + x0*x3*x8 + x0*x3 + x0*x4*x5*x7*x8 + x0*x4*x5*x7 + x0*x4*x6*x7*x8 + x0*x4*x6*x8 + x0*x4*x7 + x0*x4
    
    d1 = x0*x5*x6*x7*x8 + x0*x5*x6*x7 + x0*x5*x7*x8 + x0*x5*x7 + x0*x6*x7 + x0*x6*x8 + x0*x7*x8 + x1*x2*x3*x7*x8\
    + x1*x2*x4*x7*x8 + x1*x2*x4*x8 + x1*x2*x5*x7*x8 + x1*x2*x6*x7*x8 + x1*x2*x6*x8 + x1*x2*x7 + x1*x2*x8
    
    e1 = x1*x2 + x1*x3*x4*x7*x8 + x1*x3*x5*x7*x8 + x1*x3*x6*x7*x8 + x1*x3*x7 + x1*x4*x5*x7*x8 + x1*x4*x5*x8\
    + x1*x4*x6*x7*x8 + x1*x4*x7 + x1*x4 + x1*x5*x6*x7*x8 + x1*x5*x6*x7 + x1*x5*x7*x8 + x1*x5*x7 + x1*x5*x8
    
    f1 = x1*x6*x7 + x1*x8 + x1 + x2*x3*x4*x7*x8 + x2*x3*x5*x7*x8 + x2*x3*x6*x7*x8 + x2*x4*x5*x7*x8 + x2*x4*x5*x8\
    + x2*x4*x6*x7*x8 + x2*x4*x7*x8 + x2*x4*x8 + x2*x5*x6*x7*x8 + x2*x5*x6*x8 + x2*x5*x8 + x2*x6*x7*x8 + x2*x6*x8
    
    g1 = x2*x7*x8 + x2 + x3*x4*x5*x7*x8 + x3*x4*x5*x7 + x3*x4*x6*x7*x8 + x3*x4*x6*x7 + x3*x5*x6*x7*x8 + x3*x5*x7*x8\
    + x3*x6*x7*x8 + x3*x6*x7 + x3*x7 + x3 + x4*x5*x6*x7*x8 + x4*x5*x6*x8 + x4*x6*x7*x8 + x4*x6*x8 + \
    x4*x7 + x5*x7*x8 + x5 + x6 + x7*x8 + x7 + x8 + 1
    
    return a1+b1+c1+d1+e1+f1+g1

def lfsr_update_fwd(L):
    return L[0] + L[5] + L[12] + L[22] + L[28] + L[37] + L[45] + L[58] + k0 + k0

def lfsr_update_bkd(L):
    return L[68] + L[4] + L[11] + L[21] + L[27] + L[36] + L[44] + L[57] + k0 + k0

def nfsr_update_fwd( N):
    return  N[0]+ N[24]+ N[49]+ N[79]+ N[84]+( N[3]* N[59])+( N[10]* N[12])+( N[15]* N[16])+( N[25]* N[53])\
    +( N[35]* N[42])+( N[55]* N[58])+( N[60]* N[74])+( N[20]* N[22]* N[23])+( N[62]* N[68]* N[72]) \
    + ( N[77]* N[80]* N[81]* N[83]) + k0 + k0

def nfsr_update_bkd( N):
    return  N[89] +  N[23] +  N[48] +  N[78] +  N[83] + ( N[2] *  N[58]) + ( N[9] *  N[11]) + ( N[14] *  N[15]) + ( N[24] *  N[52]) \
           + ( N[34] *  N[41]) + ( N[54] *  N[57]) + ( N[59] *  N[73]) + ( N[19] *  N[21] *  N[22]) + ( N[61] *  N[67] *  N[71]) \
           + ( N[76] *  N[79] *  N[80] *  N[82]) + k0 + k0

def keystream(L, N):
    return  N[1] +  N[5] +  N[11] +  N[22] +  N[36] +  N[53] +  N[72] +  N[80] +  N[84] \
    + (L[5]*L[16]) + (L[13]*L[15]) + (L[30]*L[42]) + (L[67]*L[22]) \
    + h(L[7], L[33], L[38], L[50], L[59], L[62],  N[85],  N[41],  N[9]) + k0 + k0


def initialisation():
    K = [randint(0,1) for i in range(K_len)]
    IV = [randint(0,1) for i in range(IV_len)]
    N = [IV[i] for i in range(N_len)]
    L = [IV[90+i] for i in range(38)] + [1 for i in range(22)] + [0 for i in range(9)]
    n_keys = 0
    rounds = 511
    for t in range(rounds):
        z = keystream(L,N)
        cnt = L[62:]
        n = nfsr_update_fwd(N) + L[0] + K[bin_to_dec(cnt)] + z + k0 + k0
        N = N[1:] + [n]
        
        l = lfsr_update_fwd(L) + z + k0 + k0
        L = L[1:60] + [l] + [(((t+1)>>(8-i)) & 0x01) for i in range(9)]
        

        assert len(L) == L_len
        assert len(N) == N_len
        assert len(K) == K_len

    # for t in range(rounds, rounds + n_keys, 1):
    #     z = keystream(L,N)
    #     cnt = L[62:]
    #     n = nfsr_update_fwd(N) + L[0] + K[bin_to_dec(cnt)] + K[t%128] + k0 + k0
    #     N = N[1:] + [n]
        
    #     l = lfsr_update_fwd(L) + k0 + k0
    #     L = L[1:] + [l] 
        
    return K, L, N

def bin_to_dec(temp):
    sum = 0
    l = len(temp)
    for i in range(l):
        sum += temp[i]*(2**(l-1-i))

    return int(sum)


V=BooleanPolynomialRing(10,["k%d "%(i) for i in range(10)])
V.inject_variables()
var=list(V.gens())
print(var)


# 80-bit key and 64-bit IV.
# Two 80-bit shift registers, one linear and one non-linear

from random import randint
from math import log
import csv
import numpy as np
import os


L_len = 69 # LFSR
N_len = 90 # NFSR
K_len = 128 # Key
IV_len = 128 # IV



rounds = 200
n_faults = L_len
req_faults = 26



import os
import numpy as np

# -------------------------------------------------
# Number of experiments
# -------------------------------------------------
N_EXPERIMENTS = 100_000

BASE_DIR = "dataset"
os.makedirs(BASE_DIR, exist_ok=True)

for exp in range(1, N_EXPERIMENTS + 1):

    # ---------------------------------------------
    # Create experiment folder
    # ---------------------------------------------
    inject_round = np.random.randint(0, 100)   # 0 ... rounds-1


    exp_dir = os.path.join(BASE_DIR, f"exp{exp}")
    os.makedirs(exp_dir, exist_ok=True)

    # ---------------------------------------------
    # Select random fault locations
    # ---------------------------------------------
    flt_pos = np.random.choice(n_faults, size=req_faults, replace=False)

    KSD = {fault: [0] * rounds for fault in flt_pos}

    # ---------------------------------------------
    # Generate random key and IV
    # ---------------------------------------------
    K_org, L_org, N_org = initialisation()

    assert len(K_org) == K_len
    assert len(L_org) == L_len
    assert len(N_org) == N_len

    # ---------------------------------------------
    # Run experiment
    # ---------------------------------------------
    for fault in flt_pos:

        L = L_org[:]
        N = N_org[:]
        K = K_org[:]

        L_fault = L[:]
        N_fault = N[:]

        for t in range(rounds):

            if t == inject_round:
                L_fault[fault] += 1 + k0 + k0

            z = keystream(L, N)
            z_f = keystream(L_fault, N_fault)

            temp = L[62:]
            n = (
                nfsr_update_fwd(N)
                + L[0]
                + K[bin_to_dec(temp)]
                + K[t % 128]
                + k0
                + k0
            )

            l = lfsr_update_fwd(L) + k0 + k0

            N[:] = N[1:] + [n]
            L[:] = L[1:] + [l]

            temp = L_fault[62:]

            n_f = (
                nfsr_update_fwd(N_fault)
                + L_fault[0]
                + K[bin_to_dec(temp)]
                + K[t % 128]
                + k0
                + k0
            )

            l_f = lfsr_update_fwd(L_fault) + k0 + k0

            N_fault[:] = N_fault[1:] + [n_f]
            L_fault[:] = L_fault[1:] + [l_f]

            KSD[fault][t] = int(z + z_f + k0 + k0)

    # ---------------------------------------------
    # Convert to arrays
    # ---------------------------------------------
    X = np.array(
        [KSD[fault] for fault in sorted(KSD.keys())],
        dtype=np.uint8
    )

    y = np.array(
        sorted(KSD.keys()),
        dtype=np.int64
    )

    # ---------------------------------------------
    # Save
    # ---------------------------------------------
    np.save(os.path.join(exp_dir, "X.npy"), X)
    np.save(os.path.join(exp_dir, "y.npy"), y)
    np.save(os.path.join(exp_dir, "z.npy"), np.array(inject_round, dtype=np.int32))

    print(f"Completed {exp}/{N_EXPERIMENTS}")