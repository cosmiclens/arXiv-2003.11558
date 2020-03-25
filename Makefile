COSMOSIS ?= cosmosis

.PHONY: all chains test clean

all:
	jupyter nbconvert --to notebook --execute --inplace --ExecutePreprocessor.timeout=None notebook.ipynb

chains: chains/intr.txt chains/phot.txt chains/para.txt

chains/intr.txt: cosmosis/analyse-intr.ini cosmosis/params.ini cosmosis/values.ini data/number_density_params.ini data/simulated.fits
	$(COSMOSIS) $<

chains/phot.txt: cosmosis/analyse-phot.ini cosmosis/params.ini cosmosis/values.ini data/number_density_params.ini data/simulated.fits
	$(COSMOSIS) $<

chains/para.txt: cosmosis/analyse-para.ini cosmosis/params.ini cosmosis/values.ini data/number_density_params.ini data/simulated.fits
	$(COSMOSIS) $<

chains/priors-%.txt: cosmosis/analyse-priors.ini data/priors-%.ini cosmosis/params.ini cosmosis/values-for-priors.ini data/number_density_ranges.ini data/simulated.fits
	PRIORS=$(notdir $(basename $@)) $(COSMOSIS) $<

data/simulated.fits: cosmosis/simulate.ini cosmosis/values.ini | cosmosis/params.ini data/number_density_params.ini data/redshift_distributions.fits
	$(COSMOSIS) $<

data/redshift_distributions.fits data/number_density_params.ini data/number_density_ranges.ini:
	@echo "Please use the notebook to generate redshift distributions and config files."
	@exit 1

test: cosmosis/test-para.ini cosmosis/params.ini cosmosis/values.ini data/number_density_params.ini data/simulated.fits
	$(COSMOSIS) $<

clean:
	$(RM) data/redshift_distributions.fits data/simulated.fits
	$(RM) data/*.ini
	$(RM) chains/*.txt
	$(RM) plots/*.pdf
