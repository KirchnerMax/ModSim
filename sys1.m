% SUBSYSTEM DESCRIPTION: system_1.m

function  [xdot,y] = sys1(x,u,t)
% state equation (derivative)
global Tm
xdot(1) = -x(1)/Tm + u(1)/Tm;

% output equation    
y(1)= x(1);