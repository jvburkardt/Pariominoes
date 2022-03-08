function x = diophantine_nd_nonnegative_bounded ( a, b, m )

%*****************************************************************************80
%
%% diophantine_nd_nonnegative_bounded(): bounded nonnegative diophantine solutions.
%
%  Discussion:
%
%     We are given a Diophantine equation 
%
%       a1 x1 + a2 x2 + ... + an * xn = b
%
%     for which the coefficients a are positive integers, and
%     the right hand side b is a nonnegative integer.
%
%     We are seeking all integer solutions x such that
%       0 <= xi <= mi
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    21 July 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer a(n): the coefficients of the Diophantine equation.
%
%    integer b: the right hand side.
%
%    integer m(n): the upper bounds for each component.
%
%  Output:
%
%    integer x(k,n): k solutions to the equation.
%

%
%  Treat A as a column vector.
%
  a = a(:);
%
%  Initialize.
%
  n = length ( a );
  x = [];
  j = 0;
  r = b;
  y = zeros ( n, 1 );
%
%  Construct a vector Y that is a possible solution.
%
  while ( true )
%
%  Determine the current residual for the tentative partial solution Y(1:J).
%
    r = b;
    for i = 1 : j
      r = r - a(i) * y(i);
    end
%
%  If the vector is still incomplete, get the next component.
%
    if ( j < n )
      j = j + 1;
      y(j) = floor ( r / a(j) );
%
%  Impose the bound.
%
      y(j) = min ( y(j), m(j) );
%
%  If the vector is complete, analyze it.
%
    else
%
%  Is it a solution?
%
      if ( r == 0 )
        x = [ x; y' ];
      end
%
%  Now try to modify the complete vector to determine another candidate.
%  Find last nonzero Y entry, decrease by 1 and resume search.
%
      while ( 0 < j )

        if ( 0 < y(j) )
          y(j) = y(j) - 1;
          break
        end
        j = j - 1;

      end
%
%  Terminate search.
%
      if ( j == 0 )
        break;
      end

    end

  end
%
%  Sort the candidates.
% 
  x = sortrows ( x );

  return
end

