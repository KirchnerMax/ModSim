[A3,B3,C3,D3]=dlinmod('Aufgabe2_3_offenerKreis',15e-3);
%[num,den]=ss2tf(A3,B3,C3,D3);
dbode(A3,B3,C3,D3,15e-3);
grid on
%margin(tf(num,den));