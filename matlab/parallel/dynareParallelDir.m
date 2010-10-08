function dirlist = dynareParallelDir(filename,PRCDir,Parallel)
% PARALLEL CONTEXT
% In a parallel context, this is ...
%
%
% INPUT/OUTPUT description:
%
%
%
% Copyright (C) 2009-2010 Dynare Team
%
% This file is part of Dynare.
%
% Dynare is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <http://www.gnu.org/licenses/>.

dirlist=[];
for indPC=1:length(Parallel),
    if isunix || (~matlab_ver_less_than('7.4') && ismac),
        if Parallel(indPC).Local==0,
            [check, ax]=system(['ssh ',Parallel(indPC).user,'@',Parallel(indPC).PcName,' ls ',Parallel(indPC).RemoteFolder,'/',PRCDir,'/',filename]);
        else
            ax=ls(filename);

        end
        dirlist = [dirlist, ax];
    else
        if Parallel(indPC).Local==0,
            ax=ls(['\\',Parallel(indPC).PcName,'\',Parallel(indPC).RemoteDrive,'$\',Parallel(indPC).RemoteFolder,'\',PRCDir,'\',filename]);
        else
            ax=ls(filename);
        end
    dirlist = [dirlist; ax];
    end
end
