function [ p_shapes, d, r_shape, p_num, a, b ] = LPmake_2by4_alt ( )

%*****************************************************************************80
%
%% lpmake_2by4_alt() sets up a 2x4 polyomino tiling problem.
%
%  Discussion:
%
%    The problem is to tile a 2-by-4 rectangle with one T-shaped tetromino, 
%    one monomino, and one L-shaped triomino.  This computation does not
%    use parity arguments (pariomoes), unlike LPMAKE_2BY4_ALT_CASE1
%    and LPMAKE_2BY4_ALT_CASE1.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    24 July 2020
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
%    integer A(EQN_NUM,VAR_NUM), B(EQN_NUM,1): the matrix and right hand 
%    side for the linear system associated with the tiling problem.
%

%
%  Define the target region R.
%
  r_shape = ones ( 2, 4 );
%
%  How many free polyominoes are there?
%
  p_num = 3;
%
%  Create binary matrices for the tiles and pack them into p_shapes
%
  for page = 1 : p_num
    p_shapes(:,:,page) = zeros ( 2, 4 );
  end

  p_shapes(1:2,1:3,1) = [ 0, 1, 0;
                          1, 1, 1];
  p_shapes(1,1,2) = [1];  
  p_shapes(1:2,1:2,3) = [1, 1;
                         1, 0];
%
%  How many free polyominoes are there?
%
  p_num = 3;
%
%  How many copies of each pariomino do we use?
%
  d = [1 1 1];
%
%  Create the linear system
%
  [ a, b, ~ ] = polyomino_multihedral_matrix ( r_shape, p_num, p_shapes, d );
  [ m, n ] = size ( a );
%
%  Write the linear system to an LP file.
%
  filename = '2by4alt.lp';
  label = '\ LP file for the 2by4_alt.';
  pariomino_lp_write ( filename, label, m, n, a, b );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_2by4_alt created the LP file "%s"\n', filename );

  return
end

