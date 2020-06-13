% Gruppe 13
% Liu       Jiangfeng
% Forkel	Vincenz Christian
% Kirchner	Max
% Suwinski	Patrick

function [p,n] = Newtonraphson(p_alt,u,h)
global schranke
p = p_alt;
n = 0;    %Zahl der Iterationen zum Konvergenz               
while 1
    p_neu = single(p - inv(Jacobimatrix(h)) * Trapezmethode(p,p_alt,u,h)); 
    Differenz = single(norm(p_neu - p));
     n = n + 1;
    if (Differenz <= schranke)                                  
       break;
    end
    if n > 20
        disp(['Error beim Konvergenz']);
        break;
    end
    p = p_neu;
end

