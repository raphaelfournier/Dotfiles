#! /bin/bash
du -sh $1/* | sort -hr | head -n15
