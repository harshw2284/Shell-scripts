
<<readme

Create strict_demo.sh with set -euo pipefail at the top
Try using an undefined variable — what happens with set -u?
Try a command that fails — what happens with set -e?
Try a piped command where one part fails — what happens with set -o pipefail?


Document: What does each flag do?
set -e → exit immediately on any command failure
set -u → treat undefined variables as errors
set -o pipefail → catch failures anywhere in a pipeline

readme

#!/bin/bash

set -euo pipefail

echo "Demo of strict mode"

# 1. Undefined variable (set -u)
echo "Username is $username"

# 2. Command failure (set -e)
echo "Trying to list a non-existing file"
ls fakefile

# 3. Pipeline failure (set -o pipefail)
echo "Testing pipeline failure"
cat fakefile | grep hello

echo "This line will never execute"
