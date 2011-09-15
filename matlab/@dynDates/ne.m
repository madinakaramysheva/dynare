function c = ne(a,b)

%@info:
%! @deftypefn {Function File} {@var{c} =} ne (@var{a},@var{b})
%! @anchor{@dynDates/ne}
%! @sp 1
%! Overloads the ne (not equal) operator for the Dynare dates class (@ref{dynDates}).
%! @sp 2
%! @strong{Inputs}
%! @sp 1
%! @table @ @var
%! @item a
%! Dynare date object instantiated by @ref{dynDates}.
%! @item b
%! Dynare date object instantiated by @ref{dynDates}.
%! @end table
%! @sp 1
%! @strong{Outputs}
%! @sp 1
%! @table @ @var
%! @item c
%! scalar integer equal to one if a~=b, 0 otherwise.
%! @end table
%! @sp 2
%! @strong{This function is called by:}
%! @sp 2
%! @strong{This function calls:}
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

verbose = 0;

if nargin~=2
    error('dynDates::ne: I need exactly two input arguments!')
end

if ~( isa(a,'dynDates') && isa(b,'dynDates'))
    error(['dynDates::ne: Input arguments ' inputname(1) 'and ' inputname(2) ' have to be a dynDates objects!'])
end

if verbose && a.freq~=b.freq
    disp(['dynDates::ne: Input arguments ' inputname(1) 'and ' inputname(2) ' have no common frequencies!'])
    c = 1;
end

c = ~isequal(a.time,b.time);

%@test:1
%$ addpath ../matlab
%$
%$ % Define some dates
%$ date_1 = 1950;
%$ date_2 = '1950Q2';
%$ date_3 = '1950M10';
%$ date_4 = '1950W50';
%$ date_5 = '1950W32';
%$
%$ % Call the tested routine.
%$ d1 = dynDates(date_1);
%$ d2 = dynDates(date_2);
%$ d3 = dynDates(date_3);
%$ d4 = dynDates(date_4);
%$ d5 = dynDates(date_5);
%$ i1 = (d1~=d2);
%$ i2 = (d2~=d2);
%$ i3 = (d4~=d5);
%$
%$ % Check the results.
%$ t(1) = dyn_assert(i1,1);
%$ t(2) = dyn_assert(i2,0);
%$ t(3) = dyn_assert(i3,1);
%$ T = all(t);
%@eof:1