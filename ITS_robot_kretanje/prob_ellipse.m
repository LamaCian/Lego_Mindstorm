function h = prob_ellipse(sv,C,color,sc_fac)
% This function plots probabilistic ellipses of uncertainty for robot pose
% as well as landmark.
n = length(sv)/3;
for k = [0 : 1 : n-1] 
    i = 3*k + (1:2);
    s=sv(i);
    c=C(i,i);
    h = plot_probellipse(s,c,color,sc_fac);
end

