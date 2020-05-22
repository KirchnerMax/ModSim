clear all
[A,B,C,D]=linmod('Aufgabe2_1',0,0);
Ta = 0.015;
h = Ta;
phi = expm(h*A);
H = inv(A)*(phi-eye(3))*B;