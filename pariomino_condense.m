function q = pariomino_condense ( p )

%*****************************************************************************80
%
%% pariomino_condense() condenses a pariomino.
%
%  Discussion:
%
%    A pariomino is a shape formed by connecting unit squares edgewise.
%
%    A pariomino can be represented by an MxN matrix, whose entries are
%    -1 or +1 for squares that are part of the pariomino, and 0 otherwise.
%
%    This program is given an MxN matrix that is meant to represent a 
%    pariomino.  It  "condenses" the matrix, if possible, by removing initial 
%    and final rows and columns that are entirely zero.
%
%    While this procedure might save a slight amount of space, its purpose
%    is to simplify the task of manipulating pariominos, embedding them in
%    larger shapes, and detecting whether two pariominos describe the same
%    shape.
%
%    It is entirely possible, and usual, that the output quantities are
%    simply copies of the input quantities.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    09 May 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer P(MP,NP), the representation of the pariomino.  
%
%  Output:
%
%    integer Q(MQ,NQ), the representation of the condensed pariomino.
%
  [ mp, np ] = size ( p );
%
%  Discard nonsense.
%
  if ( mp <= 0 | np <= 0 )
    mq = 0;
    nq = 0;
    q = [];
    return
  end
%
%  Copy the input.
%
  mq = mp;
  nq = np;
  q = p;
%
%  Strip initial rows of zeros.
%
  while ( sum ( abs ( q(1,:) ) ) == 0 ) 
    q = q(2:mq,:);
    mq = mq - 1;
    if ( mq <= 0 )
      mq = 0;
      nq = 0;
      q = [];
      return
    end
  end
%
%  Strip final rows of zeros.
%
  while ( sum ( abs ( q(mq,:) ) ) == 0 )
    q = q(1:mq-1,:);
    mq = mq - 1;
    if ( mq <= 0 )
      mq = 0;
      nq = 0;
      q = [];
      return
    end
  end
%
%  Strip initial columns of zeros.
%
  while ( sum ( abs ( q(:,1) ) ) == 0 )
    q = q(:,2:nq);
    nq = nq - 1;
    if ( nq <= 0 )
      mq = 0;
      nq = 0;
      q = [];
      return
    end
  end
%
%  Strip final columns of zeros.
%
  while ( sum ( abs ( q(:,nq) ) ) == 0 )
    q = q(:,1:nq-1);
    nq = nq - 1;
    if ( nq <= 0 )
      mq = 0;
      nq = 0;
      q = [];
      return
    end
  end

  return
end
