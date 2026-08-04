function Ht = make_Rician(LoS, Nt_rows, Nt_cols, kappa)
    if isinf(kappa)
        Ht = LoS; % pure LoS (paper uses Inf as LoS)
    else
        Hnlos = (randn(Nt_rows,Nt_cols)+1j*randn(Nt_rows,Nt_cols))/sqrt(2);
        Ht = sqrt(kappa/(1+kappa))*LoS + sqrt(1/(1+kappa))*Hnlos;
    end
end
