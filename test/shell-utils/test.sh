#!/bin/bash
set -e

source dev-container-features-test-lib

check "rg version" rg --version
check "batcat version" batcat --version
check "fdfind version" fdfind --version
check "fzf version" fzf --version
check "delta version" delta --version
check "exa version" exa --version
check "difft version" difft --version
check "hexyl version" hexyl --version

reportResults
