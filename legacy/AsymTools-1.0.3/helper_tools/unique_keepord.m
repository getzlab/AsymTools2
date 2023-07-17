function [u ui uj] = unique_keepord(x,varargin);

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


if exist('varargin','var') && length(varargin)>=1 && ischar(varargin{1}) && (strcmpi(varargin{1},'first')|strcmpi(varargin{1},'last'))
  error('please do not specify "first" or "last" with this function.  (default is "first")');
end

[u1 ui1 uj1] = unique(x,'first',varargin{:});

[ui ord] = sort(ui1);
u = x(ui1(ord));
[tmp ord2] = sort(ord);
uj = ord2(uj1);

return

if iscell(x)
  if any(~strcmp(x,u(uj))) || any(~strcmp(u,x(ui))), error('unique_keepord not working properly!!!'); end
else
  if any(x~=u(uj)) || any(u~=x(ui)), error('unique_keepord not working properly!!!'); end
end
