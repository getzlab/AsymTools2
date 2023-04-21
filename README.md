# AsymTools2

AsymTools is a package for analyzing transcriptional and replicative mutational strand asymmetries in cancer sequencing datasets. Note that currently AsymTools is only compatible with data aligned to hg19.

## Installation

#### Preqs

Install CApy
```
git clone git@github.com:getzlab/CApy.git
cd CApy
pip install -e .
```

Then install AsymTools
```
git clone git@github.com:getzlab/AsymTools2.git
cd AsymTools2
pip install -e .
```

## Example usage
```
from asymtools.annot import *
from asymtools.plotting import *

# Load and annotate maf file
# An example lung cancer maf can be downloaded from https://gdc.cancer.gov/about-data/publications/luad_2014
m = preprocess_maf('test/AN_TCGA_LUAD_PAIR_capture_freeze_FINAL_230.aggregated.capture.tcga.uuid.curated.somatic.maf')

# Plot asymmetries of mutation counts
twin_bar_txplot(m)
twin_bar_repplot(m)

# Plot with correction of genomic content in mutations/Mb
# Choose 'exome' or 'genome' as appropriate
twin_bar_txplot(m,normalization='exome')
twin_bar_repplot(m,normalization='exome')

# In addition to the matplotlib axes, the plotting functions can also return a dataframe with the plotted values
# The columns summarize for each mutation type the total counts (n1,n2), normalized rates if using (r1,r2), and ratio of complementary mutations (ratio)
ax,res = twin_bar_repplot(m,normalization='exome')
print(res[1].head())


plt.show()

```

## Citation

If you use AsymTools in your work, please cite the original publication:
> Mutational Strand Asymmetries in Cancer Genomes Reveal Mechanisms of DNA Damage and Repair
>
> Haradhvala N.J., Polak P. et al., _Cell_ 2016 Jan 21. doi: [10.1016/j.cell.2015.12.050](https://doi.org/10.1016/j.cell.2015.12.050)

