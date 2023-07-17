function make_transition_plots(M,terr,mut,st,en,interval)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.



ref_idx = strcmp(mut(1),'C');
ref_idx = ref_idx+1;

f = fields(M);
pat_field = find(grepmi('^pat$|^pat_idx$|patient|pidx|tumor_sample_barcode',f),1);
npat = length(unique(M.(f{pat_field})));


M = get_mut_idx(M);
mut_idx = mut2mut_idx(mut);
idx = M.mut_idx==mut_idx;
idx2 = M.mut_idx==(13-mut_idx);

n1 = histc(M.tpos(idx),(st-interval/2):interval:(en+interval/2));
n1 = n1(1:((en-st)/interval+1));
N1 = terr(ref_idx,:)';
N1(end) = NaN;
n2 = histc(M.tpos(idx2),(st-interval/2):interval:(en+interval/2-1));
n2 = n2(1:((en-st)/interval+1));
N2 = terr(5-ref_idx,:)';
N2(end) = NaN;

r1 = 1e6/npat*n1./N1;
r2 = 1e6/npat*n2./N2;
smoothing = 30;
lw = 60;
scatter_size = 60;
blue = [.5 .5 1];
red = [1 .5 .5];
clf;
hold on;
plot(st:interval:en,smooth(r1,smoothing),...
        'Color',blue,'LineWidth',lw);
plot(st:interval:en,smooth(r2,smoothing),...
        'Color',red,'LineWidth',lw);
scatter(st:interval:en,r1,scatter_size,'b','filled');
scatter(st:interval:en,r2,scatter_size,'r','filled');

xlim([st en-interval]);
set(gca,'XTickLabel','');


med = nanmedian([r1' r2']);
sd = nanstd([r1' r2']);
ylim([max(med-3*sd,0) med+3*sd]);





