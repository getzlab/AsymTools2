function S = merge_structs(slist)

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
% merge_structs(slist)
%
% slist should be a cell array of structs,
%   all of which have the slength
% 
% returns a new struct which has all the fields of the input structs
%
% Mike Lawrence 2009-02-04
%

if ~iscell(slist)
  error('input should be a cell array of structs');
end

S=[];
for i=1:numel(slist)
  if ~isstruct(slist{i})
    error('input should be a cell array of structs');
  end
  s = slist{i};
  if i==1
    S = slist{i};
  else
    if slength(s) ~= slength(S)
      error('all input structs must have same length');
    end
    fields = fieldnames(s);
    for fno=1:length(fields), fn = fields{fno};
      f = getfield(s, fn);
%      if isfield(S,fn), fprintf('Warning: duplicate field %s overwritten\n',fn);end
      S = setfield(S,fn,f);
    end
  end
end



