% run_baselines.m
% -------------------------------------------------------------------------
% Minimal, self-contained driver that reproduces the BENCHMARK sum-rate
% curves (No-RIS, random-phase RIS, passive RIS, fully-active RIS) versus
% BS-user distance for the MU-MISO system model used in the paper.
%
% The proposed DF-aided hybrid scheme is NOT run here (see
% src/proposed/DF_hybrid_precoding_STUB.m and README). This driver is a
% clean re-write of the original working script with the proposed-scheme
% calls removed, so it runs end-to-end using only the released code.
%
% Requirements: MATLAB + CVX (http://cvxr.com/cvx). Add src/ and its
% subfolders to the path:  addpath(genpath('src'));
% -------------------------------------------------------------------------

clear; clc;
addpath(genpath(fileparts(mfilename('fullpath'))));

tic;

% ---- system parameters --------------------------------------------------
user_X   = 100:50:600;   % BS-user horizontal distance sweep (m)
ExNumber = 50;           % Monte-Carlo trials per point (paper uses more)

M       = 4;             % BS antennas
K       = 4;             % users
N       = 512;           % IRS elements
Ps_max  = 10;            % BS power budget (mW)
Pr_max  = 10;            % active-RIS amplification budget (mW)

sigma2  = 1e-10;         % user noise power
sigmar2 = sigma2;        % active-element noise power
f_c     = 5;             % carrier frequency (GHz)
eta_k   = ones(K,1);     % equal user weights

large_fading_AI = 2.2;   % path-loss exponent, BS/RIS -> user (indirect)
large_fading_DI = 2.2;   % path-loss exponent, BS -> user (direct)

% ---- result containers --------------------------------------------------
nX = numel(user_X);
Rsum_no     = zeros(nX, ExNumber);
Rsum_random = zeros(nX, ExNumber);
Rsum_pass   = zeros(nX, ExNumber);
Rsum_act    = zeros(nX, ExNumber);

for a = 1:nX
    fprintf('distance point %d / %d (X = %d m)\n', a, nX, user_X(a));
    for b = 1:ExNumber
        [Dis_BStoRIS, Dis_BStoUser, Dis_RIStoUser] = Position_generate(K, user_X(a));
        [h_k, f_k, G] = Channel_generate(K, N, M, large_fading_AI, large_fading_DI, ...
                                         Dis_BStoRIS, Dis_BStoUser, Dis_RIStoUser, f_c);

        Theta = diag(exp(1j*2*pi*rand(N,1)));
        W     = exp(1j*2*pi*rand(K*M,1)) * sqrt(Ps_max/K/M);

        % No RIS
        [W, Rsum_no(a,b)]     = NoRIS_precoding(M,K,N,Ps_max,sigma2,eta_k,W,h_k,f_k,G);
        % Random-phase RIS
        [W,~,Rsum_random(a,b)]= random_RIS_precoding(M,K,N,Ps_max,sigma2,eta_k,Theta,W,h_k,f_k,G);
        % Passive RIS (optimized phases)
        [W,Theta,Rsum_pass(a,b)]= passive_RIS_precoding(M,K,N,Ps_max,sigma2,eta_k,Theta,W,h_k,f_k,G);
        % Fully-active RIS
        Theta = 100*Theta;
        [W,Theta,Rsum_act(a,b)] = active_RIS_precoding(M,K,N,Ps_max*0.99,Pr_max*0.01, ...
                                     sigma2,sigmar2,eta_k,Theta,W,h_k,f_k,G);
    end
end

R_no  = mean(Rsum_no,2);
R_rnd = mean(Rsum_random,2);
R_pas = mean(Rsum_pass,2);
R_act = mean(Rsum_act,2);

figure; hold on; box on; grid on;
plot(user_X, R_act,'-r^','LineWidth',1.5,'MarkerSize',7);
plot(user_X, R_pas,'-bo','LineWidth',1.5,'MarkerSize',7);
plot(user_X, R_rnd,'-ms','LineWidth',1.2,'MarkerSize',6);
plot(user_X, R_no ,'--k','LineWidth',1.2);
xlabel('BS-user distance (m)'); ylabel('Sum rate (bit/s/Hz)');
legend('Active RIS','Passive RIS','Random RIS','No RIS','Location','best');
title('Baseline sum rate vs. distance (proposed hybrid scheme not shown)');

toc;
