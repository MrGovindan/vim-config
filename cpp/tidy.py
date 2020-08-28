commands_file = open("compile_commands.json", "r")
commands_contents = commands_file.read()
commands_file.close()

import os
import re

current_directory = os.getcwd()
print(current_directory)

matches = re.findall(r"command.*", commands_contents)

checks = "-checks=readability-*,performance-*,modernize-*,-modernize-use-trailing-return-type,bugprone-*,boost-*,portablity-*"

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

    if (current_directory + "/src" in filename):
        print("Checking " + filename)
    elif (current_directory + "/include" in filename):
        print("Checking " + filename)
    else:
        print("Skipping " + filename)
        continue

    tidy_command = "clang-tidy " + filename + " " + checks + " -- "+ includes
    result = os.popen(tidy_command).read()
    if (len(result) > 0):
        print(result)
