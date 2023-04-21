import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

from asymtools.territory import get_territory

# Colors used for plotting different mutation types
MUT_COLORS = {'A>C': [0, 0.2, 0.8],
              'A>G': [0.1, 0.8, 0.1],
              'A>T': [0.5, 0.3, 0.7],
              'C>A': [0, 0.7, 0.7],
              'C>G': [1, 0, 0],
              'C>T': [1, 1, 0]}


def twin_bar_txplot(m,normalization='counts'):
    """
    Make twin bar plots split by transcription direction
    :param m: preprocessed maf as pandas dataframe
    :param normalization: type of normalization to use. Can be any of counts, exome (wxs), genome (wgs)
    :returns:
        - ax - matplotlib axes with plots
        - data - list of pandas dataframes with plotted data
    """
    m['mut'] = m['ref_allele'] + '>' + m['newbase']

    # Count 12 mutation types x 3 strand categories (unknown, plus, minus)
    X = pd.crosstab(m['mut'],m['txplus'] + 2*m['txminus'])

    titles = ['Genome-wide', 'Tx (+)', 'Tx (-)']

    # 4 bases x 3 strand categories
    N = get_territory(type=normalization,stratification='tx')
    if N is not None:
        npat = m['patient'].nunique()
        N = N* npat

    ax,data = twin_bar_trio(X, titles, N=N)

    return(ax,data)


def twin_bar_repplot(m,normalization='counts'):
    """
    Make twin bar plots split by replication direction
    :param m: preprocessed maf as pandas dataframe
    :param normalization: type of normalization to use. Can be any of counts, exome (wxs), genome (wgs)
    :returns:
        - ax - matplotlib axes with plots
        - data - list of pandas dataframes with plotted data
    """
    m['mut'] = m['ref_allele'] + '>' + m['newbase']
    # Count 12 mutation types x 3 strand categories (unknown, plus, minus)
    X = pd.crosstab(m['mut'],m['is_left'] + 2*m['is_right'])
    titles = ['Genome-wide', 'Left-replicating', 'Right-replicating']

    # 4 bases x 3 strand categories
    N = get_territory(type=normalization,stratification='rep')
    if N is not None:
        npat = m['patient'].nunique()
        N = N* npat

    ax,data = twin_bar_trio(X, titles, N=N)

    return(ax,data)


def twin_bar_trio(X, titles, N=None):
    """
    Makes a trio of twin bar plots
    :param X: 12 x 3 pandas dataframe of mutation counts for each of 12 mutation types for each of the three plots
    :param titles: lists of titles for each plot
    :param N: 4 x 3 pandas dataframe with genomic territories for each plot
    :returns:
        - ax - matplotlib axes with plots
        - data - list of pandas dataframes with plotted data
    """

    f,ax = plt.subplots(2,3,figsize=(10,4),gridspec_kw={'height_ratios':[1,.4]})

    # Counts for each panel
    ns = [X.sum(axis=1),X.loc[:,1],X.loc[:,2]]

    if N is not None:
        Ns = [N.sum(axis=1),N.loc[:,1],N.loc[:,2]]


    data = list()
    for i in range(0,len(ns)):

        if N is not None:
            # Rates
            B = get_plot_df(ns[i],Ns[i])
        else:
            # Counts
            B = get_plot_df(ns[i])

        twin_bar_plot_top(B, ax[0, i])
        ax[0, i].set_title(titles[i])

        asym_ratios_plot(B, ax=ax[1, i])

        data.append(B)


    if N is None:
        ax[0,0].set_ylabel('# Mutations')
    else:
        ax[0, 0].set_ylabel('Mutations/Mb')
    ax[1,0].set_ylabel('Log$_2$ ratio')

    plt.tight_layout()

    return(ax,data)

# Helper function to create dataframe with data to be plotted
# x is a pandas series with counts for all 12 mutation types (A>C,A>G,...,)
# N is a pandas series with the genomic territory for that mutation (if using rates)
def get_plot_df(x,N=None):
    """
    Organizes data into a pandas dataframe for plotting
    :param x: pandas series with counts for the 12 mutation types
    :param N: pandas series with genomic territory counts for A,C,G,T
    :return: pandas dataframe with plotting data
    """
    i = 0
    df = list()

    # For each mutation type, compile counts (and territory if using rates)
    for ref in 'AC':
        for newbase in 'ACGT'.replace(ref, ''):
            name = f'{ref}>{newbase}'
            rc_name = f'{rc(ref)}>{rc(newbase)}'
            s = pd.Series({'name':name,'x':i,'n1':x.loc[name],'n2':x.loc[rc_name],'color':MUT_COLORS[name]})
            if N is not None:
                s.loc['N1'] = N.loc[ref]
                s.loc['N2'] = N.loc[rc(ref)]
            df.append(s)

            i += 1
    df = pd.concat(df,axis=1).T

    for f in ['n1','n2']:
        df[f] = df[f].astype(int)
    if N is not None:
        for f in ['N1','N2']:
            df[f] = df[f].astype(int)


    # For each bar pair, determine values to plot
    for i in [1, 2]:

        # If we're plotting rates
        if N is not None:
            # Calculate rates in mutations/Mb

            df[f'r{i}'] = df[f'n{i}']/df[f'N{i}'] * 1e6

            # Calculate error
            df[f'r{i}_sd'] = np.sqrt(df[f'n{i}'])/df[f'N{i}'] * 1e6

        else:
            # Otherwise we're using counts
            df[f'r{i}'] = df[f'n{i}']
            df[f'r{i}_sd'] = np.sqrt(df[f'n{i}'])


    df['ratio'] = df['r1']/df['r2']

    # Normal approximation
    df['ratio_sd'] = df['r1']/df['r2']*np.sqrt(df['r1_sd']**2/df['r1']**2 + df['r2_sd']**2/df['r2']**2)

    df['logratio'] = np.log2(df['ratio'])

    return(df)

def twin_bar_plot_top(B, ax):
    """Plots top part of twin bar plot"""
    bar_offset = .2
    bar_width=.4

    # For each pair of complementary mutation types
    for ind,row in B.iterrows():
        # For each individual mutation type
        for (x,y,err) in [(row['x']-bar_offset,row['r1'],row['r1_sd']),
                      (row['x']+bar_offset,row['r2'],row['r2_sd'])]:

            ax.bar(x=x,height=y,yerr=err,capsize=10*bar_width,
               color=row['color'],width=bar_width,edgecolor='black')

    ax.set_xticks(range(0,B.shape[0]))
    ax.set_xticklabels(B['name'])

# Creates bottom of twin-bar plot
def asym_ratios_plot(B,ax,min_ylim=1):
    """Plots bottom part of twin bar plot"""
    for ind, row in B.iterrows():

        # Determine how to draw error bars in log space
        lerr =  np.abs(np.log2(row['ratio'] - row['ratio_sd']) - row['logratio'])
        uerr = np.log2(row['ratio'] + row['ratio_sd']) - row['logratio']
        err = np.array([lerr,uerr]).reshape(-1,1)

        ax.bar(x=row['x'], height=row['logratio'],yerr=err,capsize=4, color=row['color'], edgecolor='black')
        ax.axhline(0,color='k',linewidth=1)

    # Determine how to set ylims
    max_ratio = np.abs(B['logratio']).max()
    lim = np.maximum(min_ylim,max_ratio)
    ax.set_ylim(-1*lim,lim)

def rc(b):
    """Returns reverse compmlement of base"""
    RC = {'A':'T','C':'G','G':'C','T':'A'}
    return RC[b]