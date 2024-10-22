#!/bin/bash

while getopts c: flag
do
    case "${flag}" in
        c) toExec=${OPTARG};;
    esac
done

sudo -u jacksanders $toExec > /home/jacksanders/.scripts/test123
