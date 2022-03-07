function [ a, b ] = pariomino_matrix_reid ( )

%*****************************************************************************80
%
%% pariomino_matrix_reid() sets the matrix for the Reid problem.
%
%  Discussion:
%
%    This function sets up the linear system A*x=b associated with
%    the Reid pariomino tiling problem.
%
%    While it is desirable to have a general procedure that can automatically
%    deduce the linear system from the problem specification, for simplicity
%    in this example, we simply provide the linear system directly.
%
%    I have modified this file so that the numbering of equations and
%    variables agrees with the paper.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    12 November 2020
%
%  Author:
%
%    John Burkardt
%
%  Output:
%
%    real A(8,10), the system matrix.
%
%    real B(8), the right hand side.
%

%
%  Each of 8 cells must be covered by one of 10 tile positions.
%
  a = [ ...
    1,0,0,0,0,1,0,0,0,0; ...
    0,0,1,0,0,1,0,0,0,0; ...
    1,1,0,0,0,0,1,0,0,0; ...
    0,0,1,1,0,0,1,1,0,0; ...
    0,0,0,0,1,0,0,1,0,0; ...
    0,1,0,0,0,0,0,0,1,0; ...
    0,0,0,1,0,0,0,0,1,1; ...
    0,0,0,0,1,0,0,0,0,1 ];

  b = [ 1;1;1;1;1;1;1;1];

  return
end

