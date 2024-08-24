#!/bin/bash

# Define the source directory and the base name for the copies
src_dir="/home/kousik/Madgraph/MG5_aMC_v3_1_1/models/HC_F_10_2000"
dest_base="/home/kousik/Madgraph/MG5_aMC_v3_1_1/models/HC_F_10_"

# Loop over the desired range and create copies
for i in $(seq 2010 10 3000); do
    dest_dir="${dest_base}${i}"
    cp -r "$src_dir" "$dest_dir"
    echo "Copied to $dest_dir"
done

echo "All copies completed."

