% final project

clear
clc

% define constants
r = 1; % rad
zeta = 1;
wn = 10; % rad/s
J = 2;
Jhat = 1;
thetar = r;
T = 0.01; % s
N = 1/T;
thetardot = 0;
mup = 10;
mud = 10;

disturbance = 10;

P = J*wn^2;
D = J*2*zeta*wn;

% run the simulation
tspan = [0:T:N*T];
[t,x,y] = sim('satelliteSim', tspan);
plot(t,y(:,1),t,y(:,2),t,y(:,3),t,y(:,5),t,y(:,6))
title('PD Control System (\mu_P = 10, \mu_D = 10)')
xlabel('time (s)')
legend('\theta', 'P', 'D','\theta dot', 'u = J\theta double dot')


x1 = y(:,7);
x2 = y(:,8);
u = y(:,6);
n = 1:N;
I = 0;

% performance metrics
for n = 1:N
    I = I + (T*((x1(n))^2+(x2(n))^2+((u(n))^2)/100))
end
