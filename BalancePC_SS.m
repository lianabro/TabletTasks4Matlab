function bal=BalancePC2(trials)
% Balance - assign values to design arrays_
% sets up the design of the experiment_ Create an array (table) in which
% all possible trial types are present_ A procedure (setTrial) below will
% randomly select one of those trial types_

for i=1:trials %usually 48
    order(i) = 0;
    bal(i).targcol=0;
    bal(i).go=0;
    bal(i).SOA=0;
end;

if trials == 48
    i=0;
    for colour = 1:2
        for go = 0:1
            for SOA = 50:50:200
                for repp = 1:3
                    i=i+1;
                    bal(i).targcol = colour;
                    bal(i).go = go;
                    bal(i).SOA = SOA;
                    if go == 1
                        bal(i).SOA = 0;
                    end;
                end;
            end;
        end;
    end;
end;
    
if trials == 64
    i=0;
    for colour = 1:2
        for go = 0:1
            for SOA = 50:50:200
                for repp = 1:4
                    i=i+1;
                    bal(i).targcol = colour;
                    bal(i).go = go;
                    bal(i).SOA = SOA;
                    if go == 1
                        bal(i).SOA = 0;
                    end;
                end;
            end;
        end;
    end;
end;

if trials == 16
    i=0;
    for colour = 1:2
        for go = 0:1
            for SOA = 50:50:200
                i=i+1;
                bal(i).targcol = colour;
                bal(i).go = go;
                bal(i).SOA = SOA;
                if go == 1
                    bal(i).SOA = 0;
                end;
            end;
        end;
    end;
end;



