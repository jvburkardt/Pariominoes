function q = pariomino_transform ( p, rotate, reflect )

%*****************************************************************************80
%
%% pariomino_transform() transforms a pariomino.
%
%  Discussion:
%
%    A pariomino can be rotated or reflected.
%
%    This program is given a pariomino and returns the resulting pariomino
%    after the specified reflection and rotation.
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
%    integer P(M,N), a matrix of -1's, 0's and 1's representing the 
%    pariomino.  The matrix should be "tight", that is, there should be a
%    nonzero in row 1, and in column 1, and in row M, and in column N.
%
%    integer ROTATE, is 0, 1, 2, or 3, the number of 90 degree
%    counterclockwise rotations to be applied.
%
%    integer REFLECT, is 0 or 1.  If it is 1, then each row of the
%    pariomino matrix is to be reflected before any rotations are performed.
%
%  Output:
%
%    integer Q(MQ,NQ), the transformed pariomino.
%
  reflect = mod ( reflect, 2 );

  if ( reflect == 1 )
    q = fliplr ( p );
  else
    q = p;
  end

  rotate = mod ( rotate, 4 );

  for k = 1 : rotate
    q = flipud ( q' ); 
  end

  return
end
