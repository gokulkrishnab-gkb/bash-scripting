#!/bin/bash

# Define the base directory
BASE_DIR="/home/kousik/Madgraph/MG5_aMC_v3_1_1"

# Define the source folder and file
SOURCE_FOLDER="${BASE_DIR}/higgs_composite_10_2000/Cards"
SOURCE_FILE="${SOURCE_FOLDER}/run_card.dat"

# Loop through each target folder
for FOLDER in ${BASE_DIR}/higgs_composite_10_*; do
    if [[ -d "$FOLDER" && "$FOLDER" != "${BASE_DIR}/higgs_composite_10_2000" ]]; then
        TARGET_FOLDER="${FOLDER}/Cards"
        TARGET_FILE="${TARGET_FOLDER}/run_card.dat"

        # Check if the target directory exists
        if [[ -d "$TARGET_FOLDER" ]]; then
            echo "Replacing ${TARGET_FILE} in ${TARGET_FOLDER}"
            cp -f "$SOURCE_FILE" "$TARGET_FILE"
        else
            echo "Directory ${TARGET_FOLDER} does not exist. Skipping."
        fi
    fi
done

echo "Operation completed."

