#!/bin/bash

./check_env.sh
if [ $? -ne 0 ]; then
  echo "ERROR: Environment check failed. Exiting."
  exit 1
fi

export AWS_DEFAULT_REGION="us-east-2"

./apply_phase_1.sh
./apply_phase_2.sh
./apply_phase_3.sh
