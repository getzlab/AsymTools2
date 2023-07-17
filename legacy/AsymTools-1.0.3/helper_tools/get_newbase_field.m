function newbase_field = get_newbase_field(M),

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


f = fields(M);
newbase_idx = find(grepmi('^newbase$|tumor_allele|^alt_allele$|newbase_idx',f));
if length(newbase_idx)>1,
   disp('Multiple newbase fields found');
   disp(['Using ' f{newbase_idx(1)}])
   newbase_field = f{newbase_idx(1)};
elseif length(newbase_idx)==0,
   error('No newbase field detected');
else
   newbase_field = f{newbase_idx};
end




