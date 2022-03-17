function pari = colour_poly(poly, sgn)

%*****************************************************************************80
%
%% colour_poly creates a matrix of 0's and +/- 1's that describes the region/pariomino.
%
%  Discussion:
%
%   Create a matrix for a pariomino using just 0, +1, and -1.
%   Given the binary matrix for a polyomino or region POLY, output a matrix
%   PARI corresponding to the checkerboard colouring of this polyomino or region
%   i.e., a pariomino. Cells that do not belong to the polyomino or region
%   remain zero, black cells are assigned +1 and gray cells are assigned
%   -1. The sum of the numbers assigned to cells yields the parity (+/- p, or
%   zero) of the pariomino. When p is nonzero if SGN is chosen +/-1 then the 
%   parity is +/- p respectively. We also plot the checkerboard coloured region. 
%   (For some reason a single black monomino represented by [1] is plotted white.)
%   Depending on how we position a pariomino we don't know ahead of time
%  whether  the parity is +1 or -1. So we create both, test to see which
%  one we have, and then output the correct choice based on the choice for
%  SGN. The case of a polyomino with zero parity must be given a separate
%  treatment.
%
%
%   Example:
%
%    poly = [0     0     0     0     0     1     1     1     0     0     0     0     0 ; ...
%                 0     0     0     0     0     1     1     1     0     0     0     0     0; ...
%                 0     0     0     0     1     1     1     1     1     0     0     0     0; ...
%                 0     0     0     1     1     1     0     1     1     1     0     0     0; ...
%                 0     0     1     1     1     1     0     1     1     1     1     0     0; ...
%                 1     1     1     1     1     0     0     0     1     1     1     1     1; ...
%                 1     1     1     1     1     0     0     0     1     1     1     1     1; ...
%                 1     1     1     1     1     0     0     0     1     1     1     1     1; ...
%                 0     0     1     1     1     1     0     1     1     1     1     0     0; ...
%                 0     0     0     1     1     1     0     1     1     1     0     0     0; ...
%                 0     0     0     0     1     1     1     1     1     0     0     0     0; ...
%                 0     0     0     0     0     1     1     1     0     0     0     0     0; ...
%                 0     0     0     0     0     1     1     1     0     0     0     0     0];
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
%  Construct matrix of 0's and +/- 1's
%
  [rows,cols] = size(poly);
  pari1 = zeros(rows,cols);
  pari2 = zeros(rows,cols);
   for j = 1:cols
       for i = 1:rows
           if poly(i,j) == 1
                   pari1(i,j) = mod(i+j,2);
                   pari2(i,j) = mod(i+j+1,2);
               if pari1(i,j) == 0
                   pari1(i,j) = -1;
               end
               if pari2(i,j) == 0
                  pari2(i,j) = -1;
               end             
           end
       end
   end
 
   sum1 = sum(sum(pari1));
 
   sgnp = sign(sum1); 
 
  if (sgnp == sgn) || ((sgnp == 0) && (sgn == +1))
      pari = pari1;
  else 
     pari = pari2;
  end
 
%
%  Plot checkrboard coloured region
% 
  figure; hAxes = gca;
  imagesc( hAxes, pari );
  colormap( hAxes , [0.7 0.7 0.7; 1 1 1; 0 0 0] )
  set(gcf,'color','w');
  axis equal tight off

  return 

end