function Wscaled = scale_precoder_to_budget(W, budget)
% scale_precoder_to_budget  Scale precoder matrix W so its tx power <= budget (W)
%   If budget <= 0, returns zeros of same size. If W empty or zero-power, returns W.
    if isempty(W) || budget <= 0
        Wscaled = zeros(size(W));
        return;
    end
    pcur = sum(abs(W(:)).^2);
    if pcur <= 0
        Wscaled = W;
        return;
    end
    sf = sqrt(max(budget,0) / pcur);
    Wscaled = W * sf;
end