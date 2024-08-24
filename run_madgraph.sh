#!/bin/bash

# Base directory
base_dir="/home/kousik/Madgraph/MG5_aMC_v3_1_1"

# Iterate over the folders
for folder in "$base_dir"/higgs_composite_10_*; do
    # Path to the run_card.dat file
    run_card="$folder/cards/run_card.dat"
    
    if [[ -f "$run_card" ]]; then
        # Create a temporary file
        temp_file=$(mktemp)
        
        # Process the file and replace the specified lines
        awk '
            NR == 35 { print "7000.0     = ebeam1  ! beam 1 total energy in GeV"; next }
            NR == 36 { print "7000.0     = ebeam2  ! beam 2 total energy in GeV"; next }
            NR == 100 { print "25.0  = ptb       ! minimum pt for the b"; next }
            NR == 101 { print "25.0  = ptl       ! minimum pt for the charged leptons"; next }
            NR == 112 { print "2.5  = etab    ! max rap for the b"; next }
            NR == 113 { print "2.5  = etal    ! max rap for the charged leptons"; next }
            NR == 124 { print "3.0  = drbbmax ! max distance between b's"; next }
            NR == 125 { print "3.0  = drllmax ! max distance between leptons"; next }
            NR == 126 { print "3.0  = drblmax ! max distance between b and lepton"; next }
            { print }
        ' "$run_card" > "$temp_file"
        
        # Replace the original file with the modified one
        mv "$temp_file" "$run_card"
        
        echo "Updated $run_card"
    else
        echo "$run_card not found"
    fi
done

