function M = get_mut_idx(M),

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


ref = M.(get_ref_field(M));
newbase = M.(get_newbase_field(M));

if iscell(ref),
    ref = listmap(ref,{'A','C','G','T'});
end
if iscell(newbase),
    newbase = listmap(newbase,{'A','C','G','T'});
end
ref(~ismember(ref,1:4)) = NaN;
newbase(~ismember(newbase,1:4)) = NaN;
M.mut_idx = 3*(ref-1) + newbase - (newbase>ref);




