function R = fournotchedsquareshapes(n)

%*****************************************************************************80
%
%% fournotchedsquareshapes creates a binary matrix for the 4-notched square shapes.
%
%  Discussion:
%
%  Creates the binary matrices for the '4-notched square' shapes, indexed by n. 
%  See the reference below. The outputted matrix R is the binary matrix we
%  can use in a polyomino or pariomino tiling programs. 
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
%    Marcus Garvie
%
%  Reference:
%
%    Garvie, Marcus R.; Burkardt, John;
%    A new algorithm based on colouring arguments for identifying impossible polyomino
%    tiling problems. Algorithms 15 (2022), no. 2: 65, 1-21.
%    https://doi.org/10.3390/a15020065
%

  L = n+3;  % bounding box L x L
  R = ones(L,L);
  R(1,1) = 0;
  R(1,L) = 0;
  R(L,1) = 0;
  R(L,L) = 0;

  return        

end