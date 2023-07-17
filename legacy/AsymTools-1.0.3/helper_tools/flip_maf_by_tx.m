function M = flip_maf_by_tx(maf,build)

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

M = standardize_maf(maf);

if ~isfield(M,'txplus')|~isfield(M,'txminus'),
     M = get_strand(M);
end


M = reorder_struct(M,M.txplus|M.txminus);
M = flip_maf(M,M.txminus);
