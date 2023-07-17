function L = text_to_lines(X)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


%X = regexprep(X,'\w+$','');

while ~isempty(X)
  if X(end)==10, X(end)=[];   % remove trailing blank lines
  else break; end
end

if isempty(X), L={};
else L = split(X,char(10)); end

