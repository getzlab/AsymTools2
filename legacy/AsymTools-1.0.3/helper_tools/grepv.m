function keep = grepv(pattern,strings,flag)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

% grepv(pattern,strings,flag)
%
% inverse grep
%
% Mike Lawrence 2010-02-04

if ~exist('flag','var'), flag=0; end

toss = grep(pattern,strings,1);
keep = setdiff((1:length(strings))',toss);
if ~flag, keep = strings(keep); end
