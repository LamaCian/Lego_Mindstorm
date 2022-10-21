
function [xs, ys, Ht] = predvidjanje_merenja(xr, yr, tetar)
l=4.5;
xs = xr+l*cos(tetar);
ys = yr+l*sin(tetar);
Ht = [1 0 -l*sin(tetar); 0 1 l*cos(tetar)];
end