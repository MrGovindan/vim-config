commands_file = open("compile_commands.json", "r")
commands_contents = commands_file.read()
commands_file.close()

import re
import os

matches = re.findall(r"command.*", commands_contents)

checks = "-checks=readability-*,performance-*,modernize-*,bugprone-*,boost-*,portablity-*"

for match in matches:
    parts = match.split(" ")
    includes = "-std=c++14 -x c++ -I/usr/include/c++/9"
    for part in parts:
        if (part.startswith("-I")):
            includes += " " + part
    filename = parts[len(parts) - 1]
    filename = filename[0:-2]

    if ("test" in filename):
        print("Skipping " + filename)
        continue

    print("Checking " + filename)
    tidy_command = "clang-tidy " + filename + " " + checks + " -- "+ includes
    result = os.popen(tidy_command).read()
    if (len(result) > 0):
        print(result);
