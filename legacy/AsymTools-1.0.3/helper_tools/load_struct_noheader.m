function X = load_struct_noheader(fname,numcols,colnames)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

% load_struct_noheader(fname[,numcols][,colnames])
% or 
% load_struct_noheader(fname[,format][,colnames])
% 
%
% Mike Lawrence 2010-01-20
%
% edited by Petar Stojanov 2013-10-22 to include 
% skipping of comment lines. The function will assume that when 
% load_struct is called without header, the comments should be removed as well. 
%


if ~exist('fname','var'), error('Must specify fname'); end
demand_file(fname);

if nargin==2 && iscell(numcols)
  colnames = numcols;
  numcols = [];
end

if ~exist('numcols','var') || isempty(numcols)
  f = fopen(fname);
  l = fgetl(f);
  while contains(l, '@') | contains(l, '#')
    l = fgetl(f);
  end
  numcols = sum(l==char(9))+1;
end

if isnumeric(numcols)
  format = repmat('%s',1,numcols);
else
  format = numcols;
end
X = load_struct(fname,format,char(9),0);

if exist('colnames','var')
  nf = length(fieldnames(X));
  nc = length(colnames);
  n = min([nf,nc]);
  X = rename_fields(X,colx(1:n),colnames(1:n));
  X = orderfields_first(X,colnames(1:n));
end
