function x = parse_in(x,parsefield,pattern,newfields,numidx)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

% x = parse_in(x,parsefield,pattern,newfields,numidx)

if ~exist('numidx','var'), numidx=[]; end

tmp = parse(getfield(x,parsefield),pattern,newfields,numidx);
x = merge_structs({x,tmp});
