%mut is string or cell aray of strings of form "A>C"
function mut_idx = mut2mut_idx(mut),

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


if iscell(mut),
   mut_idx = cellfun(@(x) mut2mut_idx(x),mut);
else
   ref = mut(1);newbase = mut(3);
   ref = listmap(ref,{'A','C','G','T'});
   newbase = listmap(newbase,{'A','C','G','T'});
   mut_idx = 3*(ref-1) + newbase - (newbase>ref);
end


