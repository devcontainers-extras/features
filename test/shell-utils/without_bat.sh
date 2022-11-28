#!/bin/bash
set -e

source dev-container-features-test-lib

check "batcat is not installed" bash -c '! command -v batcat'

reportResults
