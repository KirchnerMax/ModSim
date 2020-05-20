%Berechnung phi und h
[A,B,C,D]=linmod('Aufgabe2_1');
Ta = 15e-3; %[s]
h = Ta;
Phi = expm(A*Ta);
H = inv(A)*(Phi - eye(3)) * B;
