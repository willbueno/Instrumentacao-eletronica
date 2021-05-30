% Sensor temperatura
% 10mV/ºC
% Temp minima - 10 ºC
% Temp maxima - 80 ºC

clc
clear all
close all

format short e

Vs = 5;
R1 = Vs/50e-6;

VarC = 10e-3;
Vout_10 = 10*VarC;
Vout_80 = 80*VarC;

V_ard_max = 5;
V_ard_min = 0;

a = (V_ard_max-V_ard_min)/(Vout_80-Vout_10);
b = -a*Vout_10;
%%
ntotal = 80;
temperatura = VarC*ones(1,ntotal);
y = zeros(1,ntotal);

for k=1:ntotal
    y(k) = temperatura(k)*a+b;
    if k<ntotal
        temperatura(k+1) = temperatura(k)+VarC;
    end
end
plot(temperatura,y,'r')
xlabel("Tensão Sensor (V)")
ylabel("Tensão Arduino")
hold on
line([0.1 0.1], [-1 6])
line([0.8 0.8], [-1 6])
line([0 0.9], [0 0])
line([0 0.9], [5 5])

% 
% 
% temp = [0:1e-3:80e-3];
% y = ones(1,81);
% b_m = b*ones(1,81);
% y = a*temp;
% y = y+b_m;

%% Ganho não inversor Av = -Rf/Ri;
% Offset
Av = b/5;
Ri = 10e3;
Rf = (-Av)*Ri;

%% Ganho Inversor Av = 1+Rf/Ri
% Ganho
Av = a;
Ri = 10e3;
Rf = (Av-1)*Ri;

%% Filtro Anti-Aliasing
fs = 9600;
fc = fs/2;
R = 1e3;
C = 1/(2*pi*R*fc)