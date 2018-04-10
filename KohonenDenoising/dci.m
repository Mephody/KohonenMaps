function [ result ] = dci( j,k,jc,kc,dx,dy )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    temp = jc-j+(-dx:dx:dx);
    temp2 = [temp; temp; temp];
    result = min(min(sqrt((temp2).^2+(kc-k+(-dy:dy:dy)').^2)));

end

