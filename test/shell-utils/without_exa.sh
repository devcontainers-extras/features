#!/bin/bash
set -e

source dev-container-features-test-lib

check "exa is not installed" bash -c '! command -v exa'

reportResults
