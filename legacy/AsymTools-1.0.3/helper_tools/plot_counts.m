function plot_counts(counts,sd,muts)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


counts = reshape(counts,2,[]);
sd = reshape(sd,2,[]);
colors = [0 0.2 0.8;0.1 0.8 0.1;0.5 0.3 0.7;0 0.7 0.7;1 0 0;1 1 0;];
cidx = listmap(muts(1:2:end),{'A>C','A>G','A>T','C>A','C>G','C>T'});
colors = colors(cidx,:);

errorbar_groups(counts,1.96*sd,'bar_colors',colors);
set(gca,'xtick',1:length(muts),'xticklabel',muts);
xlabel('Mutation Type');
ylabel('Mutation rates');





