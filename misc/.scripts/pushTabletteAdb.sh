#! /bin/bash
for i in "$@"
do
  echo "pushing $i to /Removable/MicroSD/"
  adb push $i /Removable/MicroSD/
done
