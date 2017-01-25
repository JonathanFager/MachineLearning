function [ f ] = Gauss2D( x,y,r )
mu = [1;1];
% Sigma = [0.1 -0.05; -0.05 0.2]
S = 1/(0.02-0.05^2)*[0.2 0.05; 0.05 0.1];
x = [x y];
f = (x'-mu)'*S*(x'-mu)/2 -r;


end

