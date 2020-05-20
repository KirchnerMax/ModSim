% MAIN SIMULATION PROGRAM: sim_closed.m
clear all
% Systemparameter
model_name = 'sys_gesamt';
global to
to = 5*10^(-9); %Toleranz LDF
hmin = 60*to;
%   Sumulationsparameter
t  = 0;                 % simulation start time
tf = 20;                % simulation stop time
h(1)  = 0.01;           % constant stepsize
global d;
d = [0];
global ha
ha = 0.065;
global he
he = 0.085;
global Tm
Tm = 10;
% Anfangswerte
x = 0;              % x ... system state vector
yp = 0;

% simulation
flag = 0; %Mit fester Schrittweite (==0) oder Schrittweitensteuerung (==1)
global u2
u2 = 0.17; %Festlegung der Sollgroesse

%Berechnung Impulsbreite und Impulsperiode
te = -Tm*log(1-(he-ha)/(1+he-abs(u2)));
tp = Tm*log((1-ha/abs(u2))/(1-he/abs(u2)))+te;

i=1;
while t <= tf         %   loop t = t0...tf
    if i >1
        yp = y_values(i-1,1);
    end
    [x,y,hn] = VPG(model_name,x,t,h,yp,i);
    
    if flag ==1
        %Schrittweite wird angepasst und Index wird erhöht
        if hn>1.5*h(i) && hn<0.5
            h(i+1) = hn;
            x_values(i,:) = x;
            y_values(i,:) = y;
            t_values(i) = t;    % Zeitwert fuer Plot speichern
            t = t + h(i);       % Zeitvariable um einen Schritt erhoehen
            i = i + 1;          % Index inkrementieren
        %Schrittweite wird angepasst und Integration wird wiederholt
        elseif (hn>hmin)&&(hn<=h(i))
            h(i) = 0.75*hn;
        %Schrittweite bleibt erhalten und Index wird erhöht
        else 
            h(i+1)=h(i);
            x_values(i,:) = x;
            y_values(i,:) = y;
            t_values(i) = t;    % Zeitwert fuer Plot speichern
            t = t + h(i);       % Zeitvariable um einen Schritt erhoehen
            i = i + 1;          % Index inkrementieren
        end
    else
        h(i+1)=h(i);
        x_values(i,:) = x;
        y_values(i,:) = y;
        t_values(i) = t;        % Zeitwert für Plot speichern
        t = t + h(i);           % Zeitvariable um einen Schritt erhoehen
        i = i + 1;              % Index inkrementieren
    end
end % while

% result visualisation
figure(1);
subplot(2,1,1); plot(t_values,y_values(:,1)); title('Ausgang');zoom on;grid on;
subplot(2,1,2); plot(t_values,y_values(:,3)); title('Ausgang PT1-Glied');zoom on;grid on;
xlabel('Zeit, s');
figure(2);
plot(t_values,d(2:end)); title('LDF berechnet');zoom on;grid on;
xlabel('Zeit, s');
figure(3)
plot(t_values,h(1:end-1)); title('Schrittweite');zoom on;grid on;
xlabel('Zeit, s');
