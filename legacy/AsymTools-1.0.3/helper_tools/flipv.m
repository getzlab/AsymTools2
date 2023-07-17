function A = flipv(A)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

% flip(A)
% flips a vector 180 degrees, whether it's column or row.
% Mike Lawrence 2008-06-20
if sum(size(A)>1)>1, error('flip only works for vectors'); end
if size(A,1)==1, A=fliplr(A);
else A=flipud(A); end
end

