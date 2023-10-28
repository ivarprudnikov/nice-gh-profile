#!/bin/bash

# This script creates 14 empty commits for each month of the year

# change the starting date
START_DATE=${1:-"2023-01-01"}

OS=$(uname -s)
if [ "$OS" != "Darwin" ]; then
    echo "This script is only for macOS due to 'date' command usage"
    exit 1
fi

# for every month
for month in {1..12}; do
    # run 14 times
    for day in {0..13}; do
        # create a modified date from the initial value
        # -j means do not set the date
        # -u means use UTC
        # -Iseconds means use ISO 8601 format in the output
        # -v means modify the given date
        # -f means use the given format for the input
        # -v13d sets to the 13 day of the month but -v0w then moves it to the Sunday
        commit_date=$(date -ju -Iseconds -v"$month"m -v13d -v0w -v6H -v0M -v0S -v +"$day"d -f "%Y-%m-%d" "$START_DATE")
        echo "$commit_date"
        # create an empty commit with that date
        # it should paint 2 vertical rows of commits in each month in GitHub profile
        git commit --allow-empty -m "yay" --date="$commit_date"
    done
done
