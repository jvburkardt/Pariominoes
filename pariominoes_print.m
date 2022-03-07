function pariominoes_print ( mp, np, p_num, p, label )

%*****************************************************************************80
%
%% pariominoes_print() prints pariominoes packed in an array.
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
%    integer MP, NP, the rows and columns in the representation.
%
%    integer P_NUM, the number of pariominoes.
%
%    integer P(MP,NP,P_NUM), a matrix representing the pariominoes.  
%
%    string LABEL, a label to be printed first.  
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '%s\n', label );
  fprintf ( 1, '\n' );

  if ( mp <= 0 | np <= 0 | p_num <= 0 )
    fprintf ( 1, '  [ Null matrix ]\n' );
  else
    fprintf ( 1, '  %dx%d array of %d pariominoes:\n', mp, np, p_num );
    for k = 1 : p_num
      q = pariomino_condense ( p(1:mp,1:np,k) );
      label2 = sprintf ( '  pariomino #%d', k );
      pariomino_print ( q, label2 );
    end
  end

  return
end
