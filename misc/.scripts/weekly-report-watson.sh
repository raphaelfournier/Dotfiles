#! /bin/bash
watson report | head -n1

echo "temps compté dans watson"
watson report | grep ^Total
echo ""

echo "temps personnel et errand"
watson report -T personal -T errand  | grep ^Total
echo ""

echo "temps recherche"
watson report -T recherche -T scorelib  | grep ^Total
echo ""

echo "temps enseignement"
watson report -T enseignement  | grep ^Total
echo ""

echo "temps réunions"
watson report -T meetings  | grep ^Total
echo ""
