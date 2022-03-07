function area = pariomino_area ( p )

%*****************************************************************************80
%
%% pariomino_area() returns the area of a pariomino.
%
%  Discussion:
%
%    A pariomino is a shape formed by connecting unit squares edgewise.
%
%    A pariomino can be represented by an MxN matrix, whose entries are
%    +1 or -1 for squares that are part of the pariomino, and 0 otherwise.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    30 April 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer P(MP,NP), a matrix of -1's, 0's and +1's representing the pariomino.  
%
%  Output:
%
%    integer AREA, the area of the pariomino.
%
  area = sum ( sum ( abs ( p ) ) );

  return
end
