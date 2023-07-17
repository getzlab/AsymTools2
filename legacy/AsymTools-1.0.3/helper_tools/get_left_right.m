function M=get_left_right(M,rt_data)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


install_path = regexprep(which('get_left_right'),'helper_tools/.*','');
X=[];
if nargin<2,
     load([install_path 'reference/left.right.mat'],'Q','window');
     Q = sort_struct(Q,{'chr','pos'});
     X.chr = Q.chr;
     X.start = Q.pos+1;
     X.end = Q.pos+window;
     X.is_left = Q.is_left;
     X.is_right = Q.is_right;
else
    X = rt_data;
end
M = sort_struct(M,{'chr','pos'});

qidx = map_mutations_to_targets_fast([M.chr M.pos],[X.chr X.start X.end]);
M.is_left = nansub(X.is_left,qidx);
M.is_right = nansub(X.is_right,qidx);





