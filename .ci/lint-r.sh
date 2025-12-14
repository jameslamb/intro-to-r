#!/bin/bash

set -e -u -o pipefail

CRAN_MIRROR="https://cloud.r-project.org/"

Rscript \
    --vanilla \
    -e "install.packages('lintr', repos = '${CRAN_MIRROR}', dependencies = c('Depends', 'Imports', 'LinkingTo'))"

Rscript .ci/lint-r-code.R
