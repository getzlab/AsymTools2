% Usage : make_figures indir outdir
%
% Arguments:
%    indir  - A character array containing the path to a directory
%	      of MAF files. Each MAF file represents a cohort to
%             analyze. Required.
%    outdir - A character array containing the path to an output
%	      directory in which to save the figures. If left blank
%	      a figures directory will be created in the AsymTools
%	      directory.
%
%
% Output Figures:
%    The following figures are created for each MAF file (cohort_name).maf
%    -(cohort_name).replicative_bar_plot.pdf : This bar plot compares mutation rates 
%         of mutations and their complements in left- and right-replicating regions.
%    -(cohort_name).transcriptional_bar_plot.pdf : This bar plot compares mutation rates 
%         of mutations and their complements in tx-plus and tx-minus regions.
%    -(cohort_name).leading_and_sense_reference_bar_plot.pdf : This bar plot compares mutation rates 
%         of mutations and their complements with respect to the leading strand reference
%         and with respect to a sense strand reference.
%    -(cohort_name).joint_analysis_bar_plot.pdf : This plot jointly analyzes transcriptional and
%         replicative asymmetries by segmenting the genome by all combinations of transcription and
%         replication direction. 
%    The following figures are created for each cohort and mutation type (e.g. AtoG)
%    -(cohort_name).(muttype).expression_series_plot.pdf : This plot visualizes transcriptional
%         asymmetry of the given mutation type in regions of the genome with varying expression levels.
%    -(cohort_name).(muttype).rt_series_plot.pdf : This plot visualizes replicative
%         asymmetry of the given mutation type in regions of the genome with varying replication timing.
%    -(cohort_name).(muttype).left_right_transitions.pdf : This plot displays mutational densities 
%         around regions of the genome that transition from left- to right-replicating. This requires
%	  at least 5k mutations in the given channel for the pool cohort.
%    -(cohort_name).(muttype).tx_minus_plus_transitions.pdf : This plot displays mutational densities 
%         around regions of the genome that transition from tx-minus to tx-plus gene directions, often
%         due to bidirectional promoters. This requires at least 50k mutations in the given channel for
%	  the pooled cohort.
%    
%    The following summary figure is generated at after the creation of the above figures.
%    -asymmetry_map.pdf : The plot shows the strongest replicative and transcriptional asymmetry
%         metrics for each cohort analyzed. These metrics are the strongest asymmetry channels
%         (with sufficient mutational density) shown in lead_and_sense_reference_bar_plot.pdf.
%

function make_figures(indir,outdir)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

%Determine necessary paths
install_path = regexprep(which('make_figures'),'make_figures\.m$','');
reference_path = [install_path 'reference/'];
tools_path = [install_path 'helper_tools/'];
addpath(tools_path);

%Check input arguments
if nargin==0,
   disp('Usage : make_figures indir outdir');
   disp('User must specify a directory of MAF files for analysis');
   return;
end
if nargin<2,
   disp('No output directory specified...using:'); 
   outdir = [install_path 'figures/'];
   disp(outdir);
end
if ~ischar(indir)||~ischar(outdir),
   error('Inputs must be character arrays');
end


if ~strcmp(outdir(end),'/'), outdir = [outdir '/'];end

ede(outdir);
ede([outdir 'data/']);

x=[];
x.files = direc(indir);
x = reorder_struct(x,grepmi('\.(wgs|maf)$',x.files));
if slength(x)==0, error('No files with .maf extension found');end
x = parsein(x,'files','([^/])*\.(wgs|maf)','ttype');

signatures = {'A>C','A>G','A>T','C>A','C>G','C>T'};
load([reference_path 'per_base_territories_20kb.mat']);
for ii = 1:length(x.files),
        disp('Loading mutation data from:');
	disp(x.files{ii});
	if grepmi('\.maf$',x.files(ii)),
	    m = load_struct(x.files{ii});
	    m = standardize_maf(m);
	    m.chr = convert_chr(m.chr);
	    m = make_numeric(m,'pos');
	    demand_fields(m,{'chr','pos','ref_allele','newbase','patient'});
	else
           m = load2(x.files{ii},{'chr','pos','ref_allele','newbase','patient'});
	end

        %Twin bar plot segmented by replication direction
        m = get_left_right(m);
	ms = {m,reorder_struct(m,m.is_left),reorder_struct(m,m.is_right)};
        names = {'Entire Genome','Left-Replicating','Right-Replicating'};
        terr = {sum(W.terr,1),sum(W.terr(W.is_left,:),1),sum(W.terr(W.is_right,:),1)};
        [out,out_sd] = asym_plot2(ms,names,terr,signatures);set(gcf','Visible','off');
        print_to_file([outdir x.ttype{ii} '.replicative_bar_plot.pdf']);

        %Twin bar plot segmented by transcription direction
        m = get_strand(m);
	ms = {m,reorder_struct(m,m.txplus),reorder_struct(m,m.txminus)};
        terr = {sum(W.terr,1),sum(W.tx_terr(W.txplus,:),1),sum(W.tx_terr(W.txminus,:))};
        names = {'Entire Genome','Sense Strand','Antisense Strand'};
        [out,out_sd] = asym_plot2(ms,names,terr,signatures);set(gcf,'Visible','off');
        print_to_file([outdir x.ttype{ii} '.transcriptional_bar_plot.pdf']);

        %Twin bar plots with leading and sense strand reference
        mrt = flip_maf_by_rt(m);mtx = flip_maf_by_tx(m);
        ms = {m,mrt,mtx};
        names = {'Genomic Reference','Leading Reference','Sense Reference'};
        %Create territory references with respect to the leading and coding strands
	W2 = W;
        W2.terr(W2.is_right,:) = W2.terr(W2.is_right,[4 3 2 1]);
        terr{2} = sum(W2.terr(W2.is_right|W2.is_left,:),1);
        W3 = W;W3.tx_terr(W3.txminus,:) = W3.tx_terr(W3.txminus,[4 3 2 1]);
        terr{3} = sum(W3.tx_terr(W3.txplus|W3.txminus,:),1);

        [out,out_sd] = asym_plot2(ms,names,terr,signatures);
        print_to_file([outdir x.ttype{ii} '.leading_and_sense_reference_bar_plot.pdf']);
	%Metrics generated here will be used to make the scatter plot at the end
        parsave([outdir 'data/' x.ttype{ii} '.reptxbiasplot.data.mat'],out,out_sd);
	
	%3x3 Plots
	figure('Visible','off');
        make_bias_plots3(m);
	print_to_file([outdir x.ttype{ii} '.joint_analysis_bar_plot.pdf']);


	m = get_mut_idx(m);
	mut_count = histc(m.mut_idx,1:12);
	mut_count=  mut_count(1:6) + mut_count(12:-1:7);%Collapse complementary mutations
	%Figure 5 plots:
	for jj = 1:length(signatures),
		sig_name = strrep(signatures{jj},'>','to');
		%Transcriptional asymmetries binned by expression
		figure('Visible','off');
		plot_expr_bias_series(m,signatures{jj});
		print_to_file([outdir x.ttype{ii} '.' sig_name '.expression_series_plot.pdf']);
	
		%Replicative asymmetries binned by replication timing
		figure('Visible','off');
		plot_rt_bias_series(m,signatures{jj});
		print_to_file([outdir x.ttype{ii}  '.' sig_name '.replication_timing_series_plot.pdf']);
			
		if mut_count(jj) < 5e3, 
		    disp('Less than 5k mutations...');disp('Skipping...');continue; 
		end
		
		%Adds fields bpos, the signed distance to the nearest bdp
		%and opos the distance to the nearest local rt minimum
		m = annotate_bdp_ori_coord2(m);
		%Plot of mutational densities around left- to right-replicating transitions
		figure('Visible','off');
		m.tpos = m.opos;%Distance to nearest left/right transition
		terr = load([reference_path 'terr_tracks/ORI_terr.2Mb.10kbbins.mat']);terr = terr.track;
		make_transition_plots(m,terr,signatures{jj},-1e6,1e6,1e4);
		ylabel('Mutations/Mb');
		xlabel('-1Mb <--- L/R-transition ---> 1Mb');
		print_to_file([outdir x.ttype{ii} '.' sig_name  '.left_right_transition.pdf']);
		

		%Require at least 50k mutations for this analysis.
		if mut_count(jj) < 5e4, 
		    disp('Less than 50k mutations...');disp('Skipping...');continue; 
		end
	
		%Plot of mutational densities around BDPs
		figure('Visible','off');
		terr = load([reference_path 'terr_tracks/BDP_terr.100kb.1kbbins.mat']);terr = terr.track;
		m.tpos = m.bpos;%Distance to nearest BDP
		make_transition_plots(m,terr,signatures{jj},-5e4,5e4,1e3);
		ylabel('Mutations/Mb');
		xlabel('-50kb <--- BDP ---> +50kb');
		print_to_file([outdir x.ttype{ii} '.' sig_name  '.tx_minus_plus_transition.pdf']);

		close all
	end
        close all;
end

%Figure 3 scatter plot

%Calculate the channel with the greatest asymmetry
x.xcoords = zeros(slength(x),1);x.ycoords = zeros(slength(x),1);
x.txchan = cell(slength(x),1);x.repchan = cell(slength(x),1);
for ii = 1:slength(x),
        tmp=load([outdir 'data/' x.ttype{ii} '.reptxbiasplot.data.mat'],'varargin');
        out = tmp.varargin{1};out_sd=tmp.varargin{2};
	frac_density = (out{1,1}(1:2:end)+out{1,1}(2:2:end))/sum(out{1,1});
	major_idx = frac_density>0.15;%Require channel contributes >15% of mutational density to be considered
	out{2,2}(~major_idx) = NaN;
	out{2,3}(~major_idx) = NaN;
        [x.xcoords(ii),xidx] = max(abs(log2(out{2,2})));
        [x.ycoords(ii),yidx] = max(abs(log2(out{2,3})));
        x.txchan{ii} = signatures{yidx};
        x.repchan{ii} = signatures{xidx};
        x.xerr(ii,1) = 1.96*out_sd{2,2}(xidx);
        x.yerr(ii,1) = 1.96*out_sd{2,3}(yidx);
end
x.xerr = log2(2.^x.xcoords+x.xerr)-x.xcoords;
x.yerr = log2(2.^x.ycoords+x.yerr)-x.ycoords;
max_val = max([x.xcoords;x.ycoords]);


figure('Visible','off');
hold on;
scatter(x.xcoords,x.ycoords,'filled');

draw_ellipse(x.xcoords,x.ycoords,x.xerr,x.yerr,'r');
xspace = 0.03*diff(xlim);
textfit(x.xcoords+xspace,x.ycoords,x.ttype);
ylabel('Log Transcription Bias');
xlabel('Log Replication Bias');
ylim([0 1.1*max_val]);
xlim([0 1.1*max_val]);
set(gca,'LineWidth',3);
print_to_file([outdir 'asymmetry_map.pdf'],600);















