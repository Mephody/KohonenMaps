function [ result ] = alpha( iter )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   Just a function.
    if iter>9
        result=1/((iter-9).^(0.2));
    else
        result=1;
    end

end

