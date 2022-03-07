function x = gurobi_solution_read ( filename )

%*****************************************************************************80
%
%% gurobi_solution_read() reads solution vectors from a GUROBI file.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    21 June 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    string FILENAME, the name of the input file.
%
%  Output:
%
%    integer X(X_DIM), a vector of solution information.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'gurobi_solution_read:\n' );
  fprintf ( 1, '  Extract information from GUROBI file "%s".\n', filename );
%
%  Determine number of lines in the file.
%
  line_num = file_line_count ( filename );
  fprintf ( 1, '  The file contains %d lines of information.\n', line_num );
%
%  Allocate X.
%
  x = zeros ( line_num, 1 );
%
%  Each line will have the form  "name value" where name will be the letter 
%  "x" followed by an index, and value will be 0 or 1.
%
  input_unit = fopen ( filename );
%
%  Count the nonzeros.
%
  nz = 0;
  i_max = 0;

  for line_index = 1 : line_num

    line_text = fgetl ( input_unit );

    [ w1, line_text ] = s_word_extract_first ( line_text );
%
%  Depending on the format, a few of the initial lines of the file 
%  might NOT have the form "x##### value".  Such lines should be skipped.
%
    if ( w1(1) ~= 'x' )
      continue
    end

    i = str2num ( w1(2:end) );
    i_max = max ( i_max, i );

    [ w2, line_text ] = s_word_extract_first ( line_text );
    value = str2num ( w2 );

    if ( value ~= 0 )
      nz = nz + 1;
    end

    x(i) = value;

  end

  fclose ( input_unit );
%
%  Force all values in X to be nonnegative and integral.
%
  x = abs ( x );

  x = round ( x );
%
%  Report nonzeros.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '  The file contains %d nonzero values.\n', nz );
%
%  The value of line_num was used to guess the size of X.
%  The value of I_MAX is a better guess.
%
  if ( i_max ~= line_num )
    x = x(1:i_max);
    fprintf ( 1, '  X array size adjusted to %d\n', i_max );
  end

  return
end
