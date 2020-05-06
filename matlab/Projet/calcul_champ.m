function [E] = calcul_champ(phi,delta)
    % Calcul le champ E associé à phi
    %   phi:
    steps = length(phi);
    E = zeros(1,steps);
    E(1) = (phi(2)-phi(1))/delta;
    for i = 2:steps-1
        E(i) = (phi(i+1)-phi(i-1))/(2*delta);
    end
    E(steps) = -(phi(steps-1)-phi(steps))/delta;
end
