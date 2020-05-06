function [Ep] = interpolation_champ(x,E,p)
    % Interpolation du champ E (dont on connait l'expression sur x) au(x) point(s) p
    
    h = x(2)-x(1);
    np = length(p);
    Ep = zeros(1,np);
    
    for i=1:np
        if p(i) == 0
            disc_floor = 1;
            disc_ceil = 2;
        else
            disc_ceil = ceil(p(i)/h)+1;
            disc_floor = disc_ceil - 1;
        end
        

        E_ceil = E(disc_ceil);
        E_floor = E(disc_floor);

        a = (E_ceil-E_floor)/(x(disc_ceil)-x(disc_floor));
        Ep(i) = E_floor + a * (p(i)-x(disc_floor));
    end
end
