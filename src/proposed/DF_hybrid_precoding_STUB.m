function [W, Theta, Rsum] = DF_hybrid_precoding_STUB(M, K, N, Ka, Ps_max, Pr_max, ...
        sigma2, sigmar2, eta_k, Theta, W, h_k, f_k, G)
% DF_HYBRID_PRECODING_STUB  Interface stub for the proposed hybrid IRS scheme.
%
% -------------------------------------------------------------------------
%  NOTE ON RELEASE SCOPE
% -------------------------------------------------------------------------
%  This repository releases the REFERENCE / BASELINE code required to
%  reproduce the system model and the benchmark schemes (No-RIS, passive,
%  random, and fully-active RIS precoding).
%
%  The PROPOSED contribution of the associated paper -- the decode-and-
%  forward (DF) aided *hybrid* IRS precoder with per-element active/passive
%  allocation -- is NOT included in full in this public release. This file
%  documents the function INTERFACE only so the baseline harness stays
%  coherent and reviewers can see where the proposed block plugs in.
%
%  The full implementation is available from the authors on reasonable
%  request for academic, non-commercial use. See README.md ("Availability
%  of the proposed algorithm").
% -------------------------------------------------------------------------
%
% INPUTS
%   M         - number of BS antennas
%   K         - number of single-antenna users
%   N         - total number of IRS elements
%   Ka        - number of ACTIVE elements (0 <= Ka <= N); Ka=0 -> passive,
%               Ka=N -> fully active, 0<Ka<N -> hybrid
%   Ps_max    - BS transmit power budget (mW)
%   Pr_max    - active-element amplification power budget (mW)
%   sigma2    - user thermal noise power
%   sigmar2   - active-element (amplifier) noise power
%   eta_k     - (K x 1) user rate weights
%   Theta     - (N x N) initial reflection matrix
%   W         - initial BS precoder (M*K x 1 or M x K)
%   h_k,f_k,G - direct, IRS-user, and BS-IRS channels (see src/channel)
%
% OUTPUTS
%   W    - optimized BS precoder
%   Theta- optimized hybrid reflection/amplification matrix
%   Rsum - achieved weighted sum rate (bit/s/Hz)
%
% The proposed algorithm alternates, per outer iteration, between:
%   (i)   BS precoder update via WMMSE-style convex subproblem (see
%         utils/cvx_solve_W.m for the active-RIS analogue),
%   (ii)  reflection/amplification update over the active subset with a
%         per-element power cap Pr_cap derived from Ka and Pr_max,
%   (iii) active-element SELECTION / allocation over the N elements,
%   (iv)  optional DF relay-rate combining term.
% Steps (ii)-(iv) constitute the withheld contribution.

    error('DF_hybrid_precoding_STUB:withheld', ...
        ['The proposed DF-aided hybrid IRS precoder is not part of this ', ...
         'public release. Baseline schemes are in src/baseline. Contact ', ...
         'the authors for the full implementation (academic use).']);
end
