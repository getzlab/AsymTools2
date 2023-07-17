function make_bias_plots(mut)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


npat = length(unique(mut.patient));

% load reference files
W = get_territory_reference;

% conversions
mut.chr = convert_chr(mut.chr);
if ~isfield(mut,'pos'), mut.pos=mut.start; end
mut = make_numeric(mut,'pos');

% annotate mutations
if ~isfield(mut,'txplus')|~isfield(mut,'txminus'),
   mut = get_strand(mut);
end
if ~isfield(mut,'is_left')|~isfield(mut,'is_right'),
   mut = get_left_right(mut);
end

bases = {'A','C','G','T'};
mut.from_idx = listmap(mut.ref_allele,bases);
mut.to_idx = listmap(mut.newbase,bases);

% make bias plots
txstrands = {'all','tx(+)','tx(-)'};
n=[];N=[];for txstrand=1:3
      midx = 1:slength(mut);
      widx = 1:slength(W);
      if txstrand==2, 
         midx = midx(mut.txplus(midx));
	 widx = widx(W.txplus(widx));
      elseif txstrand==3, midx = midx(mut.txminus(midx)); 
      widx = widx(W.txminus(widx));% transcribed (-)
      else % txstrand==1, all territory
      end
    midx_left = midx(mut.is_left(midx));
    midx_right = midx(mut.is_right(midx));
    widx_left = widx(W.is_left(widx));
    widx_right = widx(W.is_right(widx));
    n(:,:,:,txstrand) = cat(3,hist2d_sparse(mut.from_idx(midx),mut.to_idx(midx),1,4,1,4),...
                                  hist2d_sparse(mut.from_idx(midx_left),mut.to_idx(midx_left),1,4,1,4),...
                                  hist2d_sparse(mut.from_idx(midx_right),mut.to_idx(midx_right),1,4,1,4));
    N(:,1,:,txstrand) = [sum(W.terr(widx,:),1) ;sum(W.terr(widx_left,:),1);sum(W.terr(widx_right,:),1)]';
    
end
[r,e] = ratio_and_sd(n,repmat(N,[1,4,1,1])*npat);

B=[]; idx = 1; for i=1:2, for j=1:4, if i==j, continue; end
  B.name{idx,1} = [bases{i} '->' bases{j} ' / ' bases{5-i} '->' bases{5-j}];
  [B.bias(idx,:,:) B.bias_std(idx,:,:)] = ... 
  	propagate_error_in_quotient(r(i,j,:,:),e(i,j,:,:),r(5-i,5-j,:,:),e(5-i,5-j,:,:));
idx=idx+1; end, end
B.color = [0 0 1;0.2 0.7 0.2;0.6 0 0.6;0 0.7 0.7;1 0 0;1 1 0];
dirs = {'Entire genome','left-replicating','right-replicating'};

clf;
idx=1; for txstrand=1:3, for i=1:3, subplot(3,3,idx)
  hold on
  for j=1:size(B.bias,1),
 	 bar(j,log2(B.bias(j,i,txstrand)),'FaceColor',B.color(j,:));
  end
  h=errorbar(1:slength(B),log2(B.bias(:,i,txstrand)),...
  	log2(max((B.bias(:,i,txstrand)-B.bias_std(:,i,txstrand)),0)./B.bias(:,i,txstrand)),...
  	log2((B.bias(:,i,txstrand)+B.bias_std(:,i,txstrand))./B.bias(:,i,txstrand)),...
	'.k');
  set(h,'Marker','none');
  set_error_bar_width(h,0.5);
  hold off
  ylim([-1 1]);
  xlim([0 6.5]);
  set(gca,'xtick',[],'tickdir','out');
  if i==1, ylabel(txstrands{txstrand},'fontsize',20); end
  if txstrand==1, title(dirs{i},'fontsize',20); end
idx=idx+1; end, end, set(gcf,'color',[1 1 1]);


