% Gruppe 13
% Liu       Jiangfeng
% Forkel	Vincenz Christian
% Kirchner	Max
% Suwinski	Patrick

function [J] = Jacobimatrix(h)

global c1
global c2
global r

J = single([1   0  -h/(2*c1)     0      0   0
            0   1     0      -h/(2*c2)  0   0
            0   0     1          1      0   -1
            0   0     0          0      -1  r
            1   0     0          0      1   0
            1   -1    0          0      0   0]);
end
