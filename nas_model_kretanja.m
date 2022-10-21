function [polozaji,C] = nas_model_kretanja(x, C, dsl, dsr, razmakTockova, Cu)

x = x + ((dsl+dsr)/2)*(cos(theta+(dsr-dsl)/(2*razmakTockova)));
y = y + ((dsl+dsr)/2)*(sin(theta+(dsr-dsl)/(2*razmakTockova)));
theta = theta + (dsr - dsl)/razmakTockova;

V = [diff(x, dsl), diff(x, dsr);
    diff(y, dsl), diff(y, dsr);
    diff(theta, dsl), diff(theta, dsr)];

alpha = 10e-5; %ne znamo sta je ovo
alpha2 = 10e-5; %ne znamo sta je ovo
alpha3 = 10e-5; %ne znamo sta je ovo
alpha4 = 10e-5; %ne znamo sta je ovo

M = [(abs(dsl) * alpha + alpha2 * abs(dsr))^2, 0;
    0, (abs(dsl) * alpha3 + alpha4 * abs(dsr))^2];

C = M*C*M' + V*Cu*V';

polozaji = [x, y, theta];
