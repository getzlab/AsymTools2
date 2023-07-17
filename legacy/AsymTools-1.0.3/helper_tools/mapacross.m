function D = mapacross(A,B,C,filler)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

% D = mapacross(A,B,C[,filler])
%
% for each item in A,
%   looks for that item in B.
%   if found, returns the corresponding item in C;
%   if not found, returns "filler".
% returns the items as D.
%
% Mike Lawrence 2009-07-14

if nargin~=3 && nargin~=4
  error('usage: D = mapacross(A,B,C[,filler])');
end

if ~isnumeric(A) && ~iscell(A) && ~islogical(A)
  error('A should be numeric, cell, or logical');
end
if ~isnumeric(B) && ~iscell(B) && ~islogical(B)
  error('B should be numeric, cell, or logical');
end
if ~isnumeric(C) && ~iscell(C) && ~islogical(C)
  error('C should be numeric, cell, or logical');
end

if length(B) ~= length(C), error('length(B) ~= length(C)'); end

idx = listmap(A,B);
idx2 = find(~isnan(idx));

if ndims(C)>2 || (size(C,1)>1 && size(C,2)>1)
  flag=true;
  dsz = size(C); dsz(1) = length(A);
else
  flag=false;
  dsz = [length(A) 1];
end

if iscell(C)
  if ~exist('filler','var'), filler = ''; end
  D = repmat({filler},dsz);
elseif isnumeric(C)
  if ~exist('filler','var'), filler = nan; end
  D = filler*ones(dsz);
elseif islogical(C)
  if length(idx2)~=length(idx), error('Missing values when using logical output: behavior undefined'); end
  D = false(dsz);
else
  error('unknown output type');
end

if flag
  if ndims(C)>7, error('>7-D not supported'); end
  D(idx2,:,:,:,:,:,:) = C(idx(idx2),:,:,:,:,:,:);
else
  D(idx2) = C(idx(idx2));
end
