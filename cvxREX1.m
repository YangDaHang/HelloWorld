Ab = 70;
Bb = 320;
Qb = 50;
sigma_b = 1;

alpha = 0.15;
beta = 400;
delta = 268;
Nb = 2000;
Rb = 0.6;
Ts = 5;
T = 500;
N = T / Ts;
Pm = rand(N,1)*70 - 10;
E_max = 30;
E_min = 0;
Pb_max = 60;
Pb_min = -60;
Pg = 8;


cvx_begin 
    variable q(N,1)
    variable E(N,1)
    variable Pb(N,1)
    J = alpha * (E(1) - E(N)) ... 
       + sum(beta * Ts * sigma_b * abs(Pb) / Nb) ...
       + sum(delta * Ts * q * Pg); 
    minimize  J
    subject to
        Pm <= Pb + q * Pg
        Pb >= Pb_min
        Pb <= Pb_max
        Pb <= E * Ab / (4*Rb*Qb)
        for k = 1:N
            E(k+1) <= E(k) * (1 - Ts*Ab/(Rb*Qb)) + Ts*Ab*sqrt(E.^2 - 2*Rb*Qb*Pb.*E/Ab)
        end        
        E >= E_min
        E <= E_max
        
        E(1) == E_max
        q <= 1
        q >= 0
cvx_end

