function X = load2(fname,flds)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


if (nargin~=1 && nargin~=2) || nargout~=1 || ~ischar(fname), error('usage:  X = load2(fname)'); end

if ~exist(fname,'dir')
  error('directory %s does not exist',fname);
end

X = [];
d.file = direc([fname '/*.mat']);
d.datenum = get_filedatenum(d.file); d = sort_struct(d,'datenum');
d = parse_in(d,'file',[fname '/(.*)\.mat$'],'field');
for i=1:slength(d)
  if exist('flds','var') && ~ismember(d.field{i},flds), continue; end
  clear tmp;
  load(d.file{i},'tmp');
  if ~exist('tmp','var'), error('%s does not contain "tmp" variable',d.file{i}); end
  X = setfield(X,d.field{i},tmp);
end
