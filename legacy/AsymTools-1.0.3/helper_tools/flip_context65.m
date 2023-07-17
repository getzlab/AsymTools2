function flip = flip_context65(context)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

%A=0
%C=1
%G=2
%T=3

z = mod(context-1,4);
y = mod(floor((context-1)/4),4);

flip = 65 - context + 3 * (y-z);

%cont65 = 4^2(mid)+4(first)+last+1
%flip= 4^2(3-(mid))+4(3-(last))+3-(first)+1

