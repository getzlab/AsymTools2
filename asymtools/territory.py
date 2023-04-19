import pkg_resources
import pandas as pd

# type should be counts, exome (wxs), genome (wgs)
# stratification should be 'rep' or 'tx'
# Returns None if type is counts
def get_territory(type,stratification):

    if type == 'counts':
        return(None)

    terfile = pkg_resources.resource_filename('asymtools', f'reference/per_base_territories_20kb.txt')
    W = pd.read_csv(terfile,sep='\t')

    # Decide whether we need coding-only, transcribed-only, or total territory
    if type in ['exome','wxs']:
        key = 'cod_terr'
    #elif (type in ['genome','wgs']) and (stratification=='tx'):
    #    key = 'tx_terr'
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