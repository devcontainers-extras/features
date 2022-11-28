#!/bin/bash
set -e

source dev-container-features-test-lib

check "delta is not installed" bash -c '! command -v delta'

reportResults
