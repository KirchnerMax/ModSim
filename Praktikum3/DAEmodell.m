% Gruppe 13
% Liu       Jiangfeng
% Forkel	Vincenz Christian
% Kirchner	Max
% Suwinski	Patrick

function [f,g] = DAEmodell(x,z,u)
global r
global c1
global c2
% Funktionen f und g
f(1) = single(z(1)/c1);
f(2) = single(z(2)/c2);
g(1) = single(z(1)+z(2)-z(4));
g(2) = single(-z(3)+r*z(4));
g(3) = single(z(3)+x(1)-u);
g(4) = single(x(1)-x(2));
end

