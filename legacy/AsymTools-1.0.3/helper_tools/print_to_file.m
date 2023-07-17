function print_to_file(filename,varargin)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


if nargin == 1
  [dev res] = interpret_print_filename(filename);
else 
  dev = interpret_print_filename(filename);
  res = varargin{1};
end 
%keyboard

if nargin == 1
  [dev res] = interpret_print_filename(filename);
else
  dev = interpret_print_filename(filename);
  res = varargin{1};
end

fprintf('Outputting figure to %s\n', filename);
print(['-d' dev], ['-r' num2str(res)], filename);

end
