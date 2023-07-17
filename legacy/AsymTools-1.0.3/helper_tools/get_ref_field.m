function ref_field = get_ref_field(M),

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
ref_idx = find(grepmi('^ref$|ref_allele|ref_idx',f));
if length(ref_idx)>1,
   disp('Multiple reference fields found');
   disp(['Using ' f{ref_idx(1)}]);
   ref_field = f{ref_idx(1)};
elseif length(ref_idx)==0,
   error('No reference field detected');
else
   ref_field = f{ref_idx};
end




