Source Distributions of Cosmic Shear Surveys in Efficiency Space
================================================================

> **Notice:** This repository contains submodules, so please use
>
>     $ git clone --recurse-submodules REPO
>
> when cloning, or the appropriate git-submodule commands after cloning.

This repository contains all files that were used to produce our paper
[`arXiv:2003.xxxxx`](https://arxiv.org/abs/2003.xxxxx). These are split into

- a Jupyter notebook file ``notebook.ipynb`` that contains computations and
  plots with annotations, and
- a number of ``CosmoSIS v1.6`` configuration files that produce posteriors for
  the various analyses we perform.

> **Notice:** The notebook has not been fully commented yet, so it might be
> hard to follow later sections. We will remedy this as soon as possible.

We are working on the DES Y1 version of the Buzzard catalogue. To follow along,
you will need _either_

- the `Buzzard_v1.9.2_Y1a_pz.fits` photometric redshift catalogue, _or_
- your own catalogue with intrinsic and photometric redshifts.

If you want to adapt our notebook to your own catalogue, please change the
definitions of `z_intr`, `z_phot` and `z_tomo` at the appropriate place to
match your data.

It is possible to run the entire notebook from the command line, by issuing

    # execute notebook
    $ make

in the notebook directory. This will execute the entire notebook from start to
end, and generate all plots in the process. However, if you have not run the
chains at this point, there will be an error when the chain files are loaded.
You can generate the fixed chains with

    # run fixed chains (takes a *very* long time)
    $ make chains

which calls CosmoSIS on all input files in sequence. To generate the chains for
uniform priors, call

    # run chains with uniform priors of X% width
    $ make chains/priors-X.txt

for each uniform prior width required.  After the chains have been computed,
run `make` again to execute the notebook.
