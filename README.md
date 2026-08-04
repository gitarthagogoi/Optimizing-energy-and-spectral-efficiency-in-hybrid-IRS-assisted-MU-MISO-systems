# Hybrid IRS-Aided MU-MISO — Reference Simulation Code

Reference / baseline MATLAB code for the system model and benchmark schemes
studied in our work on **decode-and-forward (DF) aided hybrid Intelligent
Reflecting Surface (IRS) precoding for multi-user MISO** downlink systems.

> **Associated paper (Elsevier — *Physical Communication*, 2026):**
> Optimizing energy and spectral efficiency in hybrid IRS-assisted MU-MISO systems through power-aware element allocation.
> Gitartha Gogoi, Arun Kumar Singh, Pradeep Vishwakarma, Samarendra Nath Sur, *Physical Communication*, Elsevier, 2026.
> Article: https://www.sciencedirect.com/science/article/abs/pii/S1874490726002648

Please cite the paper if you use this code (see [`CITATION.cff`](CITATION.cff)).

---

## Scope of this release

This repository releases the **reference / baseline layer** needed to
reproduce the system model and the benchmark curves:

- No-RIS precoding
- Random-phase RIS
- Passive RIS (optimized phases)
- Fully-active RIS

The **proposed contribution** — the DF-aided *hybrid* IRS precoder with
per-element active/passive allocation — is **not** included in full. The
public tree contains only its documented interface stub
([`src/proposed/DF_hybrid_precoding_STUB.m`](src/proposed/DF_hybrid_precoding_STUB.m)).
See **Availability of the proposed algorithm** below.

This is intentional: others can reproduce and compare against the baselines
and understand the model, without the novel algorithm being redistributed
in full.

---

## Repository layout

```
hybrid-irs-mu-miso/
├── README.md
├── LICENSE
├── CITATION.cff
├── .gitignore
├── docs/
│   └── NOTES.md                     Model, parameters, attribution, caveats
└── src/
    ├── run_baselines.m              Clean end-to-end driver for benchmark curves
    ├── baseline/                    Benchmark precoders
    │   ├── NoRIS_precoding.m
    │   ├── random_RIS_precoding.m
    │   ├── passive_RIS_precoding.m
    │   └── active_RIS_precoding.m
    ├── channel/                     Channel + geometry model
    │   ├── Channel_generate.m
    │   ├── Channel_generate2.m
    │   ├── Channel_generate_imperfect.m
    │   ├── Channel_generate2_imperfect.m
    │   ├── Position_generate.m
    │   ├── Position_generate_2.m
    │   ├── Position_generate_3.m
    │   ├── channel_F.m
    │   ├── channel_G.m
    │   ├── channel_H.m
    │   ├── channel_H2.m
    │   ├── make_Rician.m
    │   ├── LoS_channel.m
    │   ├── distance.m
    │   └── H_k_generate.m
    ├── utils/                       SINR, WMMSE helpers, CVX subproblem solvers
    │   ├── SINR_calculate.m
    │   ├── SINR_calculate_SI.m
    │   ├── w_k_generate.m
    │   ├── w_k2W.m
    │   ├── v_A_k_generate.m
    │   ├── eps_update.m
    │   ├── nu_Lam_generate.m
    │   ├── Rho_k_update.m
    │   ├── quantize.m
    │   ├── scale_precoder_to_budget.m
    │   ├── cvx_solve_W.m
    │   ├── cvx_solve_theta.m
    │   ├── cvx_solve_W_for_noRIS.m
    │   ├── cvx_solve_W_for_passiveRIS.m
    │   ├── Passive_RIS_cvx_solve_theta.m
    │   ├── QCQP2_solver.m
    │   └── MMAlgorithm.m
    └── proposed/
        └── DF_hybrid_precoding_STUB.m   Interface only (algorithm withheld)
```

## Requirements

- MATLAB (R2019b or newer recommended)
- [CVX](http://cvxr.com/cvx) with a QP/SOCP-capable solver (SDPT3/SeDuMi
  ship with CVX; Gurobi/MOSEK optional). CVX itself is **not** bundled —
  install it separately and add it to your MATLAB path.

## Quick start

```matlab
addpath(genpath('src'));   % from the repo root
run_baselines              % reproduces sum-rate vs. distance for the baselines
```

Default parameters (`M=4, K=4, N=512, Ps=10 mW`) follow the paper;
`ExNumber` is set low (50) for a fast smoke test — increase for
publication-quality averaging.

## Availability of the proposed algorithm

The full DF-aided hybrid precoder is available from the authors on
reasonable request for **academic, non-commercial** use. Please open an
issue or email the corresponding author (see paper) with a short
description of intended use.

## License

Released under the MIT License for the code authored by us (see
[`LICENSE`](LICENSE)). Third-party dependencies (e.g. CVX) are governed by
their own licenses and are not redistributed here. Portions of the baseline
harness are adapted from prior open active/passive-RIS precoding code;
attribution is in [`docs/NOTES.md`](docs/NOTES.md).
