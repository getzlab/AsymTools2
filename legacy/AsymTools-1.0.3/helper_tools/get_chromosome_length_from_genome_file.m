function filesize = get_chromosome_length_from_genome_file(cset,build)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


install_path = regexprep(which('get_chromosome_length_from_genome_file'),'helper_tools/.*','');

load([install_path 'reference/chromosome_lengths'],'C');
filesize = C(cset);
