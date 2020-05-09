function [xdot,y] = sys_gesamt(x,t,yp)
global u2
[dumx,y(3)] = sys1(x,0,t);
[u1] = subtraktion(u2,y);
[dumx,y(1)] = hysteresis(u1,yp,t);
u3 = y(1);
[xdot,y(3)] = sys1(x,u3,t);