function result = contains(string,substring)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


if ~iscell(string), string={string}; end

if ~ischar(substring)
  error('second argument should be a string');
end

result = false(length(string),1);
for s=1:length(string)
  if length(substring)<=length(string{s})
    idx = 1:length(string{s})-length(substring)+1;
    for i=1:length(substring)
      idx = idx(find(string{s}(idx+i-1)==substring(i)));
      if isempty(idx), break; end
    end
    if ~isempty(idx), result(s) = true; end
  end
end  
