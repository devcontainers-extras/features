#!/bin/bash
set -e

source dev-container-features-test-lib

check "hexyl is not installed" bash -c '! command -v hexyl'

reportResults
