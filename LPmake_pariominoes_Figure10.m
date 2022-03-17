function [p_shapes, r_shape, p_num, d, m, n, f] = LPmake_pariominoes_Figure10 ()

%*****************************************************************************80
%
%% LPmake_pariominoes_Figure10 () creates the LP file for Figure 10 in the reference below.
%
%  Discussion:
%
%    26 copies of the domino, 3 copies of the P-shaped pentomino, 1 copy of the 
%    cross-shaped pentomino, and 1 copy of the octomino are used to tile 
%    an irregular shaped region with holes.
%
%    This problem is depicted in figure 10 in the reference given below.
%    Note that we tile with pariominoes, i.e. checkerboard colouring 
%    techniques are applied (cf. LPmake_polyominoes_Figure10). 
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
%    integer P_SHAPES(13,13,4): an array of 0's and +/- 1's that describes
%    the pariominoes.
%
%    integer R_SHAPE(13,13): a matrix of 0's and +/- 1's that describes the checkerboard coloured region.
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
  r_shape = zeros(13,13);
  r_shape(1:2,6:8) = 1;
  r_shape(3:4,5:9) = 1;
  r_shape(4,4) = 1;
  r_shape(4,10) = 1;
  r_shape(5,3:6) = 1;
  r_shape(5,8:11) = 1;
  r_shape(6,1:5) = 1;
  r_shape(6,9:13) = 1;
  r_shape(7,1:4) = 1;
  r_shape(7,10:13) = 1;
  r_shape(8,1:5) = 1;
  r_shape(8,9:13) = 1;
  r_shape(9,3:6) = 1;
  r_shape(9,8:11) = 1;
  r_shape(10,4:10) = 1;
  r_shape(11,5:9) = 1;
  r_shape(12:13,6:8) = 1;
  r_shape(4,7) = 0;
  r_shape(10,7) = 0;
  r_shape(7,5) = 1;
  r_shape(7,9) = 1;  
  r_shape = colour_poly(r_shape, +1);
%
%  How many free pariominoes are there?
%
  p_num = 4;  
%
%  Create matrices of 0's and +/- 1's for the pariominoes and pack them
%  into p_shapes.
%
  for page = 1:p_num
      p_shapes(:,:,page) = zeros(13,13);
  end
  
  poly1 = [1; 1];
  poly1 = colour_poly(poly1, +1);
  p_shapes(1:2,1,1) = poly1;
  
  %%%%%%%%%%%%%%%%%%%%%%
  
  poly2 =  [1 1; 1 1; 1 0];
  poly2 = colour_poly(poly2, -1);
  p_shapes(1:3,1:2,2) = poly2;
  
  %%%%%%%%%%%%%%%%%%%%%%
  
  poly5 =  [0 1 0; 1 1 1; 0 1 0];
  poly5 = colour_poly(poly5, +1);
  p_shapes(1:3,1:3,3) = poly5;
  
  %%%%%%%%%%%%%%%%%%%%%%
  
  poly6 =  [0 1 0 1; 1 1 1 1; 0 1 0 1];
  poly6 = colour_poly(poly6, +1);
  p_shapes(1:3,1:4,4) = poly6;

%
%  How many copies of each pariomino do we use?
%
   d = [26 3 1 1];
%
%  Create the linear system A*x=b for the tiling problem and output some data.
%
  [ a, b, ~ ] = pariomino_matrix ( r_shape, p_num, p_shapes, d );
  [m,n] = size(a); 
  f = n - rank([a,b]);
%
%  Write the linear system to an LP file.
%
  filename ='Figure10_pariominoes.lp';
  label = '\ LP file for Figure10 in the pariomino paper (colouring techniques used).';
  pariomino_lp_write ( filename, label, m, n, a, b );
  
  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_pariominoes_Figure10 created the LP file "%s"\n', filename );

  return 

end