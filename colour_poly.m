function pari = colour_poly ( poly, sgn )

%*****************************************************************************80
%
%% colour_poly() creates a matrix for a pariomino using 0, +1, and -1.
%
%  Discussion:
%
%    Given the binary matrix for a polyomino or region POLY, output a matrix
%    PARI corresponding to the checkerboard colouring of this polyomino or region
%    i.e., a pariomino. Cells that do not belong to the polyomino or region
%    remain zero, black cells are assigned +1 and gray cells are assigned
%    -1. The sum of the numbers assigned to cells yields the parity (+/- p, or
%    zero) of the pariomino. When p is nonzero if SGN is chosen +/-1 then the 
%    parity is +/- p respectively.
%
%    Depending on how we position a pariomino we don't know ahead of time
%    whether  the parity is +1 or -1. So we create both, test to see which
%    one we have, and then output the correct choice based on the choice for
%    SGN. The case of a polyomino with zero parity must be given a separate
%    treatment.
%
%  Example:
%
%    sgn = +1
%    poly = [0     0     0     0     0     1     1     1     0     0     0     0     0 ; ...
%            0     0     0     0     0     1     1     1     0     0     0     0     0; ...
%            0     0     0     0     1     1     1     1     1     0     0     0     0; ...
%            0     0     0     1     1     1     0     1     1     1     0     0     0; ...
%            0     0     1     1     1     1     0     1     1     1     1     0     0; ...
%            1     1     1     1     1     0     0     0     1     1     1     1     1; ...
%            1     1     1     1     1     0     0     0     1     1     1     1     1; ...
%            1     1     1     1     1     0     0     0     1     1     1     1     1; ...
%            0     0     1     1     1     1     0     1     1     1     1     0     0; ...
%            0     0     0     1     1     1     0     1     1     1     0     0     0; ...
%            0     0     0     0     1     1     1     1     1     0     0     0     0; ...
%            0     0     0     0     0     1     1     1     0     0     0     0     0; ...
%            0     0     0     0     0     1     1     1     0     0     0     0     0];
%
%  Author:
%
%    Marcus Garvie
%
%  Modified:
%
%    08 September 2020
%
%  Input:
%
%    integer POLY(M,N): a matrix of 0 and 1 values, describing a region whose
%    cells are unoccupied (0) or occupied (1) by the squares of a polyomino.
%
%    integer SGN: the value -1 or +1, determines which of two parity options
%    to apply to the matrix.
%
%  Output:
%
%    integer PARI(M,N): a matrix of -1, 0, and +1 values.  Some of the +1 values
%    of POLY have been changed to -1 values, to enforce a checkerboard parity.
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
 
  if (sgnp == sgn) | ((sgnp == 0) & (sgn == +1))
    pari = pari1;
  else 
    pari = pari2;
  end

  return
end
