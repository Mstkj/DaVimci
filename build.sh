#!/bin/bash -x

# Would you like to start a new writing project?
# where do you want to save it?
# what would you like to call it?

# the following command should symlink the DaVimci git clone to the target project directory

# cp and touch project files in destination
# setup citation styles and formatting

echo "where would you like your project to be generated?"
echo "$PWD"
read REPLY
echo "$REPLY"

# create project folder
# locate davimci install location and symlink resources to project folder
# copy csl, css, metadata.xml, references.bib, and defaults.yaml to project folder

exit 0
