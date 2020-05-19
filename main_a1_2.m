% MODSIM Laborpraktikum, 1. Aufgabe
% Prof. K. Janschek, Dr.-Ing. Th. Range, Dr.-Ing. S. Dyblenko
%
% main_a1.m - Realisierung der VPG-Methode mit Fehlerschätzung
% fuer PT1-Glied
% zu ergänzende Codezeilen sind mit ">>> ergänzen ...." und ... gekennzeichnet
clear all % Lösche Arbeitsspeicher
Tm = 10; % Konstante des PT1, [s]
h = [];
h(1)=0.1;% Schrittweite, (s)
t0 = 0; % Integrationsbeginn, [s]
tf = 300; % Integrationsende, [s]
t = []; % Zeitwerte fuer Plot [s]
d = []; % Fehler-Schaetzwerte
u = []; % Stellwerte u(t)
y = []; % Ausgangswerte y(t)
ys = []; % Soll-Ausgangswerte y_soll(t)
to = 10*10^(-6); %Toleranz LDF
hmin = 12*to;
% Initialisierung
[dum,x(1)] = system_pt1([],[],[],0);
d(1) = 0;
% Integration nach VPG-Methode
ti = t0;
i = 1;

while ti <= tf
    % Berechnung des Soll-Ausgangswertes
    ys(i) = x(i);
    % Berechnung des Stellwertes
    u(i) = 5*stepfun(ti,1);
    % Berechnung des Ausgangswertes
    y(i) = system_pt1(ti ,x(i) ,u(i) , 3); %die Parameter einsetzen
    % Berechnung der Koeffizienten für VPG-Methode
    k1 = system_pt1( ti ,x(i) ,u(i) , 1); %die Parameter einsetzen
    k2 = system_pt1( ti+h(i)/2 , x(i)+h(i)/2*k1 ,u(i), 1); %die Parameter einsetzen
    k3 = system_pt1(ti+h(i) , x(i)-h(i)*k1+2*h(i)*k2 ,u(i), 1); %die Parameter einsetzen
    % Wichtiger Hinweis: Die Parameter bei den Aufrufen von system_pt1(...)
    % müssen unter Beachtung von jeweiligen Zeitpunkten bestimmt werden!
    % Berechnung des Zustands-Schätzwertes x(ti+h)
    x(i+1) = x(i)+h(i)*k2;
    % Berechnung der LDF Fehlerabschätzung d(ti+h)
    d(i+1) = h(i)/6*(k1-2*k2+k3);
    %Berechnung der neuen Schrittweite hn
    hn = h(i)*(to/max(abs(d(i+1))))^(1/3);
    %Schrittweite anpassen  und Index wird erhöht
    if hn>2*h(i)&&hn<20
        h(i+1) = hn;
        t(i) = ti; % Zeitwert für Plot speichern
        ti = ti + h(i); % Zeitvariable um einen Schritt erhöhen
        i = i + 1; % Index inkrementieren
    %Schrittweite anpassen und Integration wiederholen    
    elseif (hn>hmin)&&(hn<=h(i))
        h(i) = 0.75*hn;
    %Schrittweite bleibt unverändert und Index wird erhöht  
    else 
        h(i+1)=h(i);
        t(i) = ti; % Zeitwert für Plot speichern
        ti = ti + h(i); % Zeitvariable um einen Schritt erhöhen
        i = i + 1; % Index inkrementieren
    end   
end
d = d(1:end-1);
result = [t;d];
% Anzeige der Ergebnisse
figure(1);
subplot(3,1,1); plot(t,u); title('Eingang PT1-Glied');zoom on;grid on;
subplot(3,1,2); plot(t,y); title('Ausgang PT1-Glied');zoom on;grid on;
subplot(3,1,3); plot(t,ys); title('reeller Ausgang PT1-Glied');zoom on;grid on;
xlabel('Zeit, s');
figure(2);
subplot(2,1,1); plot(t,y-ys,'.-'); title('GDF berechnet');zoom on;grid on;
tit=sprintf('LDF geschätzt: max. Betrag = %g',max(abs(d)));
subplot(2,1,2); plot(t,d,'.-'); title(tit);zoom on;grid on;
xlabel('Zeit, s');
figure(3);
plot(t,h(1:end-1));title('Schrittweite');zoom on;grid on;
xlabel('Zeit,s')
