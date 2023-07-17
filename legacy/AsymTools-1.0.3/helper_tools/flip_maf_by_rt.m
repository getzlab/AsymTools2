%Flips a maf with reference strand perspective to leading strand perspective

function M = flip_maf_by_rt(M,build)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


if nargin<2
        build = 'hg19';
end

M = standardize_maf(M);

if ~isfield(M,'is_left')|~isfield(M,'is_right'),
	M = get_left_right(M);
end
idx = ~M.is_left&~M.is_right;
M = reorder_struct_exclude(M,idx);
if sum(~idx)==0,
     return;
end


neg_idx = M.is_right;
%tx_flip('+-') = '-+';

M = flip_maf(M,neg_idx);
%if isfield(M,'ref_allele'), M.ref_allele(neg_idx) = rc(M.ref_allele(neg_idx));end
%if isfield(M,'newbase'), M.newbase(neg_idx) = rc(M.newbase(neg_idx));end
%if isfield(M,'context65'), M.context65(neg_idx) = flip_context65(M.context65(neg_idx));end
%if isfield(M,'strand'), 
%	M.strand(~strcmp(M.strand,'+')&~strcmp(M.strand,'-'))={''};
%	M.strand(neg_idx) = cellfun(@(x) {tx_flip(x)},M.strand(neg_idx));
%end


