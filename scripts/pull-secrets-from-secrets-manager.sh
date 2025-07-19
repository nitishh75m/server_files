#!/bin/bash

# Set Variables
DEV_SECRET_ARN="arn_of_secret_for_dev"
# Define arrays for multiple output files
DEV_ENV_FILES=("/home/ubuntu/server/backend/.env.dev" "/home/ubuntu/server/backend/.env.dev")

# Function to fetch and store secrets
fetch_and_store_secret() {
    local secret_arn=$1
    # Accept an array of output files
    local -n output_files=$2

    # Fetch secret from AWS Secrets Manager
    SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id "$secret_arn" --query 'SecretString' --output text)

    # Check if retrieval was successful
    if [ $? -ne 0 ]; then
        echo "Failed to retrieve secret: $secret_arn" >&2
        exit 1
    fi

    # Write to each output file in the array
    for output_file in "${output_files[@]}"; do
        # Convert JSON to key=value format and save it
        echo "$SECRET_JSON" | jq -r 'to_entries | map("\(.key)=\(.value|tostring)") | .[]' > "$output_file"
        echo "Secrets stored in $output_file"
    done
}

# Fetch and store dev secrets
fetch_and_store_secret "$DEV_SECRET_ARN" DEV_ENV_FILES