#! /bin/bash

image=$1
output=twitter-$image

convert $image -virtual-pixel white -set option:distort:viewport "%[fx:w]x%[fx:w/1.83]-%[fx:0]-%[fx:((w/1.83)-h)/2]" -filter point -distort SRT 0  +repage $output

echo "$image converted to $PWD/Twitter/$output"
