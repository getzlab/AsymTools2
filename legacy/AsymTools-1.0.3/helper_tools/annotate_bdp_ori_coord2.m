function M = annotate_bdp_ori_coord2(M),

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


install_path = regexprep(which('annotate_bdp_ori_coord2'),'helper_tools/.*','');

ln = get_chromosome_length_from_genome_file(1:22,'hg19');
chrstart = cumsum([0;ln]);
chrstart = chrstart+1;

%Load BDP and ORI structs
load([install_path 'reference/BDPs.mat'],'B');
load([install_path 'reference/ORIs.mat'],'O');



O = reorder_struct(O,ismember(O.chr,1:22));
O = sort_struct(O,{'chr','coord'});
O.int_start(2:slength(O),1) = floor((O.pos(1:end-1)+O.pos(2:end))/2);
O.int_end(1:slength(O)-1,1) = O.int_start(2:slength(O),1)-1;
[zzz,ui] = unique(O.chr,'first');
O.int_start(ui,1) = 1;
[zzz,ui] = unique(O.chr,'last');
O.int_end(ui,1) = ln;


M = sort_struct(M,{'chr','pos'});
oidx = map_mutations_to_targets_fast([M.chr M.pos],[O.chr O.int_start O.int_end]);
M.opos = M.pos-nansub(O.pos,oidx);

B = reorder_struct(B,ismember(B.chr,1:22));
B = sort_struct(B,{'chr','coord'});
B.int_start(2:slength(B),1) = floor((B.pos(1:end-1)+B.pos(2:end))/2);
B.int_end(1:slength(B)-1,1) = B.int_start(2:slength(B),1)-1;
[zzz,ui] = unique(B.chr,'first');
B.int_start(ui,1) = 1;
[zzz,ui] = unique(B.chr,'last');
B.int_end(ui,1) = ln;


M = sort_struct(M,{'chr','pos'});
bidx = map_mutations_to_targets_fast([M.chr M.pos],[B.chr B.int_start B.int_end]);
M.bpos = M.pos-nansub(B.pos,bidx);

