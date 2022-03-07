function x = scip_solution_read ( filename, nx )

%*****************************************************************************80
%
%% scip_solution_read() reads a SCIP solution file.
%
%  Discussion:
%
%    It is assumed that the variables are named x1, x2, ..., xN.
%
%    It is assumed that the solution variables are restricted to values 0 and 1.
%
%    It is assumed that the solution file begins with two ignorable lines,
%    followed by lines of the form:
%      x7  junk
%      x13  junk
%      x83  junk
%    where we can ignore the "junk" and simply assume that x(7)=1, x(13)=1,
%    and x(83)=1.
%
%    The user needs to supply the size of the solution vector in advance.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    10 January 2022
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    string FILENAME, the name of the input file.
%
%    integer NX, the number of variables.
%
%  Output:
%
%    integer X(NX), the solution values.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'scip_solution_read():\n' );
  fprintf ( 1, '  Extract solution information from an SCIP solution file.\n' );

  x = zeros ( nx, 1 );

  input_file = fopen ( filename );
%
%  Read all the lines of the file just to count them.
%
  nlines = 0;
  while ( ~ feof ( input_file ) )
    t = fgetl ( input_file );
%   fprintf ( 1, '%s\n', t );
    nlines = nlines + 1;
  end

  fclose ( input_file );
%
%  Report number of lines.
%
  fprintf ( 1, '  File contains %d lines\n', nlines );
%
%  Deduce number of nonzeros.
%
  nnz = nlines - 2;
  fprintf ( 1, '  Number of nonzero entries in X is %d\n', nnz );
%
%  Reread file.
%
  input_file = fopen ( filename );
%
%  Skip first two lines.
%
  text = fgetl ( input_file );
  text = fgetl ( input_file );
%
%  Assume subsequent lines have the form "xnnn junk"
%  We simply assume this means x(nnn)=1, ignoring "junk".
%
  while ( ~ feof ( input_file ) )
    text = fgetl ( input_file );
    [ word, text_rest ] = s_word_extract_first ( text );
    i = str2num ( word(2:end) );
%   fprintf ( 1, '  x(%d) = 1\n', i );
    x(i) = 1;
  end

  fclose ( input_file );

  return
end
