#!/bin/bash
set -e

source dev-container-features-test-lib

check "fdfind is not installed" bash -c '! command -v fdfind'

reportResults
