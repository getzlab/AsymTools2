----------README---------

This toolbox enables creation of basic transcriptional and replicative mutational asymmetry plots 
as shown in the manuscript:
Mutational Strand Asymmetries in Cancer Genomes Reveal Mechanisms of DNA Damage and Repair
Nicholas J. Haradhvala, Paz Polak, Petar Stojanov, Kyle R. Covington, Eve Shinbrot, Julian Hess,
 Esther Rheinbay, Jaegil Kim, Yosef Maruvka, Lior Z. Braunstein, Atanas Kamburov, Philip C. Hanawalt,
 David A. Wheeler, Amnon Koren, Michael S. Lawrence and Gad Getz
published in January 28, 2016 issue of Cell

To run, enter a matlab session and run the matlab function
make_figures indir outdir

indir - The path to a directory containing whole genome Mutation Annotation Files (MAFs). Files must be named with the extension ".maf"
    Each MAF file should represent a merged patient cohort of interest. These mutations will be summed together for the analysis.
    Each MAF should have the following columns:
          chr : Chromosome number
	  pos : hg19 coordinate
	  ref_allele : The reference allele
	  newbase : The somatic variant
	  patient : A unique patient identifier

outdir - An output directory where generated figures will be saved.

Ex.
make_figures('~/myData/','~/Documents/Figures/myAsymmetryFigures');

This package is supported in Mac OS and Linux environments.
This package was developed using Matlab version 2013b.

v1.0.2 patch:
Updated code to allow use with Matlab version 2015b


