import pkg_resources
import pandas as pd


def get_territory(type,stratification,build='hg19'):
    '''
    Get genomic base counts for regions of the genome with specified parameters
    :param type: Whether to use genomic or exome territory
    :param stratification: Whether to stratify by transcription (tx) or replication (rep) direction
    :param build: genome version, currently only hg19 supported
    :return: pandas dataframe with counts of each base
    '''

    if type == 'counts':
        return(None)

    terfile = pkg_resources.resource_filename('asymtools', f'reference/per_base_territories_20kb.{build}.txt')
    W = pd.read_csv(terfile,sep='\t')

    # Decide whether we need coding-only or total territory
    if type in ['exome','wxs']:
        key = 'cod_terr'
    else:
        key = 'terr'

    base_keys = [key+'_'+base for base in 'ACGT']

    # Decide what fields to sum over
    if stratification == 'tx':
        fields = ['txplus','txminus']
    elif stratification == 'rep':
        fields = ['is_left','is_right']
    else:
        print(f'Error: Unknown stratification {stratification}')

    # Encode a 0: neither, 1: first, 2: second, 3: both
    W['categ'] = W[fields[0]] + 2*W[fields[1]]

    N = W.groupby('categ')[base_keys].sum().T.astype(int)
    N.index = ['A','C','G','T']

    return(N)