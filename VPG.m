function [x_VPG,y,hn] = VPG(model_name,x,u,t,h,yp,i)
to = 5*10^(-5); %Toleranz LDF
global d
% derivatives @ t, t+h/2, t+h
[k1, y]   = feval(model_name, x,        t,yp     );
[k2, dum] = feval(model_name, x+h(i)/2*k1, t+h(i)/2,yp );
[k3, dum] = feval(model_name, x+h(i)*2*k2-h(i)*k1, t+h(i),yp);
% RK4 integration step
x_VPG = x + h(i)*k2;
d(i+1) = h(i)/6*(k1-2*k2+k3);
hn = h(i)*(to/max(abs(d(i+1))))^(1/3);
