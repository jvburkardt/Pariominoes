function plot_checker_tile ( pari )

%*****************************************************************************80
%
%% plot_checker_tile() plots a pariomino tile in gray and black.
%
%  Discussion:
%
%    Given a matrix PARI corresponding to the checkerboard colouring
%    of a polyomino or region, with entries 0, +1, or -1, we plot the 
%    pariomino with cells equal to 0 white, cells equal to +1 black, and
%    cells equal to -1 gray. See COLOUR_POLY.
% 
%  Example:
%
%    pari =   [0     0     0     0     0    -1     1    -1     0     0     0     0     0; ...
%              0     0     0     0     0     1    -1     1     0     0     0     0     0; ...
%              0     0     0     0     1    -1     1    -1     1     0     0     0     0; ...
%              0     0     0     1    -1     1     0     1    -1     1     0     0     0; ...
%              0     0     1    -1     1    -1     0    -1     1    -1     1     0     0; ...
%             -1     1    -1     1    -1     0     0     0    -1     1    -1     1    -1; ...
%              1    -1     1    -1     1     0     0     0     1    -1     1    -1     1; ...
%             -1     1    -1     1    -1     0     0     0    -1     1    -1     1    -1; ...
%              0     0     1    -1     1    -1     0    -1     1    -1     1     0     0; ...
%              0     0     0     1    -1     1     0     1    -1     1     0     0     0; ...
%              0     0     0     0     1    -1     1    -1     1     0     0     0     0; ...
%              0     0     0     0     0     1    -1     1     0     0     0     0     0; ...
%              0     0     0     0     0    -1     1    -1     0     0     0     0     0];
%
%  Author:
%
%    Marcus Garvie
%
%  Date: 
%
%    05 August 2020
%
%  Input:
%
%    integer PARI(M,N): a matrix of -1, 0, +1 values which describes a rectangular
%    region, some of whose squares are covered by positive or negative cells of a
%    polyomino.
%
  figure;
  hAxes = gca;
  imagesc ( hAxes, pari );
  colormap ( hAxes , [ 0.7, 0.7, 0.7; 1, 1, 1; 0, 0, 0 ] );
  axis ( 'equal' );
  axis ( 'tight' );
  axis ( 'off' );

  return
end
