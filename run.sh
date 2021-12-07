#!/bin/sh
chmod +x run.sh
echo Launching AnyStatus...
pip3 install -r requirements.txt
clear
python3 main.py
