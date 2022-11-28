#!/bin/bash
set -e

source dev-container-features-test-lib

check "fzf is not installed" bash -c '! command -v fzf'

reportResults
