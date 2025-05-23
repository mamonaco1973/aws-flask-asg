#!/bin/bash

export AWS_DEFAULT_REGION=us-east-2

./build/check_env.sh
if [ $? -ne 0 ]; then
  echo "ERROR: Environment check failed. Exiting."
  exit 1
fi

export AWS_DEFAULT_REGION="us-east-2"

./build/apply_phase_1.sh
./build/apply_phase_2.sh
./build/apply_phase_3.sh

echo "NOTE: Validating Build"
./validate.sh

