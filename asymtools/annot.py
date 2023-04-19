## Functions for the annotation of mutations

import pkg_resources
from capy.mut import map_mutations_to_targets, standardize_maf, convert_chr
import pandas as pd

# Pre-processes the maf to rename and add columns AsymTools expects
# maf: Either be a path to a maf file on disk, or a pandas dataframe
def preprocess_maf(maf):

    if type(maf) is str:
        m = pd.read_csv(maf, sep='\t',comment='#')
    else:
        m = maf

    # Rename standard columns
    m = standardize_maf(m)

    # Make sure chromosomes are numeric
    m['chr'] = convert_chr(m['chr'])

    # Filter any MT or other non-standard contigs
    standard_chr = list(range(1, 25))
    m = m[m['chr'].isin(standard_chr)]

    # Sort
    m = m.sort_values(['chr', 'pos']).reset_index(drop=True)

    # Annotate replication and transcription strand
    annotate_tx_strand(m)
    annotate_rep_strand(m)

    return(m)

# Annotate transcription strand
def annotate_tx_strand(m,build=None):
    annotate_strand(m,"txdir","txplus","txminus",build=build)

# Annotate replication strand
def annotate_rep_strand(m,build=None):
    annotate_strand(m,"replication_direction","is_left","is_right",build=build)

# m: maf file
# fname: base name of file in reference directory
# posname: name of column with binary annotation of positive strand
# negname: same for negative strand
# build: build (hg19 default)
def annotate_strand(m,fname,posname,negname,build=None):

    if build is None:
        print('Assuming hg19...')
        build='hg19'
    elif build=="hg38":
        raise Exception("Error: hg38 not yet implemented")

    # Load relevant reference file
    #reffile = pkg_resources.resource_filename('asymtools', f'reference/{fname}.{build}.txt')
    reffile = pkg_resources.resource_filename('asymtools', f'reference/per_base_territories_20kb.{build}.txt')
    R = pd.read_csv(reffile, sep='\t')

    # Adds targ_idx column with index to reference interval
    map_mutations_to_targets(m,R)

    # Map over strand annotations
    m[[posname,negname]] = False
    idx = m['targ_idx']>=0
    m.loc[idx,[posname,negname]] = R.iloc[m.loc[idx,'targ_idx'],:][[posname,negname]].values




