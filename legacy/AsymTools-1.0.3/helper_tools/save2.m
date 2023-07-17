function save2(X,fname)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


if nargin~=2 || ischar(X) || ~ischar(fname), error('usage:  save2(X,fname)'); end
if ~isstruct(X), error('X should be a struct'); end

if exist(fname,'file') && ~exist(fname,'dir')
  error('%s already exists and is not a directory',fname);
end

ensure_dir_exists(fname);

f = fieldnames(X);
for i=1:length(f)
  tmp = getfield(X,f{i});
  save([fname '/' f{i} '.mat'],'tmp');
end

