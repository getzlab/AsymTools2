function S2 = keep_fields(S,flds)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

% keep_fields(S,flds)
%
% given struct <S> and cell-array-of-strings <flds>,
% returns struct <S2> which has only those fields specified.
%
% Mike Lawrence 2009-04-24

if ischar(flds), flds = {flds}; end

S2=[];
for i=1:length(flds)
  if isempty(S)
    f = [];
  else
    f = getfield(S,flds{i});
  end
  S2=setfield(S2,flds{i},f);
end
