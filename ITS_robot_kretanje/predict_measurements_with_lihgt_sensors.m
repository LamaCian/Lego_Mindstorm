function [varargout] = predict_measurements_with_lihgt_sensors(pose,map, xls, yls)

% function [varargout] = measurements(pose,landmark , maxR);
% This function predicts measurements based on provided map.
% It works with one and only one light sensors. Extension to two will be
% implemented soon.
%==========================================================================
% INPUT:
%
%   pose - robot pose
%   map - list of all landmarks
%   xls - position of light sensor in robot frame
%   yls - position of light sensor in robot frame
%==========================================================================
% OUTPUT:
%   zp = [x;y]
%   H - measurement Jacobian
%==========================================================================
if isempty(map) 
    varargout{1} = [];varargout{2} = [];
    return;
end;

n = size(map,1);
% h = zeros(2*n,3);
%==========================================================================       
 dx = pose(1) + xls*cos(pose(3)) - yls*sin(pose(3));
 dy = pose(2) + xls*sin(pose(3)) + yls*cos(pose(3));
%==========================================================================    
    h11 = 1; h12 = 0; h13 = -xls*sin(pose(3)) - yls*cos(pose(3));
    h21 = 0; h22 = 1; h23 = xls*cos(pose(3)) - yls*sin(pose(3));
            h = [h11 h12 h13;...
                    h21 h22 h23];

    zp = [dx;dy];
    h = h;
%==========================================================================
%==========================================================================
varargout{1} = zp; varargout{2} = h;
