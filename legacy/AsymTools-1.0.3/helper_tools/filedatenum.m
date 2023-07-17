function sz = filedatenum(fname)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


if ischar(fname)
  d = dir(fname);
  sz = nan(length(d),1);
  for i=1:length(d)
    sz(i) = d(i).datenum;
  end
elseif iscell(fname)
  sz = nan(length(fname),1);
  for i=1:length(fname)
    d = dir(fname{i});
    if ~isempty(d), sz(i) = d(1).datenum; end
  end
end

