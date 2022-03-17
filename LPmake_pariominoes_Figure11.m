function [p_shapes, r_shape, p_num, d, m, n, f] = LPmake_pariominoes_Figure11 ()

%*****************************************************************************80
%
%% LPmake_pariominoes_Figure11 () creates the LP file for Figure 11 in the reference below.
%
%  Discussion:
%
%    Copies (see below) of 10 different octominoes are used to tile an 8x16
%    rectangle.
%
%    This problem is depicted in figure 11 in the reference given below.
%    Note that we tile with pariominoes, i.e. checkerboard colouring 
%    techniques are applied (cf. LPmake_polyominoes_Figure11). 
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
%    integer P_SHAPES(8,16,11): an array of 0's and +/- 1's that describes
%    the pariominoes.
%
%    integer R_SHAPE(8,16): a matrix of 0's and +/- 1's that describes the checkerboard coloured region.
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
  r_shape = ones(8,16);
  r_shape = colour_poly(r_shape, +1);
%
%  How many free pariominoes are there?
%
  p_num = 11;  
%
%  Create matrices of 0's and +/- 1's for the pariominoes and pack them
%  into p_shapes.
%
  for page = 1:p_num
      p_shapes(:,:,page) = zeros(8,16);
  end
  
  oct1 = [1 1 1 1; 1 0 0 1; 1 0 0 1];
  oct1 = colour_poly(oct1, +1);
  p_shapes(1:3,1:4,1) = oct1;
  
  %%%%%%%%%%%%
  
  oct2 = [0 1 1 1 1; 1 1 1 1 0];
  oct2 = colour_poly(oct2, +1);
  p_shapes(1:2,1:5,2) = oct2;
  
  %%%%%%%%%%%%
  
  oct3 = [1 1; 1 0; 1 1; 0 1; 1 1]; 
  oct3 = colour_poly(oct3, +1);
  p_shapes(1:5,1:2,3) = oct3;
  
  %%%%%%%%%%%%
  
  oct4 = [1 1 1 1; 1 1 1 1]; 
  oct4 = colour_poly(oct4, +1);
  p_shapes(1:2,1:4,4) = oct4;
  
  %%%%%%%%%%%%
  
  oct5 = [1 1 1 1 1 1 1 1]';  
  oct5 = colour_poly(oct5, +1);
  p_shapes(1:8,1,5) = oct5;
 
 %%%%%%%%%%%%
  
  oct6 = [1 1 0; 0 1 1; 0 1 1; 1 1 0];   
  oct6 = colour_poly(oct6, +1);
  p_shapes(1:4,1:3,6) = oct6;
 
 %%%%%%%%%%%%
  
  oct7 = [1 1 1 1; 0 1 1 0; 0 1 1 0];  
  oct7 = colour_poly(oct7, +1);
  p_shapes(1:3,1:4,7) = oct7;
  
 %%%%%%%%%%%%
  
  oct8b = [0 1 1; 0 0 1; 1 1 1; 1 0 1];   
  oct8b = colour_poly(oct8b, -1);
  p_shapes(1:4,1:3,8) = oct8b;
  
  %%%%%%%%%%%%
  
  oct9a = [1 1 1 1; 1 0 0 0; 1 1 0 0; 1 0 0 0];   
  oct9a = colour_poly(oct9a, +1);
  p_shapes(1:4,1:4,9) = oct9a;
  
  oct9b = [1 1 1 1; 1 0 0 0; 1 1 0 0; 1 0 0 0];   
  oct9b = colour_poly(oct9b, -1);
  p_shapes(1:4,1:4,10) = oct9b;
  
  %%%%%%%%%%%%
  
  oct10a = [0 1 0 1; 1 1 1 1; 0 1 0 1];  
  oct10a = colour_poly(oct10a, +1);
  p_shapes(1:3,1:4,11) = oct10a;

%
%  How many copies of each pariomino do we use?
%
  d = [1 2 1 2 2 1 2 2 1 1 1];
%
%  Create the linear system A*x=b for the tiling problem and output some data.
%
  [ a, b, ~ ] = pariomino_matrix ( r_shape, p_num, p_shapes, d );
  [m,n] = size(a); 
  f = n - rank([a,b]);
%
%  Write the linear system to an LP file.
%
  filename ='Figure11_pariominoes.lp';
  label = '\ LP file for Figure11 in the pariomino paper (colouring techniques used).';
  pariomino_lp_write ( filename, label, m, n, a, b );
  
  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_pariominoes_Figure11 created the LP file "%s"\n', filename );

  return 

end