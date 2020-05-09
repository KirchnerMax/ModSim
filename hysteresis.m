function  [xdot,y] = hysteresis(u,yp,t)
global ha
global he
% state equation (derivative)
xdot(1) = 0;  % no states  ---> dummy output

% output equation    
if u>=he
    y = 1;
elseif u>ha && u<he
    if yp == 1
        y = 1;
    else
        y = 0;
    end
elseif u>=-ha && u<=ha
    y = 0;
elseif u>-he && u <-ha
    if yp == -1
        y = -1;
    else 
        y = 0;
    end
else
    y = -1;
end
        