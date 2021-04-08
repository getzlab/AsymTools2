## Functions for the annotation of mutations

import pkg_resources
from capy.mut import map_mutations_to_targets
import pandas as pd

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
    reffile = pkg_resources.resource_filename('asymtools', f'reference/{fname}.{build}.txt')
    R = pd.read_csv(reffile, sep='\t')

    # Adds targ_idx column with index to reference interval
    map_mutations_to_targets(m,R)

    # Map over strand annotations
    m[[posname,negname]] = False
    idx = m['targ_idx']>=0
    m.loc[idx,[posname,negname]] = R.iloc[m.loc[idx,'targ_idx'],:][[posname,negname]].values




