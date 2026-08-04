# Notes on the model and release

## System model
- Downlink MU-MISO: M-antenna BS, K single-antenna users, N-element IRS.
- Channels: BS->IRS (G), IRS->user (f_k), direct BS->user (h_k), Rician
  fading with configurable path-loss exponents. See `src/channel/`.
- Objective: weighted sum rate; WMMSE-style alternating optimization with
  CVX subproblems for the precoder (W) and reflection (Theta).

## What is released vs. withheld
- Released: No-RIS, random-phase, passive, and fully-active RIS baselines
  plus all channel/geometry/SINR/solver helpers required to run them.
- Withheld: the proposed DF-aided hybrid precoder (active/passive element
  allocation + DF relay-rate term). Only the interface stub is public.

## Attribution
The active/passive-RIS alternating-optimization harness follows the
standard WMMSE + CVX formulation for active-RIS sum-rate maximization.
The baseline files were adapted and cleaned (comments translated to
English) from working research code. If you redistribute, keep this note.

## Reproducibility caveat
`run_baselines.m` uses a small Monte-Carlo count for speed. Increase
`ExNumber` for smooth, publication-grade averages. Results depend on the
CVX solver; SDPT3/SeDuMi are sufficient.
