function M = get_strand(M),

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


install_path = regexprep(which('get_strand'),'helper_tools/.*','');

G = load([install_path 'reference/gene.mat']); G=G.tmp;
G = sort_struct(G,{'chr','tx_start'});
M = sort_struct(M,{'chr','pos'});

gidx = map_mutations_to_targets_fast([M.chr M.pos],[G.chr G.tx_start G.tx_end]);
M.txplus = nansub(strcmp(G.strand,'+'),gidx);
M.txminus = nansub(strcmp(G.strand,'-'),gidx);




