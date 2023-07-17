function x = parse(S,r,f,numeric)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

% x = parse(S,r,f)
%
% S = cell array of strings
% r = regexp to match
% f = fieldnames for output
% numeric = which columns to make numeric
%
% x = output struct with tokens from regexp stored in fields designated by f
%
% Mike Lawrence 2009-02-11 

if ~iscell(S), S = tolines(S); end
tokens = regexp(S,r,'tokens');

if ~iscell(f), f = {f}; end
x = tokens2struct(tokens,f);

if exist('numeric','var'), x = make_numeric(x,f(numeric)); end
