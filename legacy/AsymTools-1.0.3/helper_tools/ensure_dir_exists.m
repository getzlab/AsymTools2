function ensure_dir_exists(dirname)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


if ~iscell(dirname)
  if ~exist(dirname,'dir'), mkdir(dirname); end
else
  for i=1:numel(dirname)
    if ~exist(dirname{i},'dir'), mkdir(dirname{i}); end
  end
end

