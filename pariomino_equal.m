function value = pariomino_equal ( p1, p2 )

%*****************************************************************************80
%
%% pariomino_equal() determines if pariominoes P1 and P2 are equal.
%
%  Discussion:
%
%    P1 and P2 should only contain -1, 0 and 1 entries.
%
%    The matrix representations P1 and P2 should be "tight", that is, there 
%    should be a nonzero in the first and last rows, and in the first 
%    and last columns.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    09 May 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer P1(M1,N1), the representation of pariomino P1. 
%
%    integer P2(M2,N2), the representation of pariomino P2. 
%
%  Output:
%
%    logical VALUE, is true if P1 and P2 represent the same pariomino.
%
  [ m1, n1 ] = size ( p1 );
  [ m2, n2 ] = size ( p2 );

  if ( m1 ~= m2 )
    value = false;
  elseif ( n1 ~= n2 )
    value = false;
  else
    value = all ( all ( p1 == p2 ) );
  end

  return
end
