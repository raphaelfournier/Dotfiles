import vcaltasks as vcal
import sys

calendar = vcal.parse("/home/raph/.local/share/evolution/tasks/system/tasks.ics")

for t in calendar.events:
#  print(t.event_attributes())
#  for attr in t.event_attributes():
#    sys.stdout.write("%s "%(t.event_attributes()[0]))
  if 'priority' in t.event_attributes():
    sys.stdout.write("%s "%(t.priority))
#  if 'status' in t.event_attributes():
#    sys.stdout.write("%s "%(t.status))
  if 'due' in t.event_attributes():
    sys.stdout.write("%s "%(t.due))
  sys.stdout.write("%s "%(t.summary))
#  if 'categories' in t.event_attributes():
#    sys.stdout.write("%s "%(" ".join(t.categories)))
#    sys.stdout.write("-- %s \n"%(t.due," ".join(t.dtstamp)))
  sys.stdout.write("\n")
