function val = gaus(x, y, s)
    K = 1 / (2 * pi * s ^ 2);
    val = K * exp(-(x^2 + y^2) / (2 * s^2));
endfunction

