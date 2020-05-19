function  [u1] = subtraktion(u2,y)
%state equation
xdot(1) = 0;

% output equation    
u1= u2-y(3);