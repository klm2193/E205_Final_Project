% E205 Lab 4 PD Linear Control on satellite

% theta is satellite attitude angle
% u is control input
% J is moment of intertia about mass center

r = 1;   %rad
thetar = r; %theta reference
thetardot = 0;

zeta = 1;
omegan=10;

J = 2;
Jhat=1;

mup = 1;
mud = 10;

T = 0.01;
N = 1/T;
tspan=[0:T:N*T];
sim('E205_Lab4_satellitesim',tspan)
plot(tout,yout)
legend('theta','P','D','thetam','thetadot','Jd^2\theta/dt^2')

y= yout(:,1);
ym= yout(:,4);
ydot= yout(:,5);
ymdot=yout(:,7);
u= yout(:,6);

x1= y-ym;
% x2=ydot-ymdot;
x2=yout(:,9);

I=0;
for i=1:length(yout)
    k = T*(x1(i)^2 +x2(i)^2 +u(i)^2/100);
    I = I+k;
end