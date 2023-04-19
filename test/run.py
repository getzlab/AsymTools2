import asymtools as asym
import pandas as pd
from capy.mut import standardize_maf

from asymtools.annot import *
from asymtools.plotting import *

# Load and annotate maf file
# Example LUAD maf can be downloaded from https://gdc.cancer.gov/about-data/publications/luad_2014
m = preprocess_maf('test/AN_TCGA_LUAD_PAIR_capture_freeze_FINAL_230.aggregated.capture.tcga.uuid.curated.somatic.maf')

# Plot asymmetries of mutation counts
twin_bar_txplot(m)
twin_bar_repplot(m)

# Plot with correction of exome content in mutations/Mb
twin_bar_txplot(m,normalization='exome')
twin_bar_repplot(m,normalization='exome')

# In addition to the matplotlib axes, the plotting functions can also return a dataframe with the plotted values
ax,res = twin_bar_repplot(m,normalization='exome')
print(res[1].head())

# The columns are as follows
# n1/n2 - mutation counts
# r1/r2 - mutation rates per megabase (if using rates)
# ratio - the log2 ratio


plt.show()