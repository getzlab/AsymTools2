# AsymTools2

## Installation

#### Preqs

Install CApy

Then install AsymTools
```
pip install -e .
```

## Example usage
```
from capy.mut import standardize_maf

from asymtools.annot import *
from asymtools.plotting import *
m = pd.read_csv('test/LUAD.maf',sep='\t')
m = standardize_maf(m)

m = m.sort_values(['chr','pos']).reset_index(drop=True)
annotate_tx_strand(m)

twin_bar_txplot(m)

plt.show()

```

