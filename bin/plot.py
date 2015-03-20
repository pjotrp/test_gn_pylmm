import sys
from pylab import plotfile, show, gca
import matplotlib
import matplotlib.cbook as cbook

fn = sys.argv[1]
print "fn=",fn

matplotlib.rcParams['examples.directory'] = '.'
fname = cbook.get_sample_data(fn,asfileobj=True )

plotfile(fname, ('date', 'pylmm1', 'pylmm2'), subplots=False)

show()
