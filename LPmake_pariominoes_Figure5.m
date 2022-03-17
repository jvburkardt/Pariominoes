function [p_shapes, r_shape, p_num, d, m, n, f] = LPmake_pariominoes_Figure5 ()

%*****************************************************************************80
%
%% LPmake_pariominoes_Figure5 () creates the LP file for Figure 5 in the reference below.
%
%  Discussion:
%
%    56 copies of an L-shaped trimino are used to tile a triangular shaped region with ‘holes’.
%
%    This problem is depicted in figure 5 in the reference given below.
%    Note that we tile with pariominoes, i.e. checkerboard colouring 
%    techniques are applied (cf.  LPmake_polyominoes_Figure5). 
%    
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    15 March 2022
%
%  Author:
%
%    Marcus Garvie, John Burkardt
%
%  Reference:
%
%    Marcus Garvie, John Burkardt,
%    A `divide-and-conquer' approach for tiling finite regions of the plane with polyominoes. 
%    Part II: Numerical solution.
%    Algorithms,
%    Submitted, 2022.
%
%  Output:
%
%    integer P_SHAPES(21,21): a matrix of 0's and +/- 1's that describes the pariomino.
%
%    integer R_SHAPE(21,21): a matrix of 0's and +/- 1's that describes the checkerboard coloured region.
%
%    integer P_NUM, how many free pariominoes are used.
%
%    integer D(P_NUM), tells us how many copies of each pariomino
%    we must use in the tiling.
%
%    integer M: the number of constraints of the LP problem.
%
%    integer N: the number of variables in the LP problem.
%
%    integer F: the number of free variables associated with the linear
%    system Ax = b of the LP problem
%
%   Note: the LP file is saved to file.

%
%  Define the checkerboard coloured target region R
%
  r = diamondshapes(10);
  cross = zeros(3);
  cross(1,1) = 1;
  cross(1,3) = 1;
  cross(3,1) = 1;
  cross(3,3) = 1;
  r(4:6,10:12) = cross;
  r(7:9,7:9) = cross;
  r(7:9,13:15) = cross;
  r(10:12,4:6) = cross;
  r(10:12,10:12) = cross;
  r(10:12,16:18) = cross;
  r(13:15,7:9) = cross;
  r(13:15,13:15) = cross;
  r(16:18,10:12) = cross;
  r(7,10) = 0;
  r(7,12) = 0;
  r(10,7) = 0;
  r(10,15) = 0;
  r(12,7) = 0;
  r(12,15) = 0;
  r(15,10) = 0;
  r(15,12) = 0;
  r_shape = r;
  r_shape = colour_poly(r_shape, +1);
%
%  How many free pariominoes are there?
%
  p_num = 1;  
%
%  Create matrix of 0's and +/- 1's for the pariomino and pack it into p_shapes
%  
  p_shapes = zeros ( 21, 21);
  poly1 = [1 0; 1 1];
  poly1 = colour_poly(poly1, +1);
  p_shapes(1:2,1:2) = poly1;

%
%  How many copies of each pariomino do we use?
%
  d = [56];
%
%  Create the linear system A*x=b for the tiling problem and output some data.
%
  [ a, b, ~ ] = pariomino_matrix ( r_shape, p_num, p_shapes, d );
  [m,n] = size(a); 
  f = n - rank([a,b]);
%
%  Write the linear system to an LP file.
%
  filename ='Figure5_pariominoes.lp';
  label = '\ LP file for Figure5 in the pariomino paper (colouring techniques used).';
  pariomino_lp_write ( filename, label, m, n, a, b );
  
  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_pariominoes_Figure5 created the LP file "%s"\n', filename );

  return 

end