function [ m, n, x_num, a, b, x ] = pariomino_tiling_solver ( r_shape, p_num, ...
  p_shapes, d, filename, comment )

%*****************************************************************************80
%
%% pariomino_tiling_solver() analyzes tiling a region with pariominoes.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    04 May 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer R_SHAPE(M_R,N_R), the binary matrix describing the region.
%
%    integer P_NUM, the number of pariomino shapes to be used.
%
%    integer P_SHAPES(M_R,N_R,P_NUM), a binary matrix describing the 
%    pariominoes.  The matrix is "top-left tight", that is, the I-th pariomino 
%    is stored in P_SHAPES(1:M_R,1:N_R,I) with a nonzero in the first row, 
%    and in the first column, but with trailing rows and columns 
%    of zeros allowed.
%
%    integer D(P_NUM), tells us how many copies of each pariomino
%    we must use in the tiling.
%
%    string FILENAME, a name for the LP file that will contain the
%    definition of the problem.
%
%    string COMMENT, a comment that will be the first line of the LP file.
%
%  Output:
%
%    integer M, N, X_NUM, the number of equations, the number of 
%    variables, and the number of binary solutions found.
%
%    integer A(M,N), the matrix of equation coefficients, which should
%    all be 0 or 1.
%
%    integer B(M), the right hand sides, which should all be 1.
%
%    integer X(N,X_NUM), a set of X_NUM solutions to the problem, each
%    consisting of a binary value (0 or 1) for every possible placement
%    of a pariomino onto R.
%
  verbose = false;

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  The internal variable "verbose" is set to "true";\n' );
    fprintf ( 1, '  Print statements marked "VERBOSE" can be suppressed\n' );
    fprintf ( 1, '  by setting "verbose" to "false".\n' );
  end

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, 'pariomino_tiling_solver:\n' );
    fprintf ( 1, '  Analyze the problem of tiling a region R using copies,\n' );
    fprintf ( 1, '  possibly rotated or reflected, of several pariominoes.\n' );
  end
%
%  A: Check the binary matrix describing the region.
%  Make sure it is binary.
%  Make sure it is "tight".
%
  [ m_r, n_r ] = size ( r_shape );

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  Input R_SHAPE has shape (%d,%d).\n', m_r, n_r );
  end

  if ( ~ i4mat_is_ternary ( m_r, n_r, r_shape ) )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'pariomino_tiling_solver - Fatal error!\n' );
    fprintf ( 1, '  The matrix R_SHAPE has entries that are not -1, 0, or +1.\n' );
    error ( 'pariomino_tiling_solver - Fatal error!\n' );
  end

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  Input R_SHAPE is a ternary matrix.\n' );
  end

  r_shape = pariomino_condense ( r_shape );

  [ m_r, n_r ] = size ( r_shape );

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  Condensed R_SHAPE has shape (%d,%d).\n', m_r, n_r );
  end
%
%  B: Check the ternary matrices describing the pariominoes.
%  Make sure they are ternary.
%  Make sure they are top-left "tight".
%
  for k = 1 : p_num

    p = p_shapes(:,:,k);

    [ m_p, n_p ] = size ( p );

    if ( verbose )
      fprintf ( 1, '\n' );
      fprintf ( 1, 'VERBOSE:\n' );
      fprintf ( 1, '  Input P(%d) has shape (%d,%d).\n', k, m_p, n_p );
    end

    if ( ~ i4mat_is_ternary ( m_p, n_p, p ) )
      fprintf ( 1, '\n' );
      fprintf ( 1, 'pariomino_tiling_solver - Fatal error!\n' );
      fprintf ( 1, '  The matrix P(%d) has entries that are not -1, 0 or 1.\n', k );
      error ( 'pariomino_tiling_solver - Fatal error!\n' );
    end

    if ( verbose )
      fprintf ( 1, '\n' );
      fprintf ( 1, 'VERBOSE:\n' );
      fprintf ( 1, '  Input P(%d) is a ternary matrix.\n', k );
    end

    p = pariomino_condense ( p );

    [ m_p, n_p ] = size ( p );

    if ( verbose )
      fprintf ( 1, '\n' );
      fprintf ( 1, 'VERBOSE:\n' );
      fprintf ( 1, '  Condensed P(%d) has shape (%d,%d).\n', k, m_p, n_p );
    end

    p_shapes(1:m_r,1:n_r,k) = 0;
    p_shapes(1:m_p,1:n_p,k) = p(1:m_p,1:n_p);

  end
%
%  C: Make simple checks.
%

%
%  D: Construct the (usually underdetermined) linear system A*x=b.
%
  [ a, b, parent ] = pariomino_matrix ( r_shape, p_num, p_shapes, d );
  [ m, n ] = size ( a );
%
%  Print the linear system.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '  %dx%d system matrix A and right hand side B:\n', m, n );
  fprintf ( 1, '\n' );
  for i = 1 : m
    fprintf ( 1, '  ' );
    for j = 1 : n
      fprintf ( 1, '%2d', a(i,j) );
    end
    fprintf ( 1, '  %2d\n', b(i) );
  end
%
%  E: Write the linear system to an LP file.
%
  pariomino_lp_write ( filename, comment, m, n, a, b );

  fprintf ( 1, '\n' );
%
%  F: Solve the linear system.
%
  ab = [ a, b ];
  [ ab_rref, det ] = r8mat_rref ( m, n + 1, ab );
% a_rref = ab_rref(1:m,1:n);
% b_rref = ab_rref(1:m,n+1);
  a_rref = round ( ab_rref(1:m,1:n) );
  b_rref = round ( ab_rref(1:m,n+1) );

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  RREF has determinant = %g\n', det );
    fprintf ( 1, '\n' );
    fprintf ( 1, '  %dx%d Row-Reduced Echelon Form system matrix A and right hand side B:\n', m + 1, n );
    fprintf ( 1, '\n' );
    for i = 1 : m
      fprintf ( 1, '  ' );
      for j = 1 : n
        fprintf ( 1, '%2d', a_rref(i,j) );
      end
      fprintf ( 1, '  %2d\n', b_rref(i) );
    end
  end
%
%  Augment the RREF system, and look for binary solutions.
%
  nz = sum ( d );
  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  Seek binary solutions with exactly %d nonzeros\n', nz );
  end

  [ x_num, x ] = r8mat_rref_solve_binary_nz ( m, n, nz, a_rref, b_rref );
%
%  G: Print solution vectors.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '  %d binary solutions were found.\n', x_num );

  if ( x_num == 0 )
    return
  end

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Binary solution vectors x:\n' );
  fprintf ( 1, '\n' );
  for i = 1 : n
    fprintf ( 1, '  ' );
    for j = 1 : x_num
      fprintf ( 1, '%2d', x(i,j) );
    end
    fprintf ( 1, '\n' );
  end
%
%  H: Verify that solutions are correct.
%
  check = zeros ( x_num, 1 );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Check Loo residuals |Ax-b|:\n' );
  fprintf ( 1, '\n' );
  ax = a * x;
  resid_max = 0.0;
  for j = 1 : x_num
    resid = max ( abs ( ax(:,j) - b(:) ) );
    check(j) = ( resid == 0 );
    resid_max = max ( resid_max, resid );
    if ( ~ check(j) )
      fprintf ( 1, '  Solution %d has a nonzero Loo residual of %g\n', j, resid );
    end
  end

  if ( resid_max == 0.0 )
    fprintf ( 1, '  All solutions had zero residual.\n' );
  end
%
%  H2: Verify that solutions are correct.
%
  check = zeros ( x_num, 1 );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Check Loo residuals |Ax-b|:\n' );
  fprintf ( 1, '\n' );
  ax = a_rref * x;
  resid_max = 0.0;
  for j = 1 : x_num
    resid = max ( abs ( ax(:,j) - b_rref(:) ) );
    check(j) = ( resid == 0 );
    resid_max = max ( resid_max, resid );
    if ( ~ check(j) )
      fprintf ( 1, ...
        '  Solution vector %d has a nonzero Loo residual of %g\n', j, resid );
    end
  end

  if ( resid_max == 0.0 )
    fprintf ( 1, '  All solutions had zero residual.\n' );
  end

  if ( sum ( check ) == 0 )
    return
  end
%
%  I: Print solutions as patterns.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '  Translate each correct solution into a tiling:\n' );

  for j = 1 : x_num
    if ( check(j) )
      label = sprintf ( '  Tiling based on solution %d', j );
      pariomino_tiling_print ( r_shape, p_num, p_shapes, d, ...
        x(:,j), label );
    end
  end

  return
end
