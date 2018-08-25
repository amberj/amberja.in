#!/bin/bash

simple_blue_echo() {
    echo -e "\x1b[1;34m$MESSAGE\e[0m"
}

MESSAGE="Running: 'rm *.html'" ; simple_blue_echo
rm  *.html

# Create HTML file that is needed by Google Search Console for verification of site ownership:
MESSAGE="Creating google419a0be1d1b0767d.html for Google Search Console verification" ; simple_blue_echo
echo "google-site-verification: google419a0be1d1b0767d.html" > google419a0be1d1b0767d.html

MESSAGE="Running: 'rm blog/*.html'" ; simple_blue_echo
rm blog/*.html

MESSAGE="Running: 'git pull'" ; simple_blue_echo
git pull

MESSAGE="Running: 'make'" ; simple_blue_echo
make

