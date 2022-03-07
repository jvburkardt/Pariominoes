function pin = pariomino_index ( p )

%*****************************************************************************80
%
%% pariomino_index() assigns an index to each nonzero entry of a polyomino.
%
%  Discussion:
%
%    The indexing scheme arbitrarily proceeds by rows.
%
%  Example:
%
%    P = 
%      +1  0 +1 -1
%      -1 +1 -1  0
%       0 -1 +1  0
%
%    PIN =
%      1 0 2 3
%      4 5 6 0
%      0 7 8 0
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    02 May 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer P(M,N), the pariomino, with entries -1, 0, or +1.
%
%  Output:
%
%    integer PIN(M,N), the index of each nonzero entry.
%
  [ m, n ] = size ( p );

  pv = reshape ( p', m * n, 1 );

  pv = abs ( pv );

  pc = cumsum ( pv ) .* pv;

  pin = reshape ( pc, n, m );

  pin = pin';

  return
end
