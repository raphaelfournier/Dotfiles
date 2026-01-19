#! /bin/bash

# Assign the original filename to the INPUTNAME variable
INPUTNAME=$1

# Use parameter expansion to replace "prof" with "eleve" and assign it to OUTPUTNAME
# The syntax is: ${VARIABLE/PATTERN/REPLACEMENT}
OUTPUTNAME="${INPUTNAME/prof/eleve}"

jupyter nbconvert --to notebook --TagRemovePreprocessor.enabled=True --TagRemovePreprocessor.remove_cell_tags correction --TagRemovePreprocessor.remove_cell_tags exclude --output ${OUTPUTNAME} ${INPUTNAME}
