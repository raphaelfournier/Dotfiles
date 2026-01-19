#! /bin/bash

echo $1 | sed "s:fee.*$::" | xargs firefox
