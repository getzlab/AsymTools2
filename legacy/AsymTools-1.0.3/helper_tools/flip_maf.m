function M = flip_maf(M,idx),

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


if isfield(M,'ref_allele'), M.ref_allele(idx) = rc(M.ref_allele(idx));end
if isfield(M,'newbase'), M.newbase(idx) = rc(M.newbase(idx));end

if isfield(M,'ref_idx'),
   M.ref_idx(idx) = 5-(M.ref_idx(idx));
   idx = idx(ismember(M.ref_idx,1:4));
   M = reorder_struct(M,ismember(M.ref_idx,1:4));
end
if isfield(M,'newbase_idx'),
        M.newbase_idx(idx) = 5-(M.newbase_idx(idx));
	idx = idx(ismember(M.newbase_idx,1:4));
	 M = reorder_struct(M,ismember(M.newbase_idx,1:4));
end


if isfield(M,'context65')&&isnumeric(M.context65), M.context65(idx) = flip_context65(M.context65(idx));end



