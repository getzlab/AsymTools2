function plot_ratios(ratios,sd,muts)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


colors = [0 0.2 0.8;0.1 0.8 0.1;0.5 0.3 0.7;0 0.7 0.7;1 0 0;1 1 0;];
cidx = listmap(muts,{'A>C','A>G','A>T','C>A','C>G','C>T'});
colors = colors(cidx,:);

hold on
for i = 1:length(ratios),
        bar(i,log2(ratios(i)),'FaceColor',colors(i,:));
end

h=errorbar((1:length(muts))',log2(ratios),log2(max(ratios-1.96*sd,0)./ratios),...
        log2((ratios+1.96*sd)./ratios),'k.');
set(h,'Marker','none');
set_error_bar_width(h,0.5);
hold off
set(gca,'xtick',1:length(muts),'xticklabel',muts,'fontsize',8);
xlabel('Mutation/Complement');
ylabel('Log2 Ratio');
ylim([-1 1]);

