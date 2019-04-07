% pickTrial.m
% by Liana Brown 15/11/07
% used to randomly choose a trial number from balance

function [index, order] = pickTrial(order);


n=length(order);

index = ceil(n.*rand(1,1));
while order(index) == 1
    index = ceil(n.*rand(1,1));
end;
order(index)=1;