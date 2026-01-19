#!/usr/bin/python

import collections
import sys
import arrow
from datetime import datetime

def strfdelta(tdelta, fmt):
    d = {"days": tdelta.days}
    d["hours"], rem = divmod(tdelta.seconds, 3600)
    d["minutes"], d["seconds"] = divmod(rem, 60)
    return fmt.format(**d)

def tdeltaToYears(tdelta):
    d = {}
    d["years"], rem = divmod(tdelta.days,365)
    d["days"] = rem
    d["hours"],rem = divmod(tdelta.seconds,3600)
    d["minutes"],d["seconds"] = divmod(rem,60)
    return d

dobarg = sys.argv[1]
maintenant = arrow.utcnow()
dob = arrow.get(dobarg+'T00:00:00.000+02:00')
age = maintenant - dob

# print(strfdelta(age,"Âge: {years} ans"))
print("Âge: {years} ans, {days} jours, {hours} heures, {minutes} minutes et {seconds} secondes".format(**tdeltaToYears(age)))
