#! /bin/env python
import urllib.parse
import sys

encodedUrl = sys.argv[1]
decodedUrl = urllib.parse.unquote(encodedUrl)
print(decodedUrl)
