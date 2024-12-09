#!/bin/bash
qrencode -o /tmp/qrencode.png "$1" && display /tmp/qrencode.png