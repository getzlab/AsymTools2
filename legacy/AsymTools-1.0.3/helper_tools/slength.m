function l = slength(S)

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
% slength(S)
%
% struct length
%
% Mike Lawrence 2008-08-27
%
l=NaN;
if isstruct(S)
 l = 0;
 if ~isempty(S) && ~isempty(fieldnames(S))
  f = fields(S);
  nf = length(f);
  len = nan(nf,1);
  for i=1:nf
    f1 = getfield(S,f{i});
    if ischar(f1), len(i) = 1;
    else len(i) = size(f1,1); end
  end
  ulen = unique(len);
  if length(ulen)==1, l = ulen;
  else
    fprintf('Warning: deprecated use of slength for structure with fields of nonuniform length\n');
    l = len(1);
  end
 end
end

