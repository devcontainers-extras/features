#!/bin/bash
set -e

source dev-container-features-test-lib

check "difft is not installed" bash -c '! command -v difft'

reportResults
