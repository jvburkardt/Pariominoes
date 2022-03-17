function R = diamondshapes(n)

%*****************************************************************************80
%
%% diamondshapes creates a binary matrix for diamond-shaped polyomino regions.
%
%  Discussion:
%
%  Creates the binary matrices for the 'diamond-shapes', indexed by n. 
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

L = 2*n+1;  % dimension of bounding box
R = zeros(L,L);

% Add top half
for i = 1:n
    for j = n-i+2:n+i
        R(i,j) = 1;
    end
end

% Add bottom half
Rflip = flipud(R);
R = R + Rflip;

% Add middle strip
R(n+1,1:2*n+1) = 1;

return        

end

