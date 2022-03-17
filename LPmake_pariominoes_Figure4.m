function [p_shapes, r_shape, p_num, d, m, n, f] = LPmake_pariominoes_Figure4 ()

%*****************************************************************************80
%
%% LPmake_pariominoes_Figure4 () creates the LP file for Figure 4 in the reference below.
%
%  Discussion:
%
%    144 copies of an L-shaped tetromino are used to tile an irregularly shaped region.
%
%    This problem is depicted in figure 4 in the reference given below.
%    Note that we tile with pariominoes, i.e. checkerboard colouring 
%    techniques are applied (cf.  LPmake_polyominoes_Figure4). 
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
%    integer P_SHAPES(38,29,2): an array of 0's and +/- 1's that describes the pariominoes.
%
%    integer R_SHAPE(38,29): a matrix of 0's and +/- 1's that describes the checkerboard coloured region.
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
  R = ones(19,14);
  R(1,1:8) = 0;
  R(1,10:14) = 0;
  R(2,1:7) = 0;
  R(2,10:14) = 0;
  R(3,1:6) = 0;
  R(3,11:14) = 0;
  R(4,1:5) = 0;
  R(4,12:14) = 0;
  R(5,1:4) = 0;
  R(5,12:14) = 0;
  R(6,1:3) = 0;
  R(6,13:14) = 0;
  R(7,1:2) = 0;
  R(7,13:14) = 0;
  R(8,1) = 0;
  R(8,14) = 0;
  R(12,1) = 0;
  R(12,14) = 0;
  R(13,1:2) = 0;
  R(13,13:14) = 0;
  R(14,1:2) = 0;
  R(14,12:14) = 0;
  R(15,1:3) = 0;
  R(15,11:14) = 0;
  R(16,1:3) = 0;
  R(16,10:14) = 0;
  R(17,1:4) = 0;
  R(17,9:14) = 0;
  R(18,1:5) = 0;
  R(18,8:14) = 0;
  R(19,1:5) = 0;
  R(19,7:14) = 0;
  % Double region
  R1 = zeros(28,23);
  R2 = zeros(28,23);
  R1(10:28,1:14) = R;
  R2(1:19,10:23) = R;
  RR = R1+R2;
  % Double region again
  R3 = zeros(38,29);
  R4 = zeros(38,29);
  R3(1:28,1:23) = RR;
  R4(11:38,7:29) = RR;
  RRR = R3+R4;
  r_shape = RRR;
  r_shape = colour_poly(r_shape, +1);
%
%  How many free pariominoes are there?
%
  p_num = 2;  
%
%  Create matrices of 0's and +/- 1's for the pariominoes and pack them into p_shapes
%  
  for page = 1:p_num
      p_shapes(:,:,page) = zeros(38,29);
  end
  
  poly1 = [1 0; 1 0; 1 1];
  poly1 = colour_poly(poly1, +1);
  p_shapes(1:3,1:2,1) = poly1;
  
  poly2 = [1 0; 1 0; 1 1];
  poly2 = colour_poly(poly2, -1);
  p_shapes(1:3,1:2,2) = poly2;

%
%  How many copies of each pariomino do we use?
%
  d = [72 72];
%
%  Create the linear system A*x=b for the tiling problem and output some data.
%
  [ a, b, ~ ] = pariomino_matrix ( r_shape, p_num, p_shapes, d );
  [m,n] = size(a); 
  f = n - rank([a,b]);
%
%  Write the linear system to an LP file.
%
  filename ='Figure4_pariominoes.lp';
  label = '\ LP file for Figure4 in the pariomino paper (colouring techniques used).';
  pariomino_lp_write ( filename, label, m, n, a, b );
  
  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_pariominoes_Figure4 created the LP file "%s"\n', filename );

  return 

end