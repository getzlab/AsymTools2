## Functions for the annotation of mutations

import pkg_resources
from capy.mut import map_mutations_to_targets, standardize_maf, convert_chr
import pandas as pd


def preprocess_maf(maf):
    """
    Pre-processes the maf to rename and add columns AsymTools expects
    :param maf:  Either be a path to a maf file on disk, or a pandas dataframe
    :return: pandas dataframe with preprocessed maf
    """
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
    """Annotates transcription direction (in place)"""
    annotate_strand(m, "txplus", "txminus", build=build)

# Annotate replication strand
def annotate_rep_strand(m,build=None):
    """Annotates replication direction (in place)"""
    annotate_strand(m, "is_left", "is_right", build=build)


def annotate_strand(m, posname, negname, build=None):
    """
    Annotates strand information (in place) using specified fields in reference
    :param m: maf file
    :param posname: Field to use as positive strand
    :param negname: Field to use as negative strand
    :param build: genome version used for mutation calling. Currently only hg19 supported
    """
    if build is None:
        print('Assuming hg19...')
        build='hg19'
    elif build=="hg38":
        raise Exception("Error: hg38 not yet implemented")

    # Load relevant reference file
    reffile = pkg_resources.resource_filename('asymtools', f'reference/per_base_territories_20kb.{build}.txt')
    R = pd.read_csv(reffile, sep='\t')

    # Adds targ_idx column with index to reference interval
    map_mutations_to_targets(m,R)

    # Map over strand annotations
    m[[posname,negname]] = False
    idx = m['targ_idx']>=0
    m.loc[idx,[posname,negname]] = R.iloc[m.loc[idx,'targ_idx'],:][[posname,negname]].values




