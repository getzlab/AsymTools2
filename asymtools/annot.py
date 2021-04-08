## Functions for the annotation of mutations

import pkg_resources
from capy.mut import map_mutations_to_targets
import pandas as pd

def annotate_tx_strand(m,build=None):

    if build is None:
        print('Assuming hg19...')
        build='hg19'

    txfile = pkg_resources.resource_filename('asymtools', f'reference/txdir.{build}.txt')

    G = pd.read_csv(txfile,sep='\t')

    map_mutations_to_targets(m,G)


    m[['txplus','txminus']] = False

    idx = m['targ_idx']>=0
    m.loc[idx,['txplus','txminus']] = G.iloc[m.loc[idx,'targ_idx'],:][['txplus','txminus']].values

def get_rep_strand(m,build=None):
    pass

