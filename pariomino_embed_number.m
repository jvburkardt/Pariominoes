function number = pariomino_embed_number ( r, p )

%*****************************************************************************80
%
%% pariomino_embed_number() counts pariomino embeddings in a region.
%
%  Discusion:
%
%    A region R is a subset of an MRxNR grid of squares.
%
%    A polyomino P is a subset of an MPxNP grid of squares.
%
%    Both objects are represented by parity (-1/+1) matrices, with the property that
%    there are no initial or final zero rows or columns.
%
%    For this computation, we regard P as a "fixed" pariomino; in other words,
%    no reflections or rotations will be allowed.
%
%    An "embedding" of P into R is an offset (MI,NJ) such that 
%      P(I,J) = R(I+MI,J+NJ) 
%      for 1 <= I <= MP, 1 <= J <= NP, and 
%      for 0 <= MI <= MR-MP, 0 <= MJ <= NR-NP.
%    We can detect an embedding simply by taking what amounts to a kind of
%    dot product of P with a corresponding subregion of R.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    30 April 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer R(MR,NR), a matrix of -1's, 0's, and 1's representing the region.
%
%    integer P(MP,NP), a matrix of -1's, 0's and 1's representing the pariomino.
%
%  Output:
%
%    integer NUMBER, the number of distinct embeddings of P into R.
%
  number = 0;

  [ mr, nr ] = size ( r );
  [ mp, np ] = size ( p );
%
%  Count the -1's and +1's in P.
%
  pr = pariomino_area ( p );
%
%  For each possible (I,J) coordinate of the upper left corner of a subset of R,
%  see if it matches P.
%
  for mi = 0 : mr - mp
    for nj = 0 : nr - np
      srp = sum ( sum ( p(1:mp,1:np) .* r(1+mi:mp+mi,1+nj:np+nj) ) );
      if ( srp == pr )
        number = number + 1;
      end      
    end
  end

  return
end
