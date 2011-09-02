function dynInfo(fun)

%@info:
%! @deftypefn {Function File} dynInfo (@var{fun})
%! @anchor{dynInfo}
%! Displays internal documentation of matlab/octave routine @var{fun.m}.
%!
%! @strong{Inputs}
%! @table @var
%! @item fun
%! string, name of the matlab/octave routine for which internal documentation is needed.
%! @end table
%!
%! @strong{Outputs}
%! None
%!
%! @strong{This function is called by:}
%! @ref{dynare}, @ref{build_internal_documentation}
%!
%! @strong{This function calls:}
%! @ref{get_internal_doc_block}.
%!
%! @end deftypefn
%@eod:

% Copyright (C) 2011 Dynare Team
% stephane DOT adjemian AT univ DASH lemans DOT fr
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

dynare_config([],0);

[pathstr, name, ext] = fileparts(which(fun));
if strcmp(ext(2:end),'m')
    block = get_internal_doc_block(name,pathstr);
    if ~isempty(block)
        fid = fopen([fun '.texi'],'wt');
        for i=1:size(block,1)
            fprintf(fid,'%s\n',deblank(block(i,:)));
        end
        fclose(fid);
        disp(' ')
        disp(' ')
        system(['makeinfo --plaintext --no-split --no-validate ' fun '.texi']);
        delete([fun '.texi']);
    else
        disp('No documentation for this routine!')
    end
else
    disp('Not a known matlab/octave routine!')
end