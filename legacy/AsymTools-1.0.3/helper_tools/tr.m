function new = tr(string,from,to)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

% tr(string,from,to)
%
% implementation of Perl $new = ($string ~= tr/$from/$to/)
%
% supports cell arrays of strings.
%
% Mike Lawrence 2008-04-29

if length(from) ~= length(to), error('from and to must be same length'); end

if ischar(string)
  new = string;
  for i=1:length(from)
     new(find(string==from(i))) = to(i);
  end
elseif iscell(string)
  new = string;
  for c=1:numel(string)
    new{c} = string{c};
    for i=1:length(from)
       new{c}(find(string{c}==from(i))) = to(i);
    end
  end
else
  error('input to tr must be string or cell array of strings');
end
