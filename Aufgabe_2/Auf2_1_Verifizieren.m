[A,B,C,D]=linmod('Aufgabe2_1',0,0);
[num,den]=ss2tf(A,B,C,D);
G=tf(num,den);
Kf = Kl*Ksv*b1;
a1 = b1/cp+b1/coe;
a2 = mg/cp;
a3 = (mg*b1)/(cp*coe);
num = num*a3;
den = den*a3;