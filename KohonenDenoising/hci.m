function [ result ] = hci( iter, j, k, jc, kc, qx, qy )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


    result = alpha(iter).*exp(-(dci(j,k,jc,kc,qx,qy))./(2*sigma(iter, qx*qy)));
    
    
   
end

