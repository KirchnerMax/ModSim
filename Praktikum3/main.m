% Gruppe 13
% Liu       Jiangfeng
% Forkel	Vincenz Christian
% Kirchner	Max
% Suwinski	Patrick

clear all;

global r;
global c1;
global c2;
r=single(100);      %Widerstand Ohm
c1=single(0.01);    %Kondensator1 F
c2=single(0.02);    %Kondensator2 F
us=10;              %Eingangsspannung V
h=single(1e-1);     %Schrittweite
t0=single(0);       %Integrationsbeginn
tend=single(30);    %Integrationsende
global schranke;
schranke = single(1e-5);   %Schranke   
t(1) = single(t0);
us_dar(1) = single(us);     %zu display eingangsgrosse us
%u2_soll(1) = single(0);
u = single(us);

% p = (x z)'ist ein Spaltvektor
% Anfangswerte von p, die Herleitung auf dem Protokoll
p = [single(0);single(0);single(u*c1/(r*(c1+c2)));single(u*c2/(r*(c1+c2)));single(u);single(u/r);];

i = 1;

while ( t <= tend )                          
    
    [p_newton, n] = Newtonraphson(p(:,i),u,h);                 
    p(:,i+1) = p_newton;    
    n_dar(i+1) = n;                          %Zahl der Iterationen zum Konvergenz                                                              
    t(i+1) = t0 + h*(i);
    u2_soll(i) = us*(1-exp(-t(i)/(r*(c1+c2))));  %analytische Loesung von u2
    i = i + 1;
    us_dar(i) = us*stepfun(t(i),0);
end
u2_soll(i) = us*(1-exp(-t(i)/(r*(c1+c2))));      %analytische Loesung von u2

figure(1);
subplot(2,1,1); plot(t,us_dar); title('Eingangsspannung us(t)'); zoom on; grid on;
subplot(2,1,2); plot(t,u2_soll); title('Sollverlauf u2(t)'); zoom on; grid on;

figure(2);
subplot(2,1,1); plot(t,p(1,1:end)); title('simulierte Ausgangsgroesse u1(t)'); zoom on; grid on;
subplot(2,1,2); plot(t,p(2,1:end)); title('simulierte Ausgangsgroesse u2(t)'); zoom on; grid on;

figure(3);
subplot(2,1,1); plot(t,p(2,1:end)-u2_soll); title(sprintf('Differenz zum Sollverlauf von u2(t)')); zoom on; grid on;
subplot(2,1,2); plot(t,n_dar); title('Zahl der Iterationen zum Konvergenz'); zoom on; grid on;