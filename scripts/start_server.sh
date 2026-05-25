#!/bin/bash

cd /home/ubuntu/flaskapp

nohup python3 app.py > output.log 2>&1 &