function plot_bias_series(rates,sd,mut),

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


[ratios ratios_sd] = propagate_error_in_quotient(rates(1,:),sd(1,:),rates(2,:),sd(2,:));

colors = [0 0.2 0.8;0.1 0.8 0.1;0.5 0.3 0.7;0 0.7 0.7;1 0 0;1 1 0;0 0 0;0 0 0];
cidx = find(grepmi(mut,{'A>CT>G','A>GT>C','A>TT>A','C>AG>T','C>GG>C','C>TG>A','A>NT>N','C>NG>N'}));

color = colors(cidx,:);
color = repmat(color,size(rates,2),1);

ymargin = 0.035;
xmargin = 0.08;
ratioh = 0.25;
countsh = 0.75;
h1=subplot('position',[xmargin,ratioh+ymargin,1-2*xmargin,countsh-2*ymargin]);
errorbar_groups(rates*1e6,1.96*sd*1e6,'bar_colors',color);
ylabel('Mutations/Mb');
set(gca,'XTick',[]);
h2=subplot('position',[xmargin,ymargin,1-2*xmargin,ratioh-1.5*ymargin]);
bar(1:size(ratios,2),log2(ratios),'FaceColor',color(1,:));
hold on;
h=errorbar(1:size(ratios,2),log2(ratios),log2(ratios+1.96*ratios_sd)-log2(ratios),log2(max(ratios-1.96*ratios_sd,0))-log2(ratios),'.k');
set(h,'Marker','none');
set_error_bar_width(h,0.5);
hold off;
ylim([-2 2]);
box off;
set(gca,'YTick',[-2 0 2]);
set(gca,'XTick',[]);
ylabel('Log_2 Ratio');
