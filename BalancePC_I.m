function bal=BalancePC(trials)
% Balance - assign values to design arrays_
% sets up the design of the experiment_ Create an array (table) in which
% all possible trial types are present_ A procedure (setTrial) below will
% randomly select one of those trial types_

for i=1:trials
    order(i) = 0;
    bal(i).vel=0;
    bal(i).accel=0;
end;

i=0;

if trials == 6
    for acc = 0:.00005:.00005
        for vel = 1:3
            %for repp = 1:3
                i=i+1;
                bal(i).accel=acc; %0=left, 1=right
                bal(i).vel=vel;
            %end;
        end;
    end;
end
if trials == 18
    for acc = 0:.00005:.00005
        for vel = 1:3
            for repp = 1:3
                i=i+1;
                bal(i).accel=acc; %0=left, 1=right
                bal(i).vel=vel;
            end;
        end;
    end;
end

for acc = 0:.00005:.00005
    for vel = 1:3
        for repp = 1:10
            i=i+1;
            bal(i).accel=acc; %0=left, 1=right
            bal(i).vel=vel;
        end;
    end;
end;

