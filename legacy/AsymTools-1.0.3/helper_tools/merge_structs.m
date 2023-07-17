function out = merge_structs(varargin)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

% merge_structs(s1,s2)
%
%    (two input parameters, each a struct)
%    calls merge_structs1.m  
%    written by Craig Mermel
%
% merge_stucts(slist)
%
%    (one input parameter, a cell array of structs)
%    calls merge_structs2.m
%    written by Mike Lawrence
%
%

if nargin==2
  out = merge_structs1(varargin{:});
elseif nargin==1 
  out = merge_structs2(varargin{:});
else
  error('Unknown input type for merge_structs');
end

