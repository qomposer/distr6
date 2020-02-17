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
 - name: Department of Statistical Science, University College London, Gower Street, London WC1E 6BT, United Kingdom
   index: 1
 - name: Shell
   index: 2
date: 17 February 2020
bibliography: paper.bib
---

# Summary

The two gold-standard ways of interacting with probability distributions in `R` [@packageR] is with the `d/p/q/r` functions in the ``stats`` [@packageR] package or with distributions as objects in the `distr` [@packagedistr] family of packages. ``distr6`` officially upgrades ``distr`` by using the state-of-the-art `R6` [@packageR6] object-oriented paradigm. It enables probability distributions to be used as objects, which is fundamental for probabilistic machine learning.

``distr6`` makes use of novel ways to implement tried and tested design patterns [@Gamma1996] to implement a clean, unified, extensible, and scalable interface for probability distributions. 42 probability distributions, with a further 11 kernels, are currently implemented, with many more in development. As well as these distributions, ``distr6`` allows extensions in the form of wrappers that can scale, truncate, or huberize distributions, and compositions such as mixtures and products.

``distr6`` is currently being used in `mlr3proba` [@packagemlr3proba], which uses machine learning to predict probability distributions. Additional uses of ``distr6`` include sampling, and analysis of custom distributions via method imputation and visualisation.

The speed and efficiency of ``R6``, combined with its scalability, allows ``distr6`` to be a complete interface for interacting with probability distributions as objects. ``distr6`` has the ambitious long-term goal of implementing all probability distributions defined throughout ``R``.

Related software includes the `distr` [@packagedistr] family of packages, which uses the S4 object-oriented paradigm, `distributions3` [@packagedistributions3], which uses S3, and `Distributions.jl` [@packagedistributions], which is implemented in ``Julia``. ``distr6`` was developed alongside the authors of ``distr``.

# Key Design Principles

As `distr6` upgrades the `distr` family of packages, which has been available for over a decade, extensive discussions were had with the `distr` authors in order to learn from the experience of `distr` to provide the best possible user-journey in `distr6`. Therefore `distr6` adheres to the following design principles:

1. **Unified design interface** - Every implemented distribution/kernel as well as any custom distribution built by the user, has an identical interface. This helps make the package easy to navigate and the documentation simple to read.
2. **Separation of analytical and numerical results** - Implemented distributions only contain analytical results by default. Decorators [@Gamma1996] are used so that numerical results can be imputed if analytical ones are unavailable. This allows users to guarantee precision of results, and to allow a choice of imputation methods.
3. **Inheritance but not over-inheritance** - Learning from the design choices of `distr`, `distr6` implements relatively few abstract classes for a simple inheritance structure. Deocorators, adaptors, and compositors [@Gamma1996] are used to prevent over-inheritance, which with many distributions can lead to a complicated and messy class tree. This allows for the interface to be as flexible and scalable as possible.
4. **Full inspection and manipulation of distribution parameters** - `R stats` generally only allows one parameterisation for distributions, despite there often being several choices. `distr6` allows all common parameterisations for every distribution and after construction any parameter can be updated.
5. **Flexible object oriented (OO) paradigms** - `R6` is a new OO paradigm that relatively few packages currently use and it is appreciated that for new users there is a learning curve. Hence the package `R62S3` [@packager62s3] is used to allow users to choose between calling methods with `R6` or `S3`, e.g. for some distribution `d`, both `d$pdf(1)` and `pdf(d, 1)` are possible.

# Key Use-Cases

1. **Constructing and querying probability distributions** - Currently 42 parameteric and non-parametric distributions can be constructed. Each can be queried for common representations, e.g. pdf, cdf, quantile, as well as simulating from the distribution. Additionally, mathematical methods are available, such as mean, variance, kurtosis, and skewness.
2. **Imputing numerical methods for custom user-build distributions** - Users can construct their own probability distributions with `Distribution$new`, decorators can then be used to impute numerical methods and functions. This is useful for understanding and learning properties of new distributions.
3. **Construction of composite distributions** - Wrappers in `distr6` exist for mixture, product, and vector distributions, as well as for truncation and scaling (and several more). Therefore distributions can be arbitrarily complex to serve any use-case.
4. **Probabilistic supervised learning** - `distr6` is used in the probabilistic machine learning package `mlr3proba` [@packagemlr3proba], which uses `distr6` in order to make supervised predictions of probability distributions.
5. **Visualisation** - The `plot` function can be used to visualise the shape of the probability distributions, with a choice of one or multiple representations, including the density, distribution, quantile, survival, hazard, and cumulative hazard function. Additionally the `qqplot` function can compare empirical distributions to any distribution implemented in `distr6`.

# Software Availability

``distr6`` is available on [GitHub](https://github.com/alan-turing-institute/distr6) and [CRAN](https://CRAN.R-project.org/package=distr6). It can either be installed from GitHub using the `devtools` [@packagedevtools] library or directly from CRAN with `install.packages`. The package uses the MIT open-source licence. Contributions, issues, feature requests, and general feedback can all be found and provided on the project [GitHub](https://github.com/alan-turing-institute/distr6). Full tutorials and further details are available on the [project website](https://alan-turing-institute.github.io/distr6/).

# Acknowledgements
We acknowledge contributions from the authors of ``distr``, Prof. Dr. Peter Ruckdeschel and Prof. Dr. Matthias Kohl, as well as a group of interns at UCL: Shen Chen, Jordan Deenichin, Chengyang Gao, Chloe Zhaoyuan Gu, Yunjie He, Xiaowen Huang, Shuhan Liu, Runlong Yu, Chijing Zeng and Qian Zhou.

# References