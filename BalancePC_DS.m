function bal=BalancePC(trials)
% Balance - assign values to design arrays_
% sets up the design of the experiment_ Create an array (table) in which
% all possible trial types are present_ A procedure (setTrial) below will
% randomly select one of those trial types_

for i=1:trials; % 
    order(i) = 0;
    bal(i).targloc=0;
    bal(i).jumppres=0;
    bal(i).jumptarg=0
    bal(i).jumpdir = 0;
end;

i=0;
if trials == 48
    for targ = 2:4
        for repp = 1:12; %36 when hand is added
            i=i+1;
            bal(i).targloc=targ; %0=left, 1=middle, 2=right
            bal(i).jumpdir=0; %none
            bal(i).jumppres = 0;
            bal(i).jumptarg = 0;
        end;
    end;

    for tgt = 2:4
        for jump = 1:2 %up or down
            for repp = 1:2 %12 jump present trials/block
                i=i+1;
                bal(i).targloc=tgt;
                bal(i).jumppres = 1;
                bal(i).jumpdir = jump;
                if tgt == 2 && jump == 1
                    bal(i).jumptarg = 1;
                elseif tgt == 2 && jump == 2;
                    bal(i).jumptarg = 3;
                elseif tgt == 3 && jump == 1
                    bal(i).jumptarg = 2;
                elseif tgt == 3 && jump == 2;
                    bal(i).jumptarg = 4;
                elseif tgt == 4 && jump == 1
                    bal(i).jumptarg = 3;
                elseif tgt == 4 && jump == 2;
                    bal(i).jumptarg = 5;
                end;
            end;
        end;
    end;
end;
if trials == 24
    for targ = 2:4
        for repp = 1:6; %18 when hand is added
            i=i+1;
            bal(i).targloc=targ; %0=left, 1=middle, 2=right
            bal(i).jumpdir=0; %none
            bal(i).jumppres = 0;
            bal(i).jumptarg = 0;
        end;
    end;

    for tgt = 2:4
        for jump = 1:2 %up or down

            i=i+1;
            bal(i).targloc=tgt;
            bal(i).jumppres = 1;
            bal(i).jumptarg = jump;
            if tgt == 2 && jump == 1
                bal(i).jumptarg = 1;
            elseif tgt == 2 && jump == 2;
                bal(i).jumptarg = 3;
            elseif tgt == 3 && jump == 1
                bal(i).jumptarg = 2;
            elseif tgt == 3 && jump == 2;
                bal(i).jumptarg = 4;
            elseif tgt == 4 && jump == 1
                bal(i).jumptarg = 3;
            elseif tgt == 4 && jump == 2;
                bal(i).jumptarg = 5;
            end;

        end;
    end;
end;

