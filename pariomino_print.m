function pariomino_print ( p, label )

%*****************************************************************************80
%
%% pariomino_print() prints a pariomino.
%
%  Discussion:
%
%    A pariomino is represented as a subset of an MxN grid.
%    The matrix entry Pij is 0 if square(i,j) is not part of the pariomino.
%    Otherwise, it is -1 (black) or +1 (white).
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
%    integer P(M,N), a matrix representing the pariomino.  
%
%    string LABEL, a label to be printed.  
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '%s\n', label );
  fprintf ( 1, '\n' );

  [ m, n ] = size ( p );

  if ( m <= 0 | n <= 0 )
    fprintf ( 1, '  [ Null matrix ]\n' );
  else
    for i = 1 : m
      fprintf ( 1, '  ' );
      for j = 1 : n
        if ( p(i,j) == 0 )
          fprintf ( 1, '.' );
        elseif ( p(i,j) == -1 )
          fprintf ( 1, 'B' );
        else
          fprintf ( 1, 'W' );
        end
      end
      fprintf ( 1, '\n' );
    end
  end

  return
end
