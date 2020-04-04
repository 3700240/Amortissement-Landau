function [f] = B1Spline(y) % Version optimisée
    f = (abs(y)<=1) .* (1-abs(y));
end

% function [f] = B1Spline(y) (équivalent mais beaucoup moins performant !)
% %UNTITLED Fonction B1-Spline
% %   Detailed explanation goes here
%     f = zeros(1,length(y));
%     for i =1:length(y)
%         if(abs(y(i))<=1)
%             f(i)=1-abs(y(i));
%         end % Pas besoin de else car f est init à 0
%     end
% end

