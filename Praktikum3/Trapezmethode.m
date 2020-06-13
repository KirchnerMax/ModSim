% Gruppe 13
% Liu       Jiangfeng
% Forkel	Vincenz Christian
% Kirchner	Max
% Suwinski	Patrick

function [phi] = Trapezmethode(p,p_alt,u,h)

[f,g]       = DAEmodell(p_alt(1:2),p_alt(3:6),u); 
[fneu,gneu] = DAEmodell(p(1:2) ,p(3:6) ,u);

phi(1) = single(p(1) - p_alt(1) - h/2*( f(1) + fneu(1) ));
phi(2) = single(p(2) - p_alt(2) - h/2*( f(2) + fneu(2) ));
phi(3) = single(gneu(1));
phi(4) = single(gneu(2));
phi(5) = single(gneu(3));
phi(6) = single(gneu(4)); 

phi = phi';%phi ist ein Spaltvektor
end

