function p2 = polyomino_charge ( p1 )

%*****************************************************************************80
%
%% polyomino_charge() assigns a parity to each cell of a polyomino.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    06 May 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer P1(M,N), the representation of polyomino P1. 
%
%  Output:
%
%    integer P2(M,N), the representation of pariomino P2. 
%
  p2 = abs ( p1 );
  [ m, n ] = size ( p2 );

  si = +1;
  for i = 1 : m
    sj = +1;
    for j = 1 : n
      p2(i,j) = si * sj * p2(i,j);
      sj = -sj;
    end
    si = - si;
  end

  return
end
