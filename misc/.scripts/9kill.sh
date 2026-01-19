#! /bin/bash
echo "killing $1"
app="pgrep $1"
foo=$(eval $app)
kill -9 $foo
