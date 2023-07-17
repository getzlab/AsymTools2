function [s order]=reorder_struct(s,order)

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
% Mike Lawrence 2008-06-11
%
% modified to handle NaN's, 2010-04-22

if nargin~=2, error('reorder_struct(s,order)'); end

if islogical(order), order = find(order); end
if ischar(order)
  if strcmpi(order,'end')
    order = slength(s);
  else
    error('invalid index parameter');
  end
end

order = as_column(order);

nanflag = any(isnan(order));

fields = fieldnames(s);
nf = length(fields);

for i=1:nf
  f = getfield(s,fields{i});
  if nanflag
    f = nansub(f,order);
  else
    f = f(order,:,:,:,:,:,:,:,:,:);
  end
  s = setfield(s,fields{i},f);
end


