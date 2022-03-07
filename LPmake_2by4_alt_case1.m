function [ p_shapes, d, r_shape, p_num ] = LPmake_2by4_alt_case1 ( )

%*****************************************************************************80
%
%% lpmake_2by4_alt_case1() sets up case 1 of a 2x4 pariomino tiling problem.
%
%  Discussion:
%
%    The problem is to tile a 2-by-4 rectangle with one T-shaped tetromino, 
%    one monomino, and one L-shaped triomino, using parity arguments,
%    Compare with LPMAKE_2BY4_ALT which does not use parity arguments.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    23 July 2020
%
%  Author:
%
%    Marcus Garvie, John Burkardt
%
%  Reference:
%
%    Marcus Garvie, John Burkardt,
%    ???
%
%  Output:
%
%    integer P_SHAPES(2,4,3): a binary matrix that describes each polyomino.
%
%    integer D(1,3): how many times each polyomino is to be used.
%
%    integer R_SHAPE(2,4): a binary matrix that describes the region.
%
%    integer P_NUM: the number of polyominoes.
%

%
%  Define the target region R.
%
  r_shape = [ ...
    +1, -1, +1, -1; ...
    -1, +1, -1, +1 ];
%
%  How many free polyominoes are there?
%
  p_num = 3;
%
% Create binary matrices for the tiles and pack them into p_shapes.
%
  for page = 1 : p_num
    p_shapes(:,:,page) = zeros ( 2, 4 );
  end
  
  p_shapes(1:2,1:3,1) = [ 0, -1,  0;
                         -1, +1, -1];
  p_shapes(1,1,2) = [+1];  
  p_shapes(1:2,1:2,3) = [-1, +1;
                         +1,  0];
%
%  How many copies of each pariomino do we use?
%
  d = [1 1 1]; 
%
%  Set up the linear system A*x=b for the tiling problem.
%
  [ a, b, ~ ] = pariomino_matrix ( r_shape, p_num, p_shapes, d );
  [ m, n ] = size ( a );
%
%  Write the linear system to an LP file.
%
  filename = '2by4_alt_case1.lp';
  label = '\ LP file for the 2by4_alt_case1.';
  pariomino_lp_write ( filename, label, m, n, a, b );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_2by4_alt_case1 created the LP file "%s"\n', filename );

  return
end
