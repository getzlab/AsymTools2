function plot_rt_bias_series(M,mut,n),

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


if nargin<3,
	n = 4;
end

W = get_territory_reference;
W = reorder_struct(W,W.is_right|W.is_left);
W.terr(W.is_right,:) = W.terr(W.is_right,[4 3 2 1]);
M = get_left_right(M);
W.rt_bin = bin(W.rt,n);
M.mut = strcat(M.ref_allele,repmat('>',slength(M),1),M.newbase);
M.first = strcmp(mut,M.mut);
M.second = strcmp([rc(mut(1)) '>' rc(mut(3))],M.mut);

M = sort_struct(M,{'chr','pos'});
M.widx = map_mutations_to_targets_fast([M.chr M.pos],[W.chr W.st W.en]);
M.rt_bin = nansub(W.rt_bin,M.widx);

ref_allele = mut(1);
bases('AC') = [1 2];
ref_idx = bases(ref_allele);

counts = zeros(2,n);
terr = zeros(2,n);
for ii = 1:n
	counts(1,ii)=sum(((M.first&M.is_left)|(M.second&M.is_right))&M.rt_bin==ii);
	counts(2,ii)=sum(((M.second&M.is_left)|(M.first&M.is_right))&M.rt_bin==ii);
	terr(:,ii) = sum(W.terr(W.rt_bin==ii,[ref_idx 5-ref_idx]),1);
end
npat = length(unique(M.patient));
[rates,sd] = ratio_and_sd(counts,npat*terr);
%Want late->early, so fliplr
rates = fliplr(rates);
terr = fliplr(terr);
plot_bias_series(rates,sd,mut);
xlabel('Late ----> Early');

