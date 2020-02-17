---
title: 'distr6: The Complete R6 Probability Distributions Interface'
tags:
  - R
  - statistics
  - probability distributions
  - object-oriented
authors:
  - name: Raphael E.B. Sonabend
    orcid: 0000-0001-9225-4654
    affiliation: 1
  - name: Franz J. Kiraly
    affiliation: "1, 2"
affiliations:
 - name: University College London
   index: 1
 - name: Shell
   index: 2
date: 17 February 2020
bibliography: paper.bib
---

# Summary

The two gold-standard ways of interacting with probability distributions in ``R``[@packageR] is with the `d/p/q/r` functions in the ``stats``[@packageR] package or with distributions as objects in the ``distr`` [@packagedistr] family of packages. ``distr6`` upgrades ``distr`` by using the state-of-the-art ``R6`` [@packageR6] object-oriented paradigm. It enables probability distributions to be used as objects, which is fundamental for probabilistic machine learning, its current key use-case.

``distr6`` makes use of novel ways to implement tried and tested design patterns [@Gamma1996] to implement a clean, unified, extensible, and scalable interface for probability distributions. 42 probability distributions, with a further 11 kernels, are currently implemented, with many more in development. As well as these distributions, ``distr6`` allows extensions in the form of wrappers that can scale, truncate, or huberize distributions, and compositions such as mixtures and products. ``distr6`` makes use of the package ``R62S3``[@packager62s3] so that either ``R6`` methods or ``S3`` functions can be used to interact with probability distributions.

``distr6`` is currently being used in ``mlr3proba``[@packagemlr3proba], which uses machine learning to predict probability distributions. Additional uses of ``distr6`` include sampling, and analysis of custom distributions via method imputation and visualisation.

The speed and efficiency of ``R6``, combined with its scalability, allows ``distr6`` to be a complete interface for interacting with probability distributions as object. ``distr6`` has the ambitious long-term goal of implementing all probability distributions defined throughout ``R``.

Related software includes the ``distr``[@packagedistr] family of packages, which uses the S4 object-oriented paradigm, ``distributions3``[@packagedistributions3], which uses S3, and ``Distributions.jl``[@packagedistributions], which is implemented in ``Juia``. ``distr6`` was developed alongside the authors of ``distr``.

# Software Availability

``distr6`` is available on GitHub and [CRAN](https://CRAN.R-project.org/package=distr6). It can either be installed from GitHub using the ``devtools`` library or directly from CRAN with `install.packages`. The package uses the MIT open-source licence. Contributions, issues, feature requests, and general feedback can all be found and provided on the project [GitHub](https://github.com/alan-turing-institute/distr6). Full details are also available on the [project website](https://alan-turing-institute.github.io/distr6/).

# Acknowledgements
We acknowledge contributions from the authors of ``distr``, - Prof. Dr. Peter Ruckdeschel and Prof. Dr. Matthias Kohl, initial design choices influenced by ``Distributions.jl``. As well as a group of interns at UCL: Shen Chen, Jordan Deenichin, Chengyang Gao, Chloe Zhaoyuan Gu, Yunjie He, Xiaowen Huang, Shuhan Liu, Runlong Yu, Chijing Zeng and Qian Zhou.

# References