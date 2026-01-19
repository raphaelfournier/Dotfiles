#! /bin/bash

echo "launch the script from a term and switch to the window displaying the QRcode"

sleep 3 

import -silent -window root bmp:- | zbarimg - 2>/dev/null | grep -o "http.*$" | xargs firefox --new-tab
