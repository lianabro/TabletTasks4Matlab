% function fsave.m  -- a function that saves tab delimited file with data to N decimal places.
% call = fsave(Matrix, filename) 

% N must be less than 8.

% by Liana Brown -- November 12, 1999

function fsave(M,fn);


[z,p] = size(M);
fid = fopen(fn, 'w');
for i = 1:z
	for ii = 1:p
       fprintf(fid,'%6.6f\t',M(i,ii));
   end;
   fprintf(fid,'\n');
end;
fclose(fid);     
%end function fsave