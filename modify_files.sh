#!/bin/bash

# Define the base directory and base folder name
base_dir="/home/kousik/Madgraph/MG5_aMC_v3_1_1/models"
base_folder="HC_F_10_"

# Loop over the desired range of folders
for i in $(seq 2000 10 3000); do
    # Define the current folder path
    folder="${base_dir}/${base_folder}${i}"
    
    # Define the value for m1/m2 and ga1/ga2 based on the folder name
    m_value=${i}
    ga_value=$(echo "scale=1; $i/10" | bc)

    # Modify write_param_card.py
    write_param_file="${folder}/write_param_card.py"
    sed -i "161s/value=[0-9]*\.[0-9]*/value=${m_value}.0/" "$write_param_file"
    sed -i "162s/value=[0-9]*\.[0-9]*/value=${m_value}.0/" "$write_param_file"
    sed -i "163s/value=[0-9]*\.[0-9]*/value=${ga_value}/" "$write_param_file"
    sed -i "164s/value=[0-9]*\.[0-9]*/value=${ga_value}/" "$write_param_file"

    # Copy the modified lines from write_param_card.py to parameters.py without leading/trailing spaces
    params_file="${folder}/parameters.py"
    line161=$(sed -n '161p' "$write_param_file" | sed 's/^[ \t]*//;s/[ \t]*$//')
    line162=$(sed -n '162p' "$write_param_file" | sed 's/^[ \t]*//;s/[ \t]*$//')
    line163=$(sed -n '163p' "$write_param_file" | sed 's/^[ \t]*//;s/[ \t]*$//')
    line164=$(sed -n '164p' "$write_param_file" | sed 's/^[ \t]*//;s/[ \t]*$//')

    sed -i "499s/.*/$line161/" "$params_file"
    sed -i "500s/.*/$line162/" "$params_file"
    sed -i "501s/.*/$line163/" "$params_file"
    sed -i "502s/.*/$line164/" "$params_file"

    # Delete lines 509-512 in parameters.py
    sed -i '509,512d' "$params_file"

    # Modify restrict_default.dat
    restrict_file="${folder}/restrict_default.dat"
    sed -i "59s/[0-9]*\.[0-9]*/${m_value}.0/" "$restrict_file"
    sed -i "60s/[0-9]*\.[0-9]*/${m_value}.0/" "$restrict_file"
    sed -i "61s/[0-9]*\.[0-9]*/${ga_value}/" "$restrict_file"
    sed -i "62s/[0-9]*\.[0-9]*/${ga_value}/" "$restrict_file"

    echo "Modified files in $folder"
done

echo "All modifications completed."

