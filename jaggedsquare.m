function R  = jaggedsquare (n)

%*****************************************************************************80
%
%% jaggedsquare creates a binary matrix for jagged-square shaped polyomino regions.
%
%  Discussion:
%
%  Creates the binary matrices for the 'jagged-square' shapes, indexed by n. 
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

% Create everything except the outer 'spokes'
L = 3 + 2*n;  % dimension of bounding box
R = zeros(L,L);
R(2:L-1,2:L-1) = 1;

% Add spokes
for count = 1:n+1
    R(2*count,1) = 1;
    R(2*count,L) = 1;
    R(1,2*count) = 1;
    R(L,2*count) = 1;
end

% Remove square in center
cen = (L+1)/2;
R(cen,cen) = 0;

return        

end