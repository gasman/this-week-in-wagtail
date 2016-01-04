#!/bin/sh

# This script takes a start date and will print any contributors whose first commit happened after that date.

# Based on https://github.com/cmr/this-week-in-rust/blob/2c4558b138e9d957745c3c8f98d8f73076aca140/new_contribs.sh
# Copyright 2014 Corey Richardson, made available under the MIT license.
# Modified for use in "This week in Wagtail"


INITIAL_COMMIT=679f158
START_COMMIT=`git log --before="$1" --pretty=format:%H|head -n1`
ALL_NAMES=`git log $INITIAL_COMMIT.. --pretty=format:%an|sort|uniq`
OLD_NAMES=`git log $INITIAL_COMMIT..$START_COMMIT --pretty=format:%an|sort|uniq`
echo "$OLD_NAMES">names_old.txt
echo "$ALL_NAMES">names_all.txt
names=`diff names_old.txt names_all.txt`
rm names_old.txt names_all.txt
names=`echo "$names" | grep \> | sed 's/^>/*/'`
echo "$names"

