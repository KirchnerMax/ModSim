function [xdot,y] = sys_gesamt(x,t,yp)
global u2
%Ausgangsgleichung PT1
[dumx,y(3)] = sys1(x,0,t);
%Eingangsgleichung von Hysterese
[u1] = subtraktion(u2,y);
%Ausgangsgleichung Hysterese
[dumx,y(1)] = hysteresis(u1,yp,t);
%Eingangsgleichung PT1
u3 = y(1);
%Zustands- und Ausgangsgleichung PT1
[xdot,y(3)] = sys1(x,u3,t);