#! /usr/bin/python
import subprocess
import re

a = subprocess.run(["xinput", "list"], stdout=subprocess.PIPE)

lines = a.stdout.split(b'\n')

# print("Here are the keyboard lines from xinput list:")

for line in lines:
    s = str(line)
    # if "keyboard" in s:
        # print(s)
    # trying to float internal laptop keyboard
    if "AT" in s:
        m = re.search('(?<=id=)[0-9]+', s)
        ids = m.group(0)
        m2 = re.search('slave *keyboard [(]([0-9+]+)[)]', s)
        master = ''
        if m2:
            master = m2.group(1)
        # print("id=",ids, "master =", master)
        else:
            print("master missing")

# ans = input("do you want to float keyboard "+ids+" from Master "+master+"? (o/n) ")
print("xinput float",ids)
print("xinput reattach", ids, master)

exit(0)

if ans == "o":
    print("xinput float "+ids)
    subprocess.run(["xinput float "+ids])
    print("keyboard "+ids+" is now floating")
else:
    print("good bye")
    exit(0)



