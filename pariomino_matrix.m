function [ a, b, var_p ] = pariomino_matrix ( r, p_num, p, d )

%*****************************************************************************80
%
%% pariomino_matrix(): linear system pariomino tiling.
%
%  Discussion:
%
%    A region R is represented by an MRxNR binary matrix.
%
%    It is to be tiled by copies of pariominoes which are stored in a
%    MRxNRxP_NUM array P.  Each pariomino can be reflected, rotated,
%    and translated.
%
%    This function computes the linear system A*x=b that can be used to 
%    search for solutions to this tiling problem.
%
%    In the usual formulation, the linear system is augmented by one
%    equation for each pariomino type, specifying the number of pariominos
%    of that type that are to be used.  It turns out that this results
%    in one extraneous equation.  When there is, in fact, only one type
%    to be used, then this equation will now be suppressed, for consistency 
%    with the treatment of the monohedral polyomino case.  (17 November 2020)
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    17 November 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer R(MR,NR), a binary matrix describing the region.
%
%    integer P(MR,NR,P_NUM), a binary matrix describing the pariominoes.
%    The matrix is "top-left tight", that is, the I-th pariomino is stored
%    in P(1:MR,1:NR,I) with a nonzero in the first row, a nonzero in the 
%    first column, but with trailing rows and columns of zeros allowed.
%
%    integer D(P_NUM), tells us how many copies of each pariomino
%    we must use in the tiling.
%
%  Output:
%
%    integer A(EQN_NUM,VAR_NUM), the system matrix.
%
%    integer B(EQN_NUM,1), the right hand side.
%
%    integer VAR_P(VAR_NUM,1).  If variable I is a variant of pariomino
%    J, then VAR_P(I) = J.
%

%
%  E will index the nonzero cells in R, and represents equations.
%  Each equation essentially says "Some pariomino covers this cell".
%
  e = pariomino_index ( r );
%
%  Get the size or R.
%
  [ mr, nr ] = size ( r );
%
%  From the original set of pariominoes P, compute all the
%  variants obtainable by reflection and rotation.
%
  [ v_num, v, v_p ] = pariomino_variants ( mr, nr, p_num, p, d );
%
%  Determine the number of equations:
%  * pariomino_area ( R ) accounts for "this cell is covered" equations.
%  * P_NUM reflects the equations that tell us how many of each pariomino
%    we are to use.
%
  if ( 1 < p_num )
    eqn_num = pariomino_area ( r ) + p_num;
  else
    eqn_num = pariomino_area ( r );
  end
%
%  Determine the number of variables.
%  For variable I, set var_p(i) to the index in P of the "parent" pariomino.
%
  var_num = 0;
  var_p = zeros ( var_num, 1 );

  for k = 1 : v_num

    q = v(1:mr,1:nr,k);

    s = pariomino_condense ( q );

    number = pariomino_embed_number ( r, s );

    for l = 1 : number
      var_num = var_num + 1;
      var_p(var_num,1) = v_p(k);
    end

  end
%
%  Set aside space for the linear system.
%
  a = zeros ( eqn_num, var_num );
  b = ones ( eqn_num, 1 );
%
%  Start variable count at 0.
%
  var = 0;
%
%  For each V, determine the embeddings.
%  This sets column VAR.
%
  for k = 1 : v_num

    q = v(1:mr,1:nr,k);

    s = pariomino_condense ( q );

    [ ms, ns ] = size ( s );

    number = pariomino_embed_number ( r, s );

    list = pariomino_embed_list ( r, s, number );

    for l = 1 : number
      var = var + 1;
      ioff = list(l,1);
      joff = list(l,2);
      s2 = zeros ( mr, nr );
      s2(1+ioff:ms+ioff,1+joff:ns+joff) = s(1:ms,1:ns);
      e_dot_s2 = e .* abs ( s2 );
      eqn = e_dot_s2( e_dot_s2 ~= 0 );
      a(eqn,var) = 1;
    end

  end
%
%  The next equations specify how many P's of a given type may be used.
%
  if ( 1 < p_num )

    eqn = pariomino_area ( r );

    var = 0;
    for k = 1 : p_num
      pk_vars = sum ( var_p == k );
      eqn = eqn + 1;
      a(eqn,var+1:var+pk_vars) = 1;
      b(eqn) = d(k);
      var = var + pk_vars;
    end
 
  end

  return
end

