#! /bin/bash

loimpress --headless --convert-to pdf $1
zathura ~/attachment.pdf

