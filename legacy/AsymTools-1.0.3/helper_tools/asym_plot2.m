%Plots twin bar of mutational densities for muts for each
%    M struct in cell array Ms, named by names, and with territory given by cell array terr
function [out out_sd] = asym_plot2(Ms,names,terr,muts),

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

if isstruct(Ms),
	Ms = {Ms};
end

if ~iscell(names),
	names = {names};
end
if ~iscell(terr),
	terr = {terr};
end

forward_muts = {'A>C','A>G','A>T','C>A','C>G','C>T'};
rev_muts = {'G>A','G>C','G>T','T>A','T>C','T>G'};
all_muts = [forward_muts rev_muts];
if ~exist('muts')||(ischar(muts)&&strcmp(muts,'all')),
	muts = forward_muts;
end

muts = mapacross(muts,forward_muts,1:6);

%expand 6 to 12
muts = reshape([as_row(muts) ; as_row(13-muts)],length(muts)*2,1);

nmaf = length(Ms);
if ~exist('terr'),
	terr = repmat({[1 1 1 1]},nmaf,1);
end

if isnumeric(terr),
	terr = {terr};
end
if ~exist('names'),
	names = repmat({'Untitled'},nmaf,1);
end

%count rates and ratios
rates = {};
rates_sd = {};
ratios = {};
ratios_sd = {};
for ii=1:nmaf,
	f=fields(Ms{ii});
	pat_field = find(grepmi('pat|barcode',f));
	if isempty(pat_field),
	   fprintf('Warning...no patients field found. Assuming npat=1, rates will be incorretly scaled for multiple patients \n');
	else
	   if length(pat_field)>1,
	    fprintf('Warning...found multiple fields for patient:\n');
	    fprintf('%s\n',f{pat_field});
	    fprintf('\nUsing %s',f{pat_field(1)});
	   end
	   npat = length(unique(Ms{ii}.(f{pat_field(1)})));
	end
	ref_field = find(grepmi('^ref$|ref_allele',f));
	newbase_field = find(grepmi('^newbase$|^alt$|^tum(or)?)_allele2',f));
	if ~isfield(Ms{ii},'ref_idx'),Ms{ii}.ref_idx = listmap(Ms{ii}.(f{ref_field(1)}),{'A','C','G','T'});end
	if ~isfield(Ms{ii},'newbase_idx'),Ms{ii}.newbase_idx = listmap(Ms{ii}.(f{newbase_field(1)}),{'A','C','G','T'});end
	
	Ms{ii}.mut_idx = 3*(Ms{ii}.ref_idx-1) + Ms{ii}.newbase_idx - (Ms{ii}.newbase_idx>Ms{ii}.ref_idx);
	counts = histc(Ms{ii}.mut_idx,1:12);
	counts = counts(muts);
	counts(isnan(counts))=0;
	counts = as_column(counts);%Protect against cases of 1 mutation
	bases('ACGT') = 1:4;
	terr_idx = floor((muts-1)/3)+1;
	mut_terr = as_column(terr{ii}(terr_idx));
	[rates{ii} rates_sd{ii}] = ratio_and_sd(counts,npat*mut_terr);
	[ratios{ii} ratios_sd{ii}] = propagate_error_in_quotient(...
		rates{ii}(1:2:end),rates_sd{ii}(1:2:end),...
		rates{ii}(2:2:end),rates_sd{ii}(2:2:end));
end

figure('position',[200 400 1200 425]);set(gcf,'Visible','off');

out = cell(2,nmaf);
out_sd = cell(2,nmaf);
h = zeros(2,nmaf);
ymargin = 0.085;
xmargin = 0.075;
ratioh = 0.25;
countsh = 0.75;
for i = 1:nmaf,
    h(2,i) = subplot('position',[(i-1)/nmaf+xmargin,ymargin,1/nmaf-xmargin,ratioh-0.5*ymargin]);
    out{2,i}=ratios{i};
    out_sd{2,i}=ratios_sd{i};
    plot_ratios(ratios{i},ratios_sd{i},forward_muts(muts(1:2:end)));
    ylabel('Log_2 Ratio');
    xlabel('Mutation Type');


    h(1,i) = subplot('position',[(i-1)/nmaf+xmargin,ratioh+ymargin,1/nmaf-xmargin,countsh-2*ymargin]);
    out{1,i}=rates{i};
    out_sd{1,i}=rates_sd{i};
    plot_counts(rates{i}*1e6,rates_sd{i}*1e6,all_muts(muts));
    title(names{i});
    ylabel('Mutations/Mb');
    xlabel('');
    set(gca,'XTickLabel','');
end

%Resize counts panes
max_value = max(max([out{1,:}]))*1e6;

for i = 1:nmaf,
	axes(h(1,i));set(gcf,'Visible','off');
	ylim([0 1.1*max_value]);
end
set(gcf,'color',[1 1 1])

