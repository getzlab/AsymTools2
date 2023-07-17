function c = concat(strings,separator)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

%
% concat(strings,separator)
%
% joins strings into one string, separated with the specified character/string
%
% Mike Lawrence 2008-05-01

c='';
for i=1:length(strings)
  if ischar(strings(i))
    c=[c strings(i)];
  elseif isnumeric(strings(i))
    c=[c num2str(strings(i))];
  elseif isnumeric(strings{i})
    c=[c num2str(strings{i})];
  elseif iscell(strings(i))
    c=[c strings{i}];
  else
    error('concat does not know how to handle that kind of input');
  end
  if i<length(strings)
    c=[c separator];
  end
end
