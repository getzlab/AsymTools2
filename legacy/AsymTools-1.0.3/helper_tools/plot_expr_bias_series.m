function [rates sd] =  plot_expr_bias_series(M,mut,n),

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
	n=4;
end

M = sort_struct(M,{'chr','pos'});
M = get_strand(M);

ref_allele = mut(1);
bases('AC') = [1 2];
ref_idx = bases(ref_allele);
M.mut = strcat(M.ref_allele,repmat('>',slength(M),1),M.newbase);
if strcmp(mut(3),'N'),
   mut2 = ['^' rc(mut(1)) '>' '.$'];
   mut1 = ['^' mut(1:2) '.$'];
else
   mut2 = ['^' rc(mut(1)) '>' rc(mut(3)) '$'];
   mut1 = ['^' mut '$'];
end
M.first = grepmi(mut1,M.mut);

M.second = grepmi(mut2,M.mut);


W = get_territory_reference;
W = sort_struct(W,{'chr','st'});
W.igr = ~W.txplus&~W.txminus;

%BIN
W.expr_bin = zeros(slength(W),1);
[W.expr_bin(~W.igr) mp]= bin(W.expr(~W.igr),n);
M.expr_bin = zeros(slength(M),1);
widx = map_mutations_to_targets_fast([M.chr M.pos],[W.chr W.st W.en]);
M.expr_bin = nansub(W.expr_bin,widx);

counts = zeros(2,n);
terr = zeros(2,n);

for ii = 1:n,
        counts(1,ii) = sum(M.expr_bin==ii&((M.first&M.txplus)|(M.second&M.txminus)));
        counts(2,ii) = sum(M.expr_bin==ii&((M.second&M.txplus)|(M.first&M.txminus)));
	terr(:,ii) = sum(W.terr(W.expr_bin==ii&W.txplus,[ref_idx 5-ref_idx]),1)+...
		sum(W.terr(W.expr_bin==ii&W.txminus,[5-ref_idx ref_idx]),1);
end
npat = length(unique(M.patient));
[rates,sd] = ratio_and_sd(counts,terr*npat);
plot_bias_series(rates,sd,mut);
xlabel('Increasing Expression');
ylabel('Log_2 Ratio');






