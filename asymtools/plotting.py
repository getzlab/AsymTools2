import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

MUT_COLORS = {'A>C': [0, 0.2, 0.8],
              'A>G': [0.1, 0.8, 0.1],
              'A>T': [0.5, 0.3, 0.7],
              'C>A': [0, 0.7, 0.7],
              'C>G': [1, 0, 0],
              'C>T': [1, 1, 0]}

def twin_bar_txplot(m):

    m['mut'] = m['ref_allele'] + '>' + m['newbase']

    # Count 12 mutation types x 3 strand categories (unknown, plus, minus)
    X = pd.crosstab(m['mut'],m['txplus'] + 2*m['txminus'])

    titles = ['Genome-wide', 'Tx (+)', 'Tx (-)']

    twin_bar_plot(X, titles)

def twin_bar_repplot(m):
    m['mut'] = m['ref_allele'] + '>' + m['newbase']

    # Count 12 mutation types x 3 strand categories (unknown, plus, minus)
    X = pd.crosstab(m['mut'],m['is_left'] + 2*m['is_right'])
    titles = ['Genome-wide', 'Left-replicating', 'Right-replicating']

    twin_bar_plot(X,titles)

def twin_bar_plot(X,titles):

    f,ax = plt.subplots(2,3,figsize=(10,4),gridspec_kw={'height_ratios':[1,.4]})

    data_to_plot = [X.sum(axis=1),X.iloc[:,1],X.iloc[:,2]]

    for i in range(0,len(data_to_plot)):
        twin_bar_counts_plot(data_to_plot[i], ax[0, i])
        ax[0, i].set_title(titles[i])

        asym_ratios_plot(data_to_plot[i], ax=ax[1, i])


    ax[0,0].set_ylabel('# Mutations')
    ax[1,0].set_ylabel('Log$_2$ ratio')

    plt.tight_layout()

def get_plot_df(x):
    i = 0
    df = list()
    for ref in 'AC':
        for newbase in 'ACGT'.replace(ref, ''):
            name = f'{ref}>{newbase}'
            rc_name = f'{rc(ref)}>{rc(newbase)}'

            df.append(pd.Series({'name':name,'x':i,'n1':x.loc[name],'n2':x.loc[rc_name],'color':MUT_COLORS[name]}))

            i += 1
    df = pd.concat(df,axis=1).T
    return(df)

def twin_bar_counts_plot(x, ax):

    bar_offset = .2
    bar_width=.4

    B = get_plot_df(x)

    for ind,row in B.iterrows():
        ax.bar(x=row['x']-bar_offset,height=row['n1'],color=row['color'],width=bar_width,edgecolor='black')
        ax.bar(x=row['x']+bar_offset, height=row['n2'], color=row['color'], width=bar_width, edgecolor='black')

    ax.set_xticks(range(0,B.shape[0]))
    ax.set_xticklabels(B['name'])

def asym_ratios_plot(x,ax):
    B = get_plot_df(x)

    for ind, row in B.iterrows():
        ax.bar(x=row['x'], height=np.log2(row['n1']/row['n2']), color=row['color'], edgecolor='black')
    ax.set_ylim(-1,1)

def rc(b):
    RC = {'A':'T','C':'G','G':'C','T':'A'}
    return RC[b]