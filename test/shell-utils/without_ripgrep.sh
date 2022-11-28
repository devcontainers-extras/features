#!/bin/bash
set -e

source dev-container-features-test-lib

check "ripgrep is not installed" bash -c '! command -v rg'

reportResults
