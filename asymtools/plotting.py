import matplotlib.pyplot as plt
import pandas as pd

def twin_bar_txplot(m):

    m['mut'] = m['ref_allele'] + '>' + m['newbase']

    # Count 12 mutation types x 3 strand categories (unknown, plus, minus)
    X = pd.crosstab(m['mut'],m['txplus'] + 2*m['txminus'])

    f,ax = plt.subplots(1,3,figsize=(10,3))

    x = X.sum(axis=1)
    twin_bar_plot(x,ax=ax[0])
    ax[0].set_title('Reference')
    ax[0].set_ylabel('# Mutations')

    twin_bar_plot(X.iloc[:,1],ax=ax[1])
    ax[1].set_title('Sense')

    twin_bar_plot(X.iloc[:,2],ax=ax[2])
    ax[2].set_title('Anti-sense')

    plt.tight_layout()

def twin_bar_repplot(m):

    m['mut'] = m['ref_allele'] + '>' + m['newbase']

    # Count 12 mutation types x 3 strand categories (unknown, plus, minus)
    X = pd.crosstab(m['mut'],m['is_left'] + 2*m['is_right'])

    f,ax = plt.subplots(1,3,figsize=(10,3))

    x = X.sum(axis=1)
    twin_bar_plot(x,ax=ax[0])
    ax[0].set_title('Reference')
    ax[0].set_ylabel('# Mutations')

    twin_bar_plot(X.iloc[:,1],ax=ax[1])
    ax[1].set_title('Left-replicating')

    twin_bar_plot(X.iloc[:,2],ax=ax[2])
    ax[2].set_title('Right-replicating')

    plt.tight_layout()

def twin_bar_plot(x,ax):

    bar_offset = .2
    bar_width=.4
    colors = {'A>C':[0,0.2,0.8],
              'A>G':[0.1,0.8,0.1],
              'A>T':[0.5,0.3,0.7],
              'C>A':[0,0.7,0.7],
              'C>G':[1,0,0],
              'C>T':[1,1,0]}
    i = 0
    bars = list()
    muts = list()
    for ref in 'AC':
        for newbase in 'ACGT'.replace(ref,''):
            name=f'{ref}>{newbase}'
            rc_name = f'{rc(ref)}>{rc(newbase)}'

            # Add twin bars
            bars.append(pd.Series({'name':name,
                       'x':i-bar_offset,'y':x.loc[name],'color':colors[name]}))
            bars.append(pd.Series({'name':rc_name,
                       'x':i+bar_offset,'y':x.loc[rc_name],'color':colors[name]}))

            muts.append(name)
            i+=1
    B = pd.concat(bars,axis=1).T

    for ind,row in B.iterrows():
        ax.bar(x=row['x'],height=row['y'],color=row['color'],width=bar_width,edgecolor='black')

    ax.set_xticks(range(0,len(muts)))
    ax.set_xticklabels(muts)


def rc(b):
    RC = {'A':'T','C':'G','G':'C','T':'A'}
    return RC[b]